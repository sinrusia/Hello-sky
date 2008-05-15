#include "NetServices.as"
#include "NetDebug.as"
 

// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// ::: Button Action Script

	SetButton.label = "Set Value";
	SetButton.clickHandler = function()
	{
		NetServices.setDefaultGatewayURL(_root.gatewayPath);
		serviceConnection = NetServices.createGatewayConnection();

		serviceObject = serviceConnection.getService(_root.objectPath, this);
		serviceObject.setTestValue(_root.sendText);
	}

	GetButton.label = "Get Value";
	GetButton.clickHandler = function()
	{
		NetServices.setDefaultGatewayURL(_root.gatewayPath);
		serviceConnection = NetServices.createGatewayConnection();

		serviceObject = serviceConnection.getService(_root.objectPath, _root);
		serviceObject.getTestValue();
	}

// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// ::: Define data handler


getTestValue_Result = function(result) {
	// Output message header
	_root.responseText = "RESPONSE: " + result;
	trace("result:"+result);
}


// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::