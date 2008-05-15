/*
 * www.openamf.org
 * 
 * Distributable under LGPL license. See terms of license at gnu.org.
 */
package org.openamf.util;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.carbonfive.flash.ASTranslator;
import com.carbonfive.flash.ASTranslatorFactory;
import flashgateway.io.ASObject;
/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @author Sean C. Sullivan
 * 
 * @see XMLUtils
 * @version $Revision: 1.24 $, $Date: 2004/06/22 02:05:48 $
 *  
 */
public final class OpenAMFUtils {
    private static final Log log = LogFactory.getLog(OpenAMFUtils.class);
    private OpenAMFUtils() {
        // this constructor is intentionally private
    }
    /**
     * @return may return null
     *  
     */
    public static Object decodeParameter(Object parameter, Class parameterType) {
        log.debug("Decoding parameter: " + parameter + " to type: "
                + parameterType);
        if (parameter == null) {
            return null;
        }
        if (parameter instanceof ASObject
                && ((ASObject) parameter).getType() == null) {
            ASObject aso = (ASObject) parameter;
            aso.setType(parameterType.getName());
        }
        
        if ( (parameter instanceof Number) && (! ( parameter instanceof Double)) )
        {
        	Number n = (Number) parameter;
        	parameter = new Double(n.doubleValue());
        }

        // special handling for java.lang.Number
        if ( parameterType == java.lang.Number.class) 
		{
			parameterType = Double.class;
		}
		
		Object decodedObject = null;
		
        ASTranslatorFactory factory = null;
        factory = ASTranslatorFactory.getInstance();
        ASTranslator translator = factory.getASTranslator();
        try {
            decodedObject = translator.fromActionScript(parameter,
                    parameterType);
        } catch (Exception ex) {
            decodedObject = null;
            log.debug("caught exception while decoding parameter", ex);
        }
        log.debug("decodedObject: " + decodedObject);
        return decodedObject;
    }
    public static boolean typesMatch(Class parameterType, Object parameter) {
        log.debug("expected class: " + parameterType.getName());
        if (parameter == null) {
            log.debug("parameter is null");
        } else {
            log.debug("parameter class: " + parameter.getClass().getName());
        }
        boolean typesMatch = parameterType.isInstance(parameter);
        if (!typesMatch) {
            if (parameterType.equals(Boolean.TYPE)
                    && parameter instanceof Boolean) {
                typesMatch = true;
            } else if (parameterType.equals(Character.TYPE)
                    && parameter instanceof Character) {
                typesMatch = true;
            } else if (parameterType.equals(Byte.TYPE)
                    && parameter instanceof Byte) {
                typesMatch = true;
            } else if (parameterType.equals(Short.TYPE)
                    && parameter instanceof Short) {
                typesMatch = true;
            } else if (parameterType.equals(Integer.TYPE)
                    && parameter instanceof Integer) {
                typesMatch = true;
            } else if (parameterType.equals(Long.TYPE)
                    && parameter instanceof Long) {
                typesMatch = true;
            } else if (parameterType.equals(Float.TYPE)
                    && parameter instanceof Float) {
                typesMatch = true;
            } else if (parameterType.equals(Double.TYPE)
                    && parameter instanceof Double) {
                typesMatch = true;
            }
        }
        return typesMatch;
    }
}