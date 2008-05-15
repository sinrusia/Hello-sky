
#initclip

_global.JoinMailingListClass = function() {
	this.init();
}



// Extend Movie Clip, Register to Symbol
JoinMailingListClass.prototype = new MovieClip();




JoinMailingListClass.prototype.init = function(){
	this.email = "";
	this.password = "";
	this.url = "http://lists.sourceforge.net/lists/subscribe/openamf-user";
	this.servicePath = "org.openamf.examples.SubmitToURL";
	this.setServiceObject();
	this.setJoinButton();
	trace("path"+this.servicePath);
}


JoinMailingListClass.prototype.setServiceObject = function(){
	this.serviceObject = _global.serviceConnection.getService(this.servicePath, this);
}


JoinMailingListClass.prototype.submit = function(email,password){
	this.email = email;
	this.password = password;
	this.serviceObject.submit(this.url+"?email="+this.email+"&pw="+this.password+"&pw-conf="+this.password+"&");
}


JoinMailingListClass.prototype.submit_Result = function(result) {
	// hello
	trace(result);
}


JoinMailingListClass.prototype.setJoinButton = function(){
    this.buttonJoin.onRelease = function(){
		// Hack.. need to get this working with existing local method
		myJoin = new JoinMailingListClass();
	
    	myJoin.submit(this._parent.emailVar,this._parent.passwordVar);
		email = this._parent.emailVar;
 		password = this._parent.passwordVar;
    	this._parent.message.text = "Thank you";
    }
}

Object.registerClass("FormSymbol", JoinMailingListClass);


#endinitclip



