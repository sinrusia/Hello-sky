/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.util;

import java.io.IOException;
import java.io.InputStream;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/**
 * @author Jason Calabrese <mail@jasoncalabrese.com>
 * @see OpenAMFUtils
  * @version $Revision: 1.7 $, $Date: 2004/03/16 04:33:39 $
  */
public final class XMLUtils {

    protected static Log log = LogFactory.getLog(XMLUtils.class);
    
	private XMLUtils() {
		// this constructor is intentionally private
	}

	public static String convertDOMToString(Node node) {
		StringBuffer sb = new StringBuffer();
		if (node.getNodeType() == Node.TEXT_NODE) {
			sb.append(node.getNodeValue());
		} else {
			String currentTag = node.getNodeName();
			sb.append('<');
			sb.append(currentTag);
			appendAttributes(node, sb);
			sb.append('>');
			if (node.getNodeValue() != null) {
				sb.append(node.getNodeValue());
			}

			appendChildren(node, sb);

			appendEndTag(sb, currentTag);
		}
		return sb.toString();
	}

	private static void appendAttributes(Node node, StringBuffer sb) {
		if (node instanceof Element) {
			NamedNodeMap nodeMap = node.getAttributes();
			for (int i = 0; i < nodeMap.getLength(); i++) {
				sb.append(' ');
				sb.append(nodeMap.item(i).getNodeName());
				sb.append('=');
				sb.append('"');
				sb.append(nodeMap.item(i).getNodeValue());
				sb.append('"');
			}
		}
	}

	private static void appendChildren(Node node, StringBuffer sb) {
		if (node.hasChildNodes()) {
			NodeList children = node.getChildNodes();
			for (int i = 0; i < children.getLength(); i++) {
				sb.append(convertDOMToString(children.item(i)));
			}
		}
	}

	private static void appendEndTag(StringBuffer sb, String currentTag) {
		sb.append('<');
		sb.append('/');
		sb.append(currentTag);
		sb.append('>');
	}
	
	/**
	 * Reads XML Document from input stream
	 * 
	 * @param is
	 * @return Document
	 * @throws IOException
	 */
	public static Document convertToDOM(InputStream is) throws IOException {
		Document document = null;
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		is.skip(4); // skip length
		try {
			DocumentBuilder builder = factory.newDocumentBuilder();
			document = builder.parse(new InputSource(is));
		} catch (Exception e) {
            log.error(e, e);
			throw new IOException("Error while parsing xml: " + e.getMessage());
		}
		return document;
	}
}
