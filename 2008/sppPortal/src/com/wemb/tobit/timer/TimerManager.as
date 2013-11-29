package com.wemb.tobit.timer
{
	import flash.events.TimerEvent;
	
	import com.wemb.tobit.utils.Logger;
	import com.wemb.tobit.utils.TobitTimer;
	
	import mx.collections.ArrayCollection;
	
	public class TimerManager
	{
		private static var instance:TimerManager;
		
		private var timerAC:ArrayCollection;
	    
		private const INTERVER:Number = 10000;	//intervals 10초
		private var timer:TobitTimer;			//타이머
		
		//processID 별 Interval Time 을 갖고 있는 Object
		private var _intervalTime:Object;

		public static function getInstance():TimerManager
		{
	    	if ( instance == null )
	    	{
	        	instance = new TimerManager();
	        }	            
	        return instance;
	    }

	    public function TimerManager()
	    {
	    	if ( instance != null )
			{
				Logger.debug( "TimerManger Create Error" );
	        }
	        instance = this;

			initTimer();
		}
		
		///////////////////////////
		// initTimer
        private function initTimer():void
        {
        	timerAC = new ArrayCollection();
        }
        
        //////////////////////////////////////////////////
        // ProcessID 타이머 시작
        public function startTimer( processID:String ):void
        {
        	var vo:TimerVO = getTimer( processID );

        	if( vo.timer.running ) vo.timer.stop()
        	vo.timer.start();
        	
        	Logger.debug( "Timer Start - ", processID ); 
        	
        	ServiceManager.getInstance().executeService( processID );
        }
        
        ///////////////////////////////////////////////////
        // TIMER 가져오기
        // 기존에 생성된 타이머가 있으면 가져오고 없으면 생성한다.
        private function getTimer( processID:String ):TimerVO
        {
        	var tempTimer:TimerVO = findMatchTimer( processID );
        	
        	if( tempTimer == null )
        	{
    			timer = new TobitTimer( getIntervalTime( processID ), 0 );
        		timer.processID = processID;
        		
        		timer.addEventListener( TimerEvent.TIMER, onTimerEventHandler);
        		
        		
        		var vo:TimerVO = new TimerVO();
        		vo.processID = processID;
        		vo.timer = timer;
        		
        		timerAC.addItem( vo );
        		tempTimer = vo;
        	}
        	
        	return tempTimer;
        }
        
        //////////////////////////////////////////////////////////
        // IntervalTimer 가져오기
        // intervalTime에 일치하는 ProcessID가 없으면 DEFAULT TIME RETURN
        private function getIntervalTime( processID:String ):int
        {
        	var result:int = 0;
        	 
        	result = int(intervalTime[ processID ]);
        	if( result < 1 ) result = INTERVER;
			
			Logger.debug( "processID intervalTime: ", processID,result );
        	return  result;
        }
        
        ///////////////////////////////////////////////////
        // processID에 해당하는 Timer 삭제
        public function removeTimer( processID:String ):void
        {
        	if( timerAC != null )
        	{
	        	for( var i:int=0; i<timerAC.length; i++ )
	    		{
	    			var vo:TimerVO = timerAC[i];
	    			if( vo.processID == processID )
	    			{
	    				Logger.debug( "ProcessID: " + vo.processID + " Remove");

	    				vo.timer.stop();
	    				timerAC.removeItemAt(i);
	    				
	    				break;
	    			}
	    		}
        	}
        }
        
        ////////////////////////////////////
		// 모든 Timer 삭제
        public function removeAllTimer():void
        {
        	if( timerAC != null )
        	{
	        	for( var i:int=0; i<timerAC.length; i++ )
	    		{
	    			var vo:TimerVO = timerAC[i];

    				Logger.debug( "ProcessID: " + vo.processID + " Remove");

	    			if( vo.timer.running ) vo.timer.stop();
    				timerAC.removeItemAt(i);
	    		}
	    		
	    		timerAC = null;
	    		timerAC = new ArrayCollection();
        	}
        }
        
        //////////////////////////////////////////////////////////
		// processID 와 일치하는 TimerVO 객체 리턴
        private function findMatchTimer( processID:String ):TimerVO
        {
        	if( timerAC != null )
        	{
        		for( var i:int=0; i<timerAC.length; i++ )
        		{
        			var vo:TimerVO = timerAC[i];
        			
        			if( vo.processID == processID )
        			{
        				return vo;
        			}
        		}
        	} 
        	return null;
        }
        
        /////////////////////////////////////
		// TimerAC에 있는 모든 타이머 중지
		public function stopAllTimer():void
		{
			Logger.debug( "stop All Timer! start");
			for( var i:int=0; i<timerAC.length; i++ )
			{
				var vo:TimerVO = timerAC[i];
				
				if( vo.timer.running )
				{
					Logger.debug( "Timer Stop: ", vo.processID );
					vo.timer.stop();
				} 
			}
			Logger.debug( "stop All Timer! end");
		}
		
		///////////////////////////////////////////////////
		// TimerAC에 있는 특정 타이머 Stop
        public function stopTimer( processID:String ):void
        {
        	if( timerAC != null )
        	{
	        	for( var i:int=0; i<timerAC.length; i++ )
	    		{
	    			var vo:TimerVO = timerAC[i];
	    			if( vo.processID == processID )
	    			{
	    				Logger.debug( "stopTimer: " + vo.processID );
	    				vo.timer.stop();
	    				break;
	    			}
	    		}
        	}
        }
		
		/////////////////////////////////////////////////////////////
		// 폴링
        private function onTimerEventHandler( event:TimerEvent ):void
        {
            ServiceManager.getInstance().executeService( event.target.processID );
        }
        
		///////////////////////////////////////////////////////////
		// Setter / Getter
		public function set intervalTime( value:Object ):void
		{
			this._intervalTime = value;	
		}
		public function get intervalTime():Object
		{
			if( this._intervalTime == null )
			{
				this._intervalTime = new Object(); 
			}
			
			return this._intervalTime;
		}
		
	}
}