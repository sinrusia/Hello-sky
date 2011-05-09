package wemb.tobit.vo
{
	public class PropertyData
	{
		private var _x:Number;
		private var _y:Number;
		
		private var _stageX:Number;
		private var _stageY:Number;
		
		private var _startX:Number;
		private var _startY:Number;
		
		private var _endX:Number;
		private var _endY:Number;
		
		private static var _instance:PropertyData;
		
		public function PropertyData()
		{
			if( _instance != null )
			{
				throw new Error("PropertyData Create Error");
			}
			_instance = this;
		}
		
		public static function getInstance():PropertyData
		{
			if( _instance == null )
			{
				_instance = new PropertyData();
			}
			
			return _instance
		}
		
		
		public function set x(val:Number):void
		{
			this._x = val;
		}
		
		[Bindable]
		public function get x():Number
		{
			return this._x;
		}
		
		public function set y(val:Number):void
		{
			this._y = val;
		}
		
		[Bindable]
		public function get y():Number
		{
			return this._y;
		}
		
		
		
		
		public function set stageX(val:Number):void
		{
			this._stageX = val;
		}
		
		[Bindable]
		public function get stageX():Number
		{
			return this._stageX;
		}
		
		public function set stageY(val:Number):void
		{
			this._stageY = val;
		}
		
		[Bindable]
		public function get stageY():Number
		{
			return this._stageY;
		}
		
		
		
		
		
		
		public function set startX(val:Number):void
		{
			this._startX = val;
		}
		
		[Bindable]
		public function get startX():Number
		{
			return this._startX;
		}
		
		
		public function set startY(val:Number):void
		{
			this._startY = val;
		}
		
		[Bindable]
		public function get startY():Number
		{
			return this._startY;
		}
		
		
		public function set endX(val:Number):void
		{
			this._endX = val;
		}
		
		[Bindable]
		public function get endX():Number
		{
			return this._endX;
		}
		
		
		public function set endY(val:Number):void
		{
			this._endY = val;
		}
		
		[Bindable]
		public function get endY():Number
		{
			return this._endY;
		}
	}
}