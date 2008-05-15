#include "NetServices.as"
#include "NetDebug.as"


//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//::: Declare Person Class
Rss = function () {
	this.init();
}


// Constructor
Rss.prototype.init = function(){
	this.gatewayPath = "http://localhost:8080/openamf/gateway";
	this.servicePath = "org.openamf.examples.RSS";
	this.rssURL = "";
	this.channel = new Object();
}



// Methods
Rss.prototype.setServiceObject = function() {
	NetServices.setDefaultGatewayURL(this.gatewayPath);
	this.serviceConnection = NetServices.createGatewayConnection();
	this.serviceObject = this.serviceConnection.getService(this.servicePath, this);
}

Rss.prototype.getChannel = function(rssURL) {
	this.setServiceObject();
	this.serviceObject.getChannel(rssURL);
}

Rss.prototype.getChannel_Result = function(result) {
	//there will only be one channel
	this.channel = result;
	
	title = this.channel["title"].toString();
	description = this.channel["description"].toString();
	link = this.channel["link"].toString();

	_root.rssOutput.text += "\nTitle: "+ title;
	_root.rssOutput.text += "\nDescription: "+ description;
	_root.rssOutput.text += "\nLink: "+ link;
	_root.rssOutput.text += "\n";
	_root.rssOutput.text += "\nFeed: ";

	var items = this.channel["items"];
	itemCount = items.length;
    for (i=0; i<itemCount;i++) {
            var item = items[i]
            //TODO title, description, and link should be written somewhaere else
            //the following code will just keep overwriting the same var's
            _root.rssOutput.text += "\nTitle: "+item["Title"].toString();
            _root.rssOutput.text += "\nDescription: "+item["Description"].toString();
            _root.rssOutput.text += "\nLink: "+item["Link"].toString();			
    }
}


//::: Create Rss Object
myRss = new Rss();


//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// ::: Button Action Script
GetRssButton.label = "Get Feed";
GetRssButton.tabEnabled = false;
GetRssButton.clickHandler = function() {
	myRss.getChannel(_root.rssURL.text);
}

// ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


