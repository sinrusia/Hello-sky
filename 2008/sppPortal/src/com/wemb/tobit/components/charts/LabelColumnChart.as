package com.wemb.tobit.components.charts
{
	import flash.events.Event;
	
	import mx.charts.ColumnChart;

	public class LabelColumnChart extends ColumnChart
	{
		//-----------------------------------------------
		//
		// Variables
		//
		//-----------------------------------------------
		
		/**
		 * 라벨 Visible 컨트롤
		 * 
		 */
		private var _labelVisible:Boolean = true;
		
		/**
		 * 라벨 변경 Flag 
		 */		
		private var labelVisibleChanged:Boolean;
		
		/**
		 * 데이터 변경 Flag
		 */		
		private var dataChanged:Boolean;
		
		//-----------------------------------------------
		//
		// Functions
		//
		//-----------------------------------------------
		public function LabelColumnChart()
		{
			super();
		}
		
		
		
		//-----------------------------------------------
		//
		// Override
		//
		//-----------------------------------------------
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		/**
		 * 
		 * 
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if( labelVisibleChanged )
			{
				labelVisibleChanged = false;
			}
			
			if( dataChanged )
			{
				dataChanged = false;
				
				//데이터 변경됨을 Chart에 이벤트 통지
				//그래야 label 숨겨짐
				dispatchEvent( new Event("dataChanged") );
			}

			invalidateDisplayList();
		}
		
		
		
		//-----------------------------------------------
		//
		// Setter / Getter
		//
		//-----------------------------------------------
		public function set labelVisible( value:Boolean ):void
		{
			if( this._labelVisible != value )
			{
				this._labelVisible = value;
				
				labelVisibleChanged = true;
			}
			
			invalidateProperties();
		}
		
		public function get labelVisible():Boolean
		{
			return this._labelVisible;
		}
		
		override public function set dataProvider(value:Object):void
		{
			super.dataProvider = value;
			
			dataChanged = true;
			
			invalidateProperties();
		}
	}
}