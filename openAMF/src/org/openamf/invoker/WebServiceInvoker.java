/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import java.io.File;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.axis.client.Service;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.ProjectHelper;
import org.openamf.ServiceRequest;

/**
 * @author Adrian Roston <akroston@users.sourceforge.net >
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.26 $, $Date: 2003/11/29 17:04:04 $
 */
public class WebServiceInvoker extends JavaServiceInvoker {

	private static Log log = LogFactory.getLog(WebServiceInvoker.class);

	public WebServiceInvoker(
		ServiceRequest request,
		HttpServletRequest httpServletRequest,
		ServletContext servletContex) {

		super(request, httpServletRequest, servletContex);
	}

	public Object invokeService() throws ServiceInvocationException {
		Object result = null;
		String serviceName = request.getServiceName();
		log.debug("SERVICE NAME: " + serviceName);
		String requestedMethodName = request.getServiceMethodName();
		String packageFolder = "ws" + serviceName.hashCode();
		//remove -'s and .'s
		packageFolder = removeChar(packageFolder, '-');
		packageFolder = removeChar(packageFolder, '.');
		//packageFolder="package"+packageFolder;
		log.debug("PACKAGE NAME:" + packageFolder);

		try {
			String webservicesDir =
				servletContext.getRealPath("/WEB-INF/classes");

			runAntBuild(serviceName, packageFolder, webservicesDir);

			Class bindingClass =
				loadWSClass(
					org.apache.axis.client.Stub.class,
					webservicesDir,
					packageFolder);
			Class locatorClass =
				loadWSClass(
					org.apache.axis.client.Service.class,
					webservicesDir,
					packageFolder);

			String endpoint = getEndPoint(locatorClass);

			result =
				invokeMethod(
					bindingClass,
					endpoint,
					requestedMethodName,
					request.getParameters());

			log.debug("here it comes!!");

		} catch (Exception e) {
			throw new ServiceInvocationException(request, e);
		}
		return result;
	}

	private String removeChar(String s, char c) {
		StringBuffer b = new StringBuffer(s.length());
		for (int i = 0; i < s.length(); ++i) {
			if (s.charAt(i) != c)
				b.append(s.charAt(i));
		}
		return b.toString();
	}

	private void runAntBuild(
		String serviceName,
		String packageFolder,
		String webservicesDir) {
		File testDir = new File(webservicesDir + "/" + packageFolder);
		if (!testDir.exists()) {
			Project project = new Project();
			project.init();
			if (log.isDebugEnabled()) {
				project.addBuildListener(new WebServiceBuildLogger());
			}
			String webInfPath = servletContext.getRealPath("/WEB-INF");
			File buildFile = new File(webInfPath + "/build-webservice.xml");
			log.debug("buildfile exists: " + buildFile.exists());
			project.setProperty("endpoint", serviceName);
			project.setProperty("packagename", packageFolder);
			ProjectHelper.configureProject(project, buildFile);
			project.executeTarget(project.getDefaultTarget());
			project.executeTarget("fetch-wsdl");
			project.executeTarget("import-wsdl");
			project.executeTarget("compile");
		}
	}

	private Class loadWSClass(
		Class classType,
		String webservicesDir,
		String packageFolder)
		throws ClassNotFoundException {

		Class wsClass = java.lang.Object.class;

		File classDir = new File(webservicesDir + "/" + packageFolder + "/");
		String[] fileList = classDir.list();

		String fileName = null;

		for (int i = 0; i < fileList.length; ++i) {

			fileName = fileList[i];
			if (fileName.indexOf(".class") == -1)
				continue;

			fileName = fileName.substring(0, fileName.lastIndexOf('.'));

			wsClass =
				Thread.currentThread().getContextClassLoader().loadClass(
					packageFolder + "." + fileName);

			Class sc = wsClass.getSuperclass();
			if (sc == null)
				continue;
			if (sc.equals(classType))
				break;
		}

		return wsClass;
	}

	private String getEndPoint(Class locatorClass)
		throws
			NoSuchMethodException,
			InstantiationException,
			IllegalAccessException,
			InvocationTargetException {

		Method[] lcMethods = locatorClass.getMethods();
		Method getPortAddress = null;
		String methodName = null;
		for (int i = 0; i < lcMethods.length; ++i) {
			methodName = lcMethods[i].getName();
			if (methodName.indexOf("Address") != -1) {
				log.debug("...got port address locator...");
				getPortAddress = lcMethods[i];
			}
		}

		Constructor constructor = locatorClass.getConstructor(null);
		Object locatorObj = constructor.newInstance(null);

		String endpoint = getPortAddress.invoke(locatorObj, null).toString();
		return endpoint;
	}

	private Object invokeMethod(
		Class bindingClass,
		String endpoint,
		String requestedMethodName,
		List parms)
		throws
			InstantiationException,
			IllegalAccessException,
			InvocationTargetException,
			NoSuchMethodException,
			MalformedURLException {

		Class[] argTypes =
			new Class[] { java.net.URL.class, javax.xml.rpc.Service.class };
		Constructor stubConstructor = bindingClass.getConstructor(argTypes);
		//TODO is service always null?
		Service service = null;
		Object[] args = new Object[] { new java.net.URL(endpoint), service };

		Object stubObj = stubConstructor.newInstance(args);

		return invokeServiceMethod(
			stubObj,
			bindingClass,
			requestedMethodName,
			parms);
	}

	public boolean supports(ServiceRequest request) {
		return (
			request.getServiceName().toLowerCase().lastIndexOf("wsdl") != -1);
	}

}
