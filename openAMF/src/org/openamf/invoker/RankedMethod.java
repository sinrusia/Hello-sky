/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.invoker;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openamf.util.OpenAMFUtils;

import flashgateway.io.ASObject;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.23 $, $Date: 2005/06/14 21:32:59 $
 */
public class RankedMethod implements Comparable {

	public static final int NAME_MATCHES = 55;
	public static final int NAME_CASE_MATCHES = 5;
	public static final int PARAM_COUNT_MATCHES = 10;

	private double rank;
	private Method method;
	private List parameters;
	private boolean invokable;

	private static final Log log = LogFactory.getLog(RankedMethod.class);

	public RankedMethod(Method method, String requestedMethodName, List parameters) {

		this.method = method;
		process(requestedMethodName, parameters);
	}

	public double getRank() {
		return rank;
	}

	public Method getMethod() {
		return method;
	}

	public boolean isInvokable() {
		return invokable;
	}

	public Object invoke(Object service)
		throws
			IllegalArgumentException,
			IllegalAccessException,
			InvocationTargetException {
		
		if (method == null)
		{
			throw new NullPointerException("method is null, service="
						+ String.valueOf(service));
		}
		else if (parameters == null)
		{
			throw new NullPointerException("parameters is null, service="
					+ String.valueOf(service));
		}
		
		return method.invoke(service, parameters.toArray());
	}

	private void process(String requestedMethodName, List parameters) {

		double rank = 0;
		List decodedParameters = null;

		if (method.getName().equalsIgnoreCase(requestedMethodName)) {
			log.debug("comparing to methodName: " + method.getName());
			log.debug("NAME_MATCHES");
			rank = RankedMethod.NAME_MATCHES;

			if (method.getName().equals(requestedMethodName)) {
				log.debug("NAME_CASE_MATCHES");
				rank += RankedMethod.NAME_CASE_MATCHES;
			}

			Class[] parameterTypes = method.getParameterTypes();
			if (parameterTypes.length == parameters.size()) {
				log.debug("PARAM_COUNT_MATCHES");
				rank += RankedMethod.PARAM_COUNT_MATCHES;

				decodedParameters = new ArrayList(parameterTypes.length);

				rank =
					checkParameters(
						parameters,
						rank,
						decodedParameters,
						parameterTypes);
			}
			log.debug("RANK: " + rank);
		}

		this.rank = rank;
		this.parameters = decodedParameters;

	}

	private double checkParameters(
		List parameters,
		double rank,
		List decodedParameters,
		Class[] parameterTypes) {

		invokable = true;

		int allParamTypesMatch =
			100 - NAME_MATCHES - NAME_CASE_MATCHES - PARAM_COUNT_MATCHES;

		double paramTypeMatchValue = 0;
		if (parameterTypes.length == 0) {
			rank += allParamTypesMatch;
		} else {
			paramTypeMatchValue = allParamTypesMatch / parameterTypes.length;
		}

		for (int i = 0; i < parameterTypes.length; i++) {
			Class parameterType = parameterTypes[i];
			Object parameter = parameters.get(i);
			// this covers primitive types that are natively decoded e.g. boolean, number
			boolean origTypesMatch = OpenAMFUtils.typesMatch(parameterType, parameter);

			Object decodedObject = OpenAMFUtils.decodeParameter(parameter, parameterType);
			
			if (decodedObject == null) {
				rank += paramTypeMatchValue / 2;
				decodedParameters.add(decodedObject);
			} else if (OpenAMFUtils.typesMatch(parameterType, decodedObject)) {
				log.debug("types match");
				if (origTypesMatch) {
					//if we matched originally, and continued to match
					rank += paramTypeMatchValue;
				} else if (parameter instanceof ASObject){
					//if we didn't match originally, but the anticipated type matched, and now the decoded matches.
	            	 ASObject asParam = (ASObject)parameter;
	            	 if(parameterType.getName().equals(asParam.getType())){
	            	 	rank += paramTypeMatchValue;
	            	 }else{
						//if we didn't 
						rank += paramTypeMatchValue / 2;
	            	 }
				} else {
					//if we didn't 
					rank += paramTypeMatchValue / 2;
				}
				decodedParameters.add(decodedObject);
			} else if (origTypesMatch) {
				// types matched before decoding, but don't match now
				// use parameter instead of decodedObject
				rank += paramTypeMatchValue;
				decodedParameters.add(parameter);
			} else {
				log.info("parameter couldn't be decoded");
				invokable = false;
				break;
			}
		}
    	return rank;
	}

	public int compareTo(Object o) {
		int compareTo = 0;
		RankedMethod rankedMethod = (RankedMethod) o;
		if (getRank() > rankedMethod.getRank()) {
			compareTo = -1;
		} else if (getRank() < rankedMethod.getRank()) {
			compareTo = 1;
		}
		return compareTo;
	}
	
	public String toString() {
		return String.valueOf(getMethod());
	}

	
}