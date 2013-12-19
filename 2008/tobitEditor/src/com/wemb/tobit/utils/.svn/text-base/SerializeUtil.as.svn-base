package com.wemb.tobit.utils
{
	import flash.utils.ByteArray;
	
	/**
	 * Object를 직렬화 하는 Util
	 * 
	 * @author 정태훈(thlife@wemb.co.kr)
	 * 
	 */	
	public class SerializeUtil
	{
		public function SerializeUtil()
		{
			
		}
		
		
		/**
		 * 
		 * @param object
		 * @return 
		 * 
		 */		
		public static function ObjectToString( object:* ):String
		{
			var ba: ByteArray = new ByteArray();
			
			ba.writeObject(object);
			
			return ba.toString();
		}
		
		
		/**
		 * 
		 * @param object
		 * @return 
		 * 
		 */		
		public static function ObjectToByteArray( object:* ):ByteArray
		{
			var ba:ByteArray = new ByteArray();
			
			ba.writeObject(object);
			ba.position = 0;
			
			return ba;
		}
		
		
		/**
		 * 
		 * @param obj1
		 * @param obj2
		 * @return 
		 * 
		 */		
		public static function compareObject(obj1:Object,obj2:Object):Boolean
		{
		    var buffer1:ByteArray = new ByteArray();
		    buffer1.writeObject(obj1);
		    
		    var buffer2:ByteArray = new ByteArray();
		    buffer2.writeObject(obj2);
		 
		    // compare the lengths
		    var size:uint = buffer1.length;
		    if( buffer1.length == buffer2.length )
		    {
		        buffer1.position = 0;
		        buffer2.position = 0;
		 
		        // then the bits
		        while( buffer1.position < size )
		        {
		            var v1:int = buffer1.readByte();
		            if( v1 != buffer2.readByte() )
		            {
		                return false;
		            }
		        }    
		        return true;                        
		    }
		    return false;
		}
	}
}