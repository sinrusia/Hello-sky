/*
 * www.openamf.org
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */

package org.openamf.test;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.HashMap;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.openamf.AMFBody;
import org.openamf.AMFMessage;
import org.openamf.io.AMFDeserializer;
import org.openamf.io.AMFSerializer;

/**
 * @author Jason Calabrese <jasonc@missionvi.com>
 * @version $Revision: 1.1 $, $Date: 2003/08/20 20:35:23 $
 */
public class RemotingTester {

    public static AMFMessage sendMessage(
            String gateway,
            String target,
            String response,
            List parameters)
            throws IOException, HttpException {

        AMFMessage requestMessage = new AMFMessage();
        AMFBody requestBody = new AMFBody(target, response, parameters);
        requestMessage.addBody(requestBody);
        return sendMessage(gateway, requestMessage);

    }

    public static AMFMessage sendMessage(String gateway, AMFMessage requestMessage)
            throws IOException, HttpException {

        ByteArrayOutputStream baOutputStream = new ByteArrayOutputStream();
        DataOutputStream outputStream = new DataOutputStream(baOutputStream);
        AMFSerializer serializer = new AMFSerializer(outputStream);
        serializer.serializeMessage(requestMessage);

        PostMethod post = new PostMethod(gateway);
        post.setRequestBody(new ByteArrayInputStream(baOutputStream.toByteArray()));
        post.setRequestContentLength(baOutputStream.size());
        post.setRequestHeader("Content-type", "application/x-amf");

        HttpClient httpclient = new HttpClient();
        int result = httpclient.executeMethod(post);

        DataInputStream inputStream =
                new DataInputStream(new ByteArrayInputStream(post.getResponseBody()));

        AMFDeserializer deserializer = new AMFDeserializer(inputStream);
        AMFMessage resposeMessage = deserializer.getAMFMessage();

        // Release current connection to the connection pool once you are done
        post.releaseConnection();

        return resposeMessage;
    }
    public static void main(String[] args) throws IOException {
        AMFMessage msg1 = createMessage1();
        System.out.println("msg1 = " + msg1);
        AMFMessage msg2 = sendMessage("http://localhost:8080/openamf/gateway", msg1);
        System.out.println("msg2 = " + msg2);
    }

    private static AMFMessage createMessage1() {
        /**
         * msg1 = [AMFMessage: {version=0, headers={[AMFHeader: {key=amf_server_debug, required=true,
         * value={amfheaders=false, httpheaders=false, coldfusion=true, m_debug=true, recordset=true, trace=true,
         * amf=false, error=true}}]}, bodies={[AMFBody: {target=org.openamf.test.Test3.getNumber,
         * serviceName=org.openamf.test.Test3,serviceMethodName=getNumber,response=/1,value=3.14,type=NUMBER}]}}]
         */
        AMFMessage message = new AMFMessage();
        HashMap keys1 = new HashMap();
        keys1.put("amf", Boolean.FALSE);
        keys1.put("error", Boolean.TRUE);
        keys1.put("trace", Boolean.TRUE);
        keys1.put("coldfusion", Boolean.TRUE);
        keys1.put("m_debug", Boolean.TRUE);
        keys1.put("httpheaders", Boolean.FALSE);
        keys1.put("amfheaders", Boolean.FALSE);
        keys1.put("recordset", Boolean.TRUE);
        message.addHeader("amf_server_debug", true, keys1);
        message.addBody("org.openamf.test.Test3.getNumber","/1", new Double(3.14), AMFBody.DATA_TYPE_NUMBER);
        return message;
    }
}
