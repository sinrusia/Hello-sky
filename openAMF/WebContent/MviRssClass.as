
#initclip 2

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//::: Declare MViRssClass
MViRssClass = function () {
	this.init();
};


// Extend Movie Clip, Register to Symbol
MViRssClass.prototype = new MovieClip();


// Constructor
MViRssClass.prototype.init = function(){
	// Set component size
	this.boundingBox._visible = false;
	this._visible = false;
	this.width = this._width;
	this.height = this._height;
	this._xscale = this._yscale = 100;
	this.boundingBox._width = this.width;
	this.boundingBox._height = this.height;	

	// Set server communication parameters
	this.gatewayPath = this.gatewayPath_param;
	this.servicePath = "org.openamf.examples.RSS";
	this.setServiceObject();
	this.rssURL = "";
	this.channel = new Object();
	this.channelUrl = this.channelUrl_param;
	this.getChannel(this.channelUrl);

	// Initialize text display
	this.formatHeader();
	this.formatBody();
}


/* 
General Remoting Methods 
Note: Netconnection must be declare local for these to work 
*/

MViRssClass.prototype.setGatewayPath = function(gatewayPath){
	this.gatewayPath = gatewayPath;
}

MViRssClass.prototype.setServicePath = function(servicePath){
	this.servicePath = servicePath;
}

MViRssClass.prototype.setServiceObject = function() {
	this.serviceObject = _global.serviceConnection.getService(this.servicePath, this);
}

// MViRss Methods
MViRssClass.prototype.getChannel = function(rssURL) {
	this.serviceObject.getChannel(rssURL);
}

MViRssClass.prototype.getChannel_Result = function(result) {
	this.channel = result;
	this.displayRss();
}

MViRssClass.prototype.displayRss = function() {
	this.displayHeader();
	this.displayBody();
	this._visible = true;
}
MViRssClass.prototype.displayItem = function(item, position) {
    _root.rssOutput.text += "\nTitle: "+item["Title"].toString();
    _root.rssOutput.text += "\nDescription: "+item["Description"].toString();
    _root.rssOutput.text += "\nLink: "+item["Link"].toString();
	var itemRow = this.attachMovie("", "", position * 10);
}

MViRssClass.prototype.formatHeader = function() {
	var scrollbarOffset = this.scrollbar._width + 3;
	this.header._x = 0;
	this.header._width = this.headerWidth - scrollbarOffset;
	this.header.autosize = left;
}

MViRssClass.prototype.displayHeader = function() {
	title = this.channel["title"].toString();
	description = this.channel["description"].toString();
	link = this.channel["link"].toString();
	
	var ch = this.channel;
	this.header.htmlText += '<font face="Verdana" size="8">';
	this.header.htmlText += '<b>' + ch["title"].toString() + '</b><br>';
	this.header.htmlText += ch["description"].toString() + '<br>';
	link = ch["link"].toString();
	this.header.htmlText += '<a href="link"><u>' + link + '</u></a>';
	this.header.htmlText += '</font>';
}

MViRssClass.prototype.formatBody = function() {
	var headerOffset = this.header._height + 3;
	var scrollbarOffset = this.scrollbar._width + 3;
	this.body._x = 0;
	this.body._y = headerOffset;
	this.body._width = this.width - scrollbarOffset;
	this.body._height = this.height - headerOffset;
}

MViRssClass.prototype.displayBody = function() {
	this.formatBody();
	this.formatScrollbar();
	var items = this.channel["items"];
	var itemCount = items.length;
    for (i=0; i<itemCount;i++) {
		this.body.htmlText += '<font face="Verdana" size="8">';
		this.body.htmlText += '<b>' + items[i]["title"].toString() + '</b><br>';
		this.body.htmlText += items[i]["description"].toString() + '<br>';
		link = items[i]["link"].toString();
		this.body.htmlText += '<a href="'+link+'"><u>' + link + '</u></a>';
		this.body.htmlText += '</font><br><br>';
    }
}

MViRssClass.prototype.formatScrollbar = function() {
	var headerOffset = this.header._height + 3;
	this.scrollbar._x = this.width;
	this.scrollbar._y = headerOffset;
	this.scrollbar.setSize(this.height - headerOffset);
}

MViRssClass.prototype.scrollBody = function() {
	this.body.scroll = this.body.maxscroll * (this.scrollbar.getValue()/100);
}

Object.registerClass("MViRssSymbol", MViRssClass);

#endinitclip

