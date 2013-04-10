package file;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UploadServlet extends HttpServlet {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		proc(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		proc(req, resp);
	}

	protected void proc(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try{
			logger.debug("Start Upload!");
			req.setCharacterEncoding("UTF-8");
			// create a factory for disk-based file items
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			// set factory constraints
			factory.setSizeThreshold(1024 * 1024 * 20);
			logger.debug(getServletContext().getRealPath("/WEB-INF/upload/"));
			factory.setRepository(new File(getServletContext().getRealPath("/WEB-INF/upload/")));
			
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			// Set overall request size constraint
			upload.setSizeMax(-1);
			
			List<?> list = upload.parseRequest(req);
			for(int i = 0, ii = list.size(); i < ii; i++){
				FileItem fileItem = (FileItem) list.get(i);
				// check FileData
				if("FileData".equals(fileItem.getFieldName())){
					logger.debug(getServletContext().getRealPath("/upload/"));
					File file = new File(getServletContext().getRealPath("/upload/" + fileItem.getName()));
					File upDir = file.getParentFile();
					if(!upDir.isFile() && !upDir.isDirectory()){
						upDir.mkdirs();
					}
					
					fileItem.write(file);
					
				}
					
			}
		} catch (Exception e) {
			logger.debug("",e);
		}
	}
}
