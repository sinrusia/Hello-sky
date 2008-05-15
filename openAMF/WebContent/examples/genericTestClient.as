import mx.remoting.Service;
import mx.rpc.RelayResponder;
import mx.remoting.PendingCall;
import mx.rpc.ResultEvent;
import mx.rpc.FaultEvent;
import mx.remoting.debug.NetDebug;
import mx.services.Log;
var debug : Boolean = NetDebug.initialize ();
import com.schematic.common.account.impl.AccountImpl;
//if your running it locally.
switch (2)
{
	case 0 :
	//running it locally.
	_global.defaultGateway = "http://localhost:8080/openamf/gateway";
	break;
	case 1 :
	//external to LA office
	_global.defaultGateway = "http://vongodev.schematic.com/vongo-api/gateway";
	break;
	case 2 :
	//internal to office (aka vongodev)
	_global.defaultGateway = "http://192.168.0.240:8080/vongo-api/gateway";
	break;
	case 3 :
	//hy's machine
	_global.defaultGateway = "http://192.168.1.195:8080/vongo-api/gateway";
	break;
}
_root.gateway_txt.text = _global.defaultGateway;
//////////////////////////////////////////////////////
function getString_Result (evt : ResultEvent) : Void
{
	_root.helloText.text += ("\rgot Result Succesfully:\r");
	if (_global.service == 3 )
	{
		var aci = evt.result;
		_root.helloText.text += "\r\t\t" + (aci + " " + (aci instanceof com.schematic.common.account.impl.AccountImpl));
	} else
	{
		if (typeof (evt.result) == "string" || typeof (evt.result) == "number" || typeof (evt.result) == "boolean" )
		{
			trace ("A evt.result " + evt.result + " " + evt);
			_root.helloText.text += "\r\t\t" + evt.result;
		} else
		{
			trace ("B evt.result " + evt.result + " " + evt.result.length );
			for (var i in evt.result)
			{
				trace ("\r\t\t" + i + " :" + evt.result [i]);
				_root.helloText.text += ("\r\t\t" + i + " :" + evt.result [i]);
			}
		}
	}
}
function getString_Fault (evt : FaultEvent) : Void
{
	trace ("\rFault/Error: " + evt.fault.__faultstring);
	_root.helloText.text += "\rFault/Error: " + evt.fault.__faultstring;
}
test1_btn.onRelease = function ()
{
	_global.service = 1;
	//_root.gateway_txt.text = _global.defaultGateway;
	_root.service_txt.text = "hello";
	_root.method_txt.text = "getString";
	_root.arg1_txt.text = "";
	_root.helloText.text = "Test Description: Hello World test, should return 'hello world'";
	_root.glow_mc.play ();
}
test2_btn.onRelease = function ()
{
	_global.service = 2;
	//[AMFBody: {serviceName=org.openamf.examples.Directory, serviceMethodName=getPeople, response=/3, type=ARRAY, value=[Bob]}]
	//_root.gateway_txt.text = _global.defaultGateway;
	_root.service_txt.text = "org.openamf.examples.Directory";
	_root.method_txt.text = "getPeople";
	_root.arg1_txt.text = "Bob";
	_root.helloText.text = "Test Description: get People test, should return Bob (if he's been added by the client2 example)";
	_root.glow_mc.play ();
}
test3_btn.onRelease = function ()
{
	//recieve mapped object test
	_global.service = 3;
	//_root.gateway_txt.text = _global.defaultGateway;
	_root.service_txt.text = "accountManagement";
	_root.method_txt.text = "getAccount";
	_root.arg1_txt.text = "";
	_root.helloText.text = "Test Description: tests recieving a Mapped account object";
	_root.glow_mc.play ();
}
test4_btn.onRelease = function ()
{
	//send mapped object test
	_global.service = 4;
	//_root.gateway_txt.text = _global.defaultGateway;
	_root.service_txt.text = "accountManagement";
	_root.method_txt.text = "updateAccount";
	_root.arg1_txt.text = "";
	_root.helloText.text = "Test Description: tests sending a Mapped account object";
	_root.glow_mc.play ();
}
test5_btn.onRelease = function ()
{
	_global.service = 5;
	//_root.gateway_txt.text = _global.defaultGateway;
	_root.service_txt.text = "org.openamf.examples.Java2AS";
	_root.method_txt.text = "generateAS";
	_root.arg1_txt.text = "com.schematic.common.account.impl.AccountImpl";
	_root.argument_txt.text = "java classname:";
	_root.helloText.text = "Description: utility the stub AS class for a Java class, \r\r ***********Please press the 'Submit' button******** ";
	_root.glow_mc.play ();
}
submitBtn.onRelease = function ()
{
	trace ("\r \rclick");
	_root.glow_mc.gotoAndStop (1);
	var gatewayPath = _root.gateway_txt.text;
	////////////////////////////////////////////////////////////////////////
	//test that the gatemeay exist look at _root.onStatus for failure////////
	var my_lv : LoadVars = new LoadVars ();
	my_lv.load (gatewayPath);
	////////////////////////////////////
	var Svc : Service = null;
	var mypc : PendingCall = null;
	var srvName = "";
	srvName = _root.service_txt.text;
	Svc = new Service (gatewayPath, new Log () , srvName, null, statO);
	if (_global.service == 3)
	{
		var aci = new com.schematic.common.account.impl.AccountImpl ();
		aci.initSampleData ();
		trace (aci + " " + (aci instanceof com.schematic.common.account.impl.AccountImpl));
		mypc = Svc [String (_root.method_txt.text)](aci);
	} else if (_global.service == 4)
	{
		var aci = new com.schematic.common.account.impl.AccountImpl ();
		aci.initSampleData ();
		trace (aci + " " + (aci instanceof com.schematic.common.account.impl.AccountImpl));
		mypc = Svc [String (_root.method_txt.text)]("someString", aci);
	} else
	{
		if (false)
		{
			///DAMMIT apply doesn't work :(
			var f : Function = Svc [String (_root.method_txt.text)];
			if (_global.submit_args != null)
			{
				Svc [String (_root.method_txt.text)].apply (Svc, _global.submit_args);
			} else
			{
				Svc [String (_root.method_txt.text)].apply (Svc);
			}
		} else
		{
			_global.submit_args = _root.arg1_txt.parseArguments ();
			if (true)
			{
				switch (_global.submit_args.length)
				{
					case 11 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1] , _global.submit_args [2] , _global.submit_args [3] , _global.submit_args [4] , _global.submit_args [5] , _global.submit_args [6] , _global.submit_args [7] , _global.submit_args [8] , _global.submit_args [9] , _global.submit_args [10]);
					break;
					case 10 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1] , _global.submit_args [2] , _global.submit_args [3] , _global.submit_args [4] , _global.submit_args [5] , _global.submit_args [6] , _global.submit_args [7] , _global.submit_args [8] , _global.submit_args [9]);
					break;
					case 9 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1] , _global.submit_args [2] , _global.submit_args [3] , _global.submit_args [4] , _global.submit_args [5] , _global.submit_args [6] , _global.submit_args [7] , _global.submit_args [8]);
					break;
					case 8 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1] , _global.submit_args [2] , _global.submit_args [3] , _global.submit_args [4] , _global.submit_args [5] , _global.submit_args [6] , _global.submit_args [7]);
					break;
					case 7 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1] , _global.submit_args [2] , _global.submit_args [3] , _global.submit_args [4] , _global.submit_args [5] , _global.submit_args [6]);
					break;
					case 6 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1] , _global.submit_args [2] , _global.submit_args [3] , _global.submit_args [4] , _global.submit_args [5]);
					break;
					case 5 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1] , _global.submit_args [2] , _global.submit_args [3] , _global.submit_args [4]);
					break;
					case 4 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1] , _global.submit_args [2] , _global.submit_args [3]);
					break;
					case 3 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1] , _global.submit_args [2]);
					break;
					case 2 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0] , _global.submit_args [1]);
					break;
					case 1 :
					mypc = Svc [String (_root.method_txt.text)](_global.submit_args [0]);
					break;
					case 0 :
					default :
					mypc = Svc [String (_root.method_txt.text)]();
					break;
				}
			}
		}
	}
	_root.helloText.text = "attempting to call the '" + srvName + "." + _root.method_txt.text + "(" + _root.arg1_txt.text + ")' service...";
	for (var j = 0; j < _global.submit_args.length; j ++)
	{
		_root.helloText.text += ("\n\targ:" + j + " val:" + _global.submit_args [j] + " type:" + typeof (_global.submit_args [j]));
	}
	mypc.responder = new RelayResponder (_root, "getString_Result", "getString_Fault", "onStatus");
};
//details http://localhost:8080/openamf/gateway
//description HTTP: Failed
//code NetConnection.Call.Failed
//level error
_global.System.onStatus = function (a1, b, c)
{
	_root.helloText.text += ("\rSystem. on status**********************");
	var a = a1;
	for (var i in a1)
	{
		_root.helloText.text += ("\r\t\t" + i + " :" + a1 [i]);
	}
	if (a1.code == "NetConnection.Call.Failed")
	{
		_root.helloText.text += ("\r\r are you sure the gateway is up?");
	}
};
///////////////////////////////////////
//arg1_txt.onChanged = function ()
//{
//	_global.submit_args = this.parseArguments ();
//};
arg1_txt.parseArguments = function ()
{
	var txt = this.text;
	var resAry = new Array ();
	if (txt == "")
	{
		//resAry.push("");
	} else
	{
		//split into arguments.
		var ary = txt.split (",");
		for (var i = 0; i < ary.length; i ++)
		{
			//			trace("argument " + i + " " + ary[i]);
			var ary2 = ary [i].split (":");
			var val = Trim (ary2 [0]);
			var lval = val.toLowerCase ();
			var vtype = Trim (ary2 [1]);
			trace (" test: " + (a == b));
			if (vtype == "undefined")
			{
				trace ("argument " + i + " " + val);
				if (lval == "null")
				{
					resAry.push (null);
				} else if (lval == "true")
				{
					resAry.push (true);
				} else if (lval == "false")
				{
					resAry.push (false);
				} else if ( ! isNaN (val))
				{
					resAry.push (parseInt (val));
				} else
				{
					resAry.push (val);
				}
			} else
			{
				trace ("targument " + i + " " + val + " " + vtype);
				switch (vtype.toLowerCase ())
				{
					case "string" :
					resAry.push (new String (val));
					break;
					case "number" :
					resAry.push (Number (val));
					break;
					case "boolean" :
					resAry.push (Boolean (val));
					break;
				}
			}
		}
	}
	trace ("parsed---------------------");
	for (var j = 0; j < resAry.length; j ++)
	{
		trace ("arg:" + j + " val:" + resAry [j] + " type:" + typeof (resAry [j]));
	}
	return resAry;
};
_global.Trim = function (str1)
{
	var char_array = new Array ();
	//find first character
	var firstChar = 0;
	var str = null;
	if (typeof (str1) == "string")
	{
		//trace( "is string");
		str = str1;
	} else
	{
		//trace ("inst");
		str = new String (str1);
	}
	//trace("len " + str.length + " " + str1.length );
	var lastChar = str.length;
	for (var j = 0; j < str.length; j ++)
	{
		// A useful character is anything over 32 (space, tab,
		// new line, etc are all below).
		if (str.charCodeAt (j) > 32)
		{
			//trace("first char "+j);
			firstChar = j;
			break;
		}
	}
	//find last character
	for (var j = str.length; j >= 0; j --)
	{
		// A useful character is anything over 32 (space, tab,
		// new line, etc are all below).
		if (str.charCodeAt (j) > 32)
		{
			lastChar = j + 1;
			break;
		}
	}
	//	trace(firstChar+" "+lastChar);
	var rs = str.substring (firstChar, lastChar);
	return rs;
};
//////////////////////
// Set to defaults
test1_btn.onRelease ();
_root.glow_mc.gotoAndStop (1);
