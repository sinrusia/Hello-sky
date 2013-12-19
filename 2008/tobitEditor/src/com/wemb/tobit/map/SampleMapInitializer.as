package com.wemb.tobit.map
{
	import com.wemb.tobit.TobitMapInitializer;
	import com.wemb.tobit.components.TobitComponent;
	import com.wemb.tobit.components.symbol.TGroup;
	import com.wemb.tobit.factory.TobitComponentDefinition;
	import com.wemb.tobit.factory.TobitSymbolTypeDefinition;
	import com.wemb.tobit.map.symbol.AIRAP1242Fas;
	import com.wemb.tobit.map.symbol.AServer;
	import com.wemb.tobit.map.symbol.AServer02;
	import com.wemb.tobit.map.symbol.AVServer;
	import com.wemb.tobit.map.symbol.AVServer02;
	import com.wemb.tobit.map.symbol.BigIP6400;
	import com.wemb.tobit.map.symbol.COM3IPS;
	import com.wemb.tobit.map.symbol.COM3IPSTPM60;
	import com.wemb.tobit.map.symbol.Circle;
	import com.wemb.tobit.map.symbol.CirclePanel;
	import com.wemb.tobit.map.symbol.Cisco2621XM;
	import com.wemb.tobit.map.symbol.Cisco3800;
	import com.wemb.tobit.map.symbol.CiscoCatalyst2950;
	import com.wemb.tobit.map.symbol.CiscoCatalyst2960;
	import com.wemb.tobit.map.symbol.CiscoCatalyst2970;
	import com.wemb.tobit.map.symbol.CiscoCatalyst3560;
	import com.wemb.tobit.map.symbol.CiscoCatalyst3750;
	import com.wemb.tobit.map.symbol.CiscoCatalyst4507R;
	import com.wemb.tobit.map.symbol.CiscoCatalyst4948;
	import com.wemb.tobit.map.symbol.CiscoCatalyst6509;
	import com.wemb.tobit.map.symbol.DB;
	import com.wemb.tobit.map.symbol.DGroup;
	import com.wemb.tobit.map.symbol.Group_mc;
	import com.wemb.tobit.map.symbol.HPA500;
	import com.wemb.tobit.map.symbol.HPK260;
	import com.wemb.tobit.map.symbol.HPL2000;
	import com.wemb.tobit.map.symbol.HPRP3400;
	import com.wemb.tobit.map.symbol.HPRP4440;
	import com.wemb.tobit.map.symbol.HPRX6600;
	import com.wemb.tobit.map.symbol.HPRX7640;
	import com.wemb.tobit.map.symbol.IBM70266H1;
	import com.wemb.tobit.map.symbol.IBM7040681;
	import com.wemb.tobit.map.symbol.IBMP650;
	import com.wemb.tobit.map.symbol.IBMP68204E8A;
	import com.wemb.tobit.map.symbol.IBMRS6000P570;
	import com.wemb.tobit.map.symbol.MainSymbol;
	import com.wemb.tobit.map.symbol.MapRackSymbol;
	import com.wemb.tobit.map.symbol.NAS;
	import com.wemb.tobit.map.symbol.NGroup;
	import com.wemb.tobit.map.symbol.NetworkGroup;
	import com.wemb.tobit.map.symbol.NokiaFirewall;
	import com.wemb.tobit.map.symbol.NokiaIP1220;
	import com.wemb.tobit.map.symbol.NwGroup2;
	import com.wemb.tobit.map.symbol.ProdLarge;
	import com.wemb.tobit.map.symbol.ProdWhite;
	import com.wemb.tobit.map.symbol.RectanglePanel;
	import com.wemb.tobit.map.symbol.Res3;
	import com.wemb.tobit.map.symbol.Router;
	import com.wemb.tobit.map.symbol.SANSwitch32Port;
	import com.wemb.tobit.map.symbol.SANSwitchDCX;
	import com.wemb.tobit.map.symbol.SANSwitchDirector;
	import com.wemb.tobit.map.symbol.SGroup;
	import com.wemb.tobit.map.symbol.SUNFireE4900;
	import com.wemb.tobit.map.symbol.SUNFireT1000;
	import com.wemb.tobit.map.symbol.SUNLibrary;
	import com.wemb.tobit.map.symbol.SUNM8000;
	import com.wemb.tobit.map.symbol.SmsGroup;
	import com.wemb.tobit.map.symbol.SunFireT2000;
	import com.wemb.tobit.map.symbol.Switch;
	import com.wemb.tobit.map.symbol.System_mc;
	import com.wemb.tobit.map.symbol.TAP;
	import com.wemb.tobit.map.symbol.TAS;
	import com.wemb.tobit.map.symbol.TBTS10200;
	import com.wemb.tobit.map.symbol.TBackbone;
	import com.wemb.tobit.map.symbol.TBridge;
	import com.wemb.tobit.map.symbol.TBuilding;
	import com.wemb.tobit.map.symbol.TCache;
	import com.wemb.tobit.map.symbol.TCisco3750S;
	import com.wemb.tobit.map.symbol.TCisco4000S;
	import com.wemb.tobit.map.symbol.TCisco7507;
	import com.wemb.tobit.map.symbol.TCisco7600R;
	import com.wemb.tobit.map.symbol.TCloud;
	import com.wemb.tobit.map.symbol.TFW;
	import com.wemb.tobit.map.symbol.TFirewall;
	import com.wemb.tobit.map.symbol.TGigabit;
	import com.wemb.tobit.map.symbol.TGroupBD;
	import com.wemb.tobit.map.symbol.TIPS;
	import com.wemb.tobit.map.symbol.TL4;
	import com.wemb.tobit.map.symbol.TLD;
	import com.wemb.tobit.map.symbol.TLRS;
	import com.wemb.tobit.map.symbol.TMA;
	import com.wemb.tobit.map.symbol.TNAT;
	import com.wemb.tobit.map.symbol.TNetGroup;
	import com.wemb.tobit.map.symbol.TPixFW;
	import com.wemb.tobit.map.symbol.TRouter;
	import com.wemb.tobit.map.symbol.TSSLO;
	import com.wemb.tobit.map.symbol.TSwitch;
	import com.wemb.tobit.map.symbol.TUps;
	import com.wemb.tobit.map.symbol.TVPN;
	import com.wemb.tobit.map.symbol.TVPNC;
	import com.wemb.tobit.map.symbol.TVS;
	import com.wemb.tobit.map.symbol.TimeSync;
	import com.wemb.tobit.map.symbol.USPVM;
	import com.wemb.tobit.map.symbol.VTL;
	import com.wemb.tobit.map.symbol.Was;
	import com.wemb.tobit.map.symbol.proframe;
	
	import edu.comp.MyComponent;
	
	import flash.sampler.sampleInternalAllocs;
	
	public class SampleMapInitializer extends TobitMapInitializer
	{
		/** Component definition*/
		//NH추가 심볼
		public static const _Group_mc:String = "Group_mc";
		public static const _Was:String = "Was";
		public static const _Res3:String = "Res3";
		public static const _NwGroup2:String = "NwGroup2";
		public static const _System_mc:String = "System_mc";
		public static const _proframe:String = "proframe";
		
		// Business Group
		public static const BUSINESS_GROUP_COMPONENT:String = "BusinessGroupComponent";
		// Rack
		public static const RACK_COMPONENT:String = "RackComponent";
		// Network Performance
		public static const NETWORK_PERFORMANCE_COMPONENT:String = "NetworkPerformanceComponent";
		// 
		public static const CLASSIFICATION_PANEL:String = "ClassificationPanel";
		// 
		public static const EVENT_BROWSER:String = "EventBrowser";
		//jini
		public static const FUND:String = "Fund";
		public static const USER_RESPONSE_TIME:String = "User_Response_Time";
		public static const RESPONSETIME_COMP:String = "ResponseTime_Comp";
		public static const BATCH_COMP:String = "Batch_Comp";
		public static const BACKUP_COMP:String = "Backup_Comp";
		public static const PUBLIC_COMP:String = "Public_Comp";
		public static const FINANCE_COMP:String = "Finance_Comp";
		
		//상철 추가(신한카드)
		public static const _Database_Big:String = "Database_Big";
		public static const _Database_Small:String = "Database_Small";
		public static const _QueBox:String = "QueBox";
		public static const _TrafficLabel:String = "TrafficLabel";
		public static const _Trans_Label:String = "Trans_Label";
		public static const _Gauge_Bar:String = "Gauge_Bar";
		public static const _Car_Gauge_Bar:String = "Car_Gauge_Bar";
		public static const _Small_Gauge:String = "Small_Gauge";
		
		//jini Symbol
		public static const SERVER_GROUP_COMP:String = "ServerGroupComp";
		public static const _SGROUP:String ="SGroup";
		
		public static const NETWORK_GROUP_COMP:String = "NetworkGroupComp";
		public static const _NGROUP:String ="NGroup";
		
		public static const DATABASE_GROUP_COMP:String = "DataBaseGroupComp";
		public static const _DGROUP:String = "DGroup";
		
		//  
		public static const EVENT_MESSAGE_STATUS_CHART:String = "EventMessageStatusChart";
		//
		public static const TOP_PERF_CHART:String = "TopPerfChar";
		
		public static const JUSEOK_COMP:String = "JuseokComp";
				
		public static const JUSUK_COMP:String = "JuSukComp";
		
		public static const FMSSTATUS:String = "FmsStatus";
		
		
		
		
		/** Symbol definition */
		public static const _NetworkGroup:String = "NetworkGroup";
		public static const _AServer:String = "AServer";
		public static const _AVServer:String = "AVServer";
		public static const _AServer02:String = "AServer02";
		public static const _AVServer02:String = "AVServer02";
		
		public static const _DB:String = "DB";
		public static const _Circle:String = "Circle";
		
		public static const _HPA500:String = "HPA500";
		public static const _HPK260:String = "HPK260";
		public static const _HPL2000:String = "HPL2000";
		public static const _HPRP3400:String = "HPRP3400";
		public static const _HPRP4440:String = "HPRP4440";
		public static const _HPRX6600:String = "HPRX6600";
		public static const _HPRX7640:String = "HPRX7640";
		
		public static const _IBM70266H1:String = "IBM70266H1";
		public static const _IBM7040681:String = "IBM7040681";
		public static const _IBMP650:String = "IBMP650";
		public static const _IBMP68204E8A:String = "IBMP68204E8A";
		public static const _IBMRS6000P570:String = "IBMRS6000P570";
		
		public static const _SUNFireE4900:String = "SUNFireE4900";
		public static const _SUNFireT1000:String = "SUNFireT1000";
		public static const _SunFireT2000:String = "SunFireT2000";
		public static const _SUNLibrary:String = "SUNLibrary";
		public static const _SUNM8000:String = "SUNM8000";
		
		public static const _Cisco2621XM:String = "Cisco2621XM";
		public static const _CiscoCatalyst2950:String = "CiscoCatalyst2950";
		public static const _CiscoCatalyst2960:String = "CiscoCatalyst2960";
		public static const _CiscoCatalyst2970:String = "CiscoCatalyst2970";
		public static const _CiscoCatalyst3560:String = "CiscoCatalyst3560";
		public static const _CiscoCatalyst3750:String = "CiscoCatalyst3750";
		public static const _CiscoCatalyst4948:String = "CiscoCatalyst4948";
		public static const _Cisco3800:String = "Cisco3800";
		
		public static const _MapRackSymbol:String = "MapRackSymbol";
		public static const _diskBox:String = "diskBox";
		public static const _diskBox2:String = "diskBox2";
		public static const _dwdm:String = "dwdm";
		public static const _emc:String = "emc";
		public static const _NAS:String = "NAS";
		public static const _SANSwitch32Port:String = "SANSwitch32Port";
		public static const _SANSwitchDCX:String = "SANSwitchDCX";
		public static const _SANSwitchDirector:String = "SANSwitchDirector";
		public static const _Switch:String = "Switch";
		public static const _TCloud:String = "TCloud";
		public static const _TUps:String = "TUps";
		public static const _Router:String = "Router";
		public static const _TGroup:String = "TGroup";
		public static const _TFirewall:String = "TFirewall";
		public static const _TGroupBD:String = "TGroupBD";
		public static const _TimeSync:String = "TimeSync";
		public static const _USPVM:String = "USPVM";
		public static const _VTL:String = "VTL";
		public static const _MainSymbol:String = "MainSymbol";
		
		public static const _NokiaIP1220:String = "NokiaIP1220";
		public static const _NokiaFirewall:String = "NokiaFirewall";
		
		public static const _BigIP6400:String = "BigIP6400";
		public static const _COM3IPSTPM60:String = "COM3IPSTPM60";
		public static const _ProdWhite:String = "ProdWhite";
		public static const _ProdLarge:String = "ProdLarge";
		
		public static const _CiscoCatalyst4507R:String = "CiscoCatalyst4507R";
		public static const _CiscoCatalyst6509:String = "CiscoCatalyst6509";
		public static const _COM3IPS:String = "COM3IPS";
		
		public static const _AIRAP1242Fas:String = "AIRAP1242Fas";
		
		
		public static const _CirclePanel:String = "CirclePanel";
		public static const _RectanglePanel:String = "RectanglePanel";
		
		
		
		
		//======================================================================================================
		public static const _TAP:String = "TAP";
		public static const _TAS:String = "TAS";
		public static const _TBackbone:String = "TBackbone";
		public static const _TBridge:String = "TBridge";
		public static const _TBTS10200:String = "TBTS10200";
		public static const _TBuilding:String = "TBuilding";
		public static const _TCache:String = "TCache";
		public static const _TCisco3750S:String = "TCisco3750S";
		public static const _TCisco4000S:String = "TCisco4000S";
		public static const _TCisco7507:String = "TCisco7507";
		public static const _TCisco7600R:String = "TCisco7600R";
		public static const _TFW:String = "TFW";
		public static const _TGigabit:String = "TGigabit";
		public static const _TIPS:String = "TIPS";
		public static const _TL4:String = "TL4";
		public static const _TLD:String = "TLD";
		public static const _TLRS:String = "TLRS";
		public static const _TMA:String = "TMA";
		public static const _TNAT:String = "TNAT";
		public static const _TNetGroup:String = "TNetGroup";
		public static const _TPixFW:String = "TPixFW";
		public static const _TRouter:String = "TRouter";
		public static const _TSSLO:String = "TSSLO";
		public static const _TSwitch:String = "TSwitch";
		public static const _TVPN:String = "TVPN";
		public static const _TVPNC:String = "TVPNC";
		public static const _TVS:String = "TVS";
		public static const _SMSGROUP:String = "SmsGroup";
		public static const _SGroup:String ="SGroup";
		//======================================================================================================
		
		
		public function SampleMapInitializer()
		{
		}
		
		public static function init():void
		{
			TobitMapInitializer.init();
			/*------------------------------------------------------------ 
			 * Component Registration
			 *------------------------------------------------------------*/
			
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._Group_mc, Group_mc);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._Was, Was);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._Res3, Res3);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._NwGroup2, NwGroup2);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._System_mc, System_mc);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._proframe, proframe);
			
			/*------------------------------------------------------------ 
			 * Symbol Registration
			 *------------------------------------------------------------*/
			//Dbran Symbol
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._NGROUP, NGroup);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._DGROUP, DGroup);
			
			/* Network Group */
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._NetworkGroup, NetworkGroup);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SMSGROUP, SmsGroup);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._AServer, AServer);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._AVServer, AVServer);
			
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._AServer02, AServer02);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._AVServer02, AVServer02);
			
			
			/* Application Symbol */
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._DB, DB);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._Circle, Circle);
			/* HP */
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._HPA500, HPA500);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._HPK260, HPK260);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._HPL2000, HPL2000);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._HPRP3400, HPRP3400);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._HPRP4440, HPRP4440);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._HPRX6600, HPRX6600);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._HPRX7640, HPRX7640);
			
			/* IBM */
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._IBM70266H1, IBM70266H1);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._IBM7040681, IBM7040681);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._IBMP650, IBMP650);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._IBMP68204E8A, IBMP68204E8A);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._IBMRS6000P570, IBMRS6000P570);
			
			/* SUN */
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SUNFireE4900, SUNFireE4900);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SUNFireT1000, SUNFireT1000);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SunFireT2000, SunFireT2000);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SUNLibrary, SUNLibrary);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SUNM8000, SUNM8000);
			
			/* Cisco  */
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._Cisco2621XM, Cisco2621XM);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._Cisco3800, Cisco3800);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._CiscoCatalyst2950, CiscoCatalyst2950);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._CiscoCatalyst2960, CiscoCatalyst2960);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._CiscoCatalyst2970, CiscoCatalyst2970);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._CiscoCatalyst3560, CiscoCatalyst3560);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._CiscoCatalyst3750, CiscoCatalyst3750);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._CiscoCatalyst4948, CiscoCatalyst4948);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._CiscoCatalyst4507R, CiscoCatalyst4507R);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._CiscoCatalyst6509, CiscoCatalyst6509);
	
			/* 기타 */
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._MapRackSymbol, MapRackSymbol);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._NAS, NAS);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SANSwitch32Port, SANSwitch32Port);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SANSwitchDCX, SANSwitchDCX);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SANSwitchDirector, SANSwitchDirector);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._Switch, Switch);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TCloud, TCloud);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TUps, TUps);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._Router, Router);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TGroup, TGroup);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TFirewall, TFirewall);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TGroupBD, TGroupBD);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TimeSync, TimeSync);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._USPVM, USPVM);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._VTL, VTL);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._MainSymbol, MainSymbol);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._NokiaIP1220, NokiaIP1220);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._NokiaFirewall, NokiaFirewall);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._BigIP6400, BigIP6400);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._COM3IPSTPM60, COM3IPSTPM60);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._ProdWhite, ProdWhite);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._ProdLarge, ProdLarge);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._COM3IPS, COM3IPS);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._AIRAP1242Fas, AIRAP1242Fas);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._SGROUP,SGroup);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._RectanglePanel, RectanglePanel);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._CirclePanel, CirclePanel);
			
			
			
			
			
			//======================================================================================================
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TAP, TAP);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TAS, TAS);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TBackbone, TBackbone);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TBridge, TBridge);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TBTS10200, TBTS10200);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TBuilding, TBuilding);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TCache, TCache);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TCisco3750S, TCisco3750S);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TCisco4000S, TCisco4000S);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TCisco7507, TCisco7507);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TCisco7600R, TCisco7600R);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TCloud, TCloud);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TFW, TFW);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TGigabit, TGigabit);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TIPS, TIPS);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TL4, TL4);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TLD, TLD);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TLRS, TLRS);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TMA, TMA);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TNAT, TNAT);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TNetGroup, TNetGroup);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TPixFW, TPixFW);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TRouter, TRouter);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TSSLO, TSSLO);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TSwitch, TSwitch);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TVPN, TVPN);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TVPNC, TVPNC);
			TobitSymbolTypeDefinition.getInstance().addTobitSymbolType(SampleMapInitializer._TVS, TVS);
			//======================================================================================================
			
			
		}
	}
}