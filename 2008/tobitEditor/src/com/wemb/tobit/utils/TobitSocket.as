package com.wemb.tobit.utils
{
	import com.wemb.tobit.pure.Constants;
	
	import flash.net.Socket;
	import flash.system.Security;
	
	public class TobitSocket extends Socket
	{		
        private var serverURL:String;
        private var portNumber:int;
        private var state:int = 0;
        
        public function TobitSocket(host:String=null, port:uint=0) 
        {
	        super(host, port);
	        //Security.loadPolicyFile("xmlsocket://" + serverURL + ":" + portNumber + "/crossdomain.xml");
	        //Security.loadPolicyFile("xmlsocket://" + serverURL + ":" + portNumber);
	    }
	}
}
