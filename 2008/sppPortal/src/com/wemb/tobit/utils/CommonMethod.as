package com.wemb.tobit.utils
{
	import com.wemb.tobit.vo.BizOrderInfo;
	import com.wemb.tobit.vo.ColorInfo;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.formatters.NumberFormatter;
	
	public class CommonMethod
	{
		public function CommonMethod()
		{
		}
		
		/**
		 * TOBIT_XXX_XXXXXXX형식의 문자열에서
		 * 가운데 XXX만을 그룹아이디로 인식하고 리턴해준다.
		 * 
		 */
		public static function getGroupId(value:String):String
		{
			var startIndex:Number = value.indexOf("_", 0) + 1;
			var endIndex:Number = value.indexOf("_", startIndex);
			return value.substring(startIndex, endIndex);
		}
		
		/**
		 * Severity Color 리턴
		 * 
		 */
		public static function getSeverityColor(value:String):Number
		{
			if ( Number(value) == 0 ) return ColorInfo.COLOR_NORMAL;
			else if ( Number(value) == 1 ) return ColorInfo.COLOR_WARNING;
			else if ( Number(value) == 2 ) return ColorInfo.COLOR_MINOR;
			else if ( Number(value) == 3 ) return ColorInfo.COLOR_MAJOR;
			else if ( Number(value) == 4 ) return ColorInfo.COLOR_CRITICAL;
			return ColorInfo.COLOR_NORMAL;
		}
		
		/**
		 * Severity 문자열 리턴
		 * 
		 */
		public static function getSeverity(value:String):String
		{
			if ( Number(value) == 0 ) return "normal";
			else if ( Number(value) == 1 ) return "warning";
			else if ( Number(value) == 2 ) return "minor";
			else if ( Number(value) == 3 ) return "major";
			else if ( Number(value) == 4 ) return "critical";
			else if ( Number(value) == -1 ) return "disable";
			return "unknown";
		}
		
		/**
		 * 세자리 숫자 쉼표
		 * 
		 */
		public static function getThousandsSeparator(value:String):String
		{
			var nf:NumberFormatter = new NumberFormatter();
			nf.useThousandsSeparator = true;
			
			return nf.format(Number(value));
		}
		
		/**
		 * 0을 0.0 으로 변환
		 * 
		 */
		public static function chageZero(value:String):String
		{
			var nf:NumberFormatter = new NumberFormatter();
			nf.precision = 2;
			if ( value == "0" ) return "0.00";
			
			return nf.format(value);
		}
		
		
		public static function BizXmlToArrayCollection(xml:XML, type:String=null):ArrayCollection
		{
			var dataProvider:ArrayCollection = new ArrayCollection();
			for( var i:int=0; i<xml.RESOURCE.length(); i++)
			{
				var order:Number;
				if ( type == null ) order = getBizOrder(xml.RESOURCE[i].BIZ_CODE.toString());
				else order = getBizOrder(xml.RESOURCE[i].BIZ_GROUP.toString());
				
				dataProvider.addItem(  {BIZ_CODE:xml.RESOURCE[i].BIZ_CODE.toString(),
										E2E_RESP:xml.RESOURCE[i].E2E_RESP.toString(),
										E2E_CNT:xml.RESOURCE[i].E2E_CNT.toString(),
										E2E_SEV:xml.RESOURCE[i].E2E_SEV.toString(),
										SVC_ID:xml.RESOURCE[i].SVC_ID.toString(),
										BIZ_GROUP:xml.RESOURCE[i].BIZ_GROUP.toString(),
										E2E_CNT_TOT:xml.RESOURCE[i].E2E_CNT_TOT.toString(),
										ORDER:order } );
			}
			
            var sortA:Sort = new Sort();
            var sortByOrder:SortField = new SortField("ORDER", true, false, true);
            sortA.fields = [sortByOrder];
            if ( type != null )
            {
            	var sortByCode:SortField = new SortField("SVC_ID", true, false);
            	sortA.fields = [sortByOrder,sortByCode];
            }            
            dataProvider.sort = sortA;
            dataProvider.refresh();
            
            return dataProvider;
		}
		
		public static function BizAllXmlToArrayCollection(xml:XML, type:String=null):ArrayCollection
		{
			var dataProvider:ArrayCollection = new ArrayCollection();
			var nf:NumberFormatter = new NumberFormatter();
			nf.precision = 2;
			for( var i:int=0; i<xml.RESOURCE.length(); i++)
			{
				var order:Number = getBizOrder(xml.RESOURCE[i].BIZ_CODE.toString());
												
				dataProvider.addItem(  {BIZ_CODE:xml.RESOURCE[i].BIZ_CODE.toString(),
										E2E_RESP:nf.format(xml.RESOURCE[i].E2E_RESP),
										E2E_CNT:xml.RESOURCE[i].E2E_CNT.toString(),
										HTS_CNT:xml.RESOURCE[i].HTS_CNT.toString(),
										HTS_RESP:nf.format(xml.RESOURCE[i].HTS_RESP),
										MCI_CNT:xml.RESOURCE[i].MCI_CNT.toString(),
										MCI_RESP:nf.format(xml.RESOURCE[i].MCI_RESP),
										AP_CNT:xml.RESOURCE[i].AP_CNT.toString(),
										AP_RESP:nf.format(xml.RESOURCE[i].AP_RESP),
										DBMS_CNT:xml.RESOURCE[i].DBMS_CNT.toString(),
										DBMS_RESP:nf.format(xml.RESOURCE[i].DBMS_RESP),
										INTERFACE_CNT:xml.RESOURCE[i].INTERFACE_CNT.toString(),
										INTERFACE_RESP:nf.format(xml.RESOURCE[i].INTERFACE_RESP),
										ORDER:order } );
			}
			
            var sortA:Sort = new Sort();
            var sortByOrder:SortField = new SortField("ORDER", true, false, true);
            sortA.fields = [sortByOrder];
            dataProvider.sort = sortA;
            dataProvider.refresh();
            
            return dataProvider;
		}
        
        /**
		 * biz order
		 * 
		 */
		public static function getBizOrder(label:String):Number
		{
			for( var i:int; i<BizOrderInfo.bizOrder_ac.length; i++)
			{
				if ( label == BizOrderInfo.bizOrder_ac.getItemAt(i).label )
				{
					return i;
				}
			}
			return -1;
		}
	}
}