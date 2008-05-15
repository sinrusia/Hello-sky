
#initclip 1

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//::: Declare MViRssClass
MViNetconnectionClass = function () {
	this.init();
};


// Extend Movie Clip, Register to Symbol
MViNetconnectionClass.prototype = new MovieClip();


// Constructor
MViNetconnectionClass.prototype.init = function(){
	// Include Netconnection .as files
	#include "NetServices.as"
	#include "NetDebug.as" 

	this.gatewayUrl = "http://localhost:8080/openamf/gateway";
	this.setGateway();
}

MViNetconnectionClass.prototype.setGatewayUrl = function(gatewayUrl){
	this.gatewayUrl = gatewayUrl;
}

MViNetconnectionClass.prototype.setGateway = function(){
	NetServices.setDefaultGatewayURL(this.gatewayUrl);
	_global.serviceConnection = NetServices.createGatewayConnection();
}

Object.registerClass("MViNetconnectionSymbol", MViNetconnectionClass);

#endinitclip

