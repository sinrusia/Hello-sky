package com.daum.vo
{
	public class SearchInfo
	{
	
		private var _answerCount:String	= "";
		private var _author:String		= "";
		private var _category:String	= "";
		private var _categoryId:String	= "";
		private var _categoryUrl:String	= "";
		private var _description:String	= "";
		private var _link:String		= "";
		private var _pubDate:String		= "";
		private var _title:String		= "";

		public function SearchInfo(value:Object){
			if(value != null){
				_answerCount	= value.answerCount; 
				_author			= value.author;
				_category		= value.category;
				_categoryId		= value.categoryId;
				_categoryUrl	= value.categoryUrl;
				_description	= value.description;
				_link			= value.link;
				_pubDate		= value.pubDate;
				_title			= value.title;
			}
		}
		
		[Bindable]
		public function get answerCount():String{
			return _answerCount;
		}
		
		public function set answerCount(value:String):void{
			_answerCount = value;
		}

		[Bindable]
		public function get author():String{
			return _author;
		}
		
		public function set author(value:String):void{
			_author = value;
		}
		
		[Bindable]
		public function get category():String{
			return _category;
		}
		
		public function set category(value:String):void{
			_category = value;
		}
		
		[Bindable]
		public function get categoryId():String{
			return _categoryId;
		}
		
		public function set categoryId(value:String):void{
			_categoryId = value;
		}
		
		[Bindable]
		public function get categoryUrl():String{
			return _categoryUrl;
		}
		
		public function set categoryUrl(value:String):void{
			_categoryUrl = value;
		}
		
		[Bindable]
		public function get description():String{
			return _description;
		}
		
		public function set description(value:String):void{
			_description = value;
		}
		
		[Bindable]
		public function get link():String{
			return _link;
		}
		
		public function set link(value:String):void{
			_link = value;
		}
		
		[Bindable]
		public function get pubDate():String{
			var year:String		= _pubDate.substr(0, 4);
			var month:String	= _pubDate.substr(4, 2);
			var date:String		= _pubDate.substr(6, 2);
			return year + "." + month + "." + date;
		}
		
		public function set pubDate(value:String):void{
			_pubDate = value;
		}
		
		[Bindable]
		public function get title():String{
			//var rtnValue:String = "<a href='"+_link+"'>" + _title + "</a>";
			return _title;
		}
		
		public function set title(value:String):void{
			_title = value;
		}
	}
}