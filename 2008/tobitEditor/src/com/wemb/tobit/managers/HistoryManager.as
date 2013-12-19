package com.wemb.tobit.managers
{
	import com.wemb.tobit.pure.ApplicationFacade;
	import com.wemb.tobit.pure.Constants;
	import com.wemb.tobit.vo.PageInfo;
	
	public class HistoryManager
	{
		private static var _instance : HistoryManager;
		
		/**
		 * 지난 페이지의 목록리스트 입니다.
		 */
		private var historyList:Array;
		
		/**
		 * 앞으로 가기 페이지의 목록리스트 입니다.
		 */
		private var nextList:Array;
		
		
		/**
		 * 맵편집에서 그룹을 클릭했을때 상위 페이지 정보를 저장하도록 한다.
		 */
		private var upperHistoryList:Array;
		
		/**
		 * 현재 보여지고 있는 페이지
		 */
		private var currentPageInfo:PageInfo;
		
		/**
		 * 전 페이지 리스트중 탑에 위치한다.
		 */
		private var prevPageInfo:PageInfo;
		
		
		/**
		 * 싱글턴의 인스턴스 리턴.
		 * */
		public static function getInstance():HistoryManager
		{
			if(_instance == null)
			{
				_instance = new HistoryManager();
			}
			return _instance;
		}
		
		
		public function HistoryManager(){
			
			if(_instance != null){
				throw new Error("HistoryManager Create Error");
			}
			historyList = new Array();
			nextList = new Array();
			upperHistoryList = new Array();
		}
		
		/**
		 * 히스토리페이지 등록한다.
		 */
		public function addHistory(pageInfo:PageInfo, type:String=""):void{
			if(!historyList){
				historyList = new Array();
			}
			// 이전을 누르고 들어온 경우가 아니라 페이지를 타고 들어온 경우
			if(!(type == "up" || type == "down")){
				nextList = new Array();
			}
			//currentPage에 등록된게 있으면 리스트에 등록한다.
			if(currentPageInfo){
				if( currentPageInfo.menuId != pageInfo.menuId ){
					historyList.push(currentPageInfo);
					
					//10이상이면 전페이지 삭제한다.
					if(historyList.length > 10)
						historyList.shift();
					
					
					prevPageInfo = currentPageInfo;
					currentPageInfo = pageInfo;
				}
			}else{
				prevPageInfo = currentPageInfo;
				currentPageInfo = pageInfo;
			}
			
			ApplicationFacade.getInstance().sendNotification(Constants.ADD_HISTORY);
		}
		
		public function getAllHistory():Array{
			return historyList;
		}
		
		public function getAllNext():Array{
			return nextList;
		}
		
		public function getHistory():PageInfo{
			// 히스토리 페이지 처리
			if(historyList.length > 0){
				nextList.push(currentPageInfo); // 다음리스트에 등록됨
				currentPageInfo = historyList.pop()
				if(historyList.length > 0){
					prevPageInfo = historyList[historyList.length - 1];
				}else{
					prevPageInfo = null;
				}
			}
			return currentPageInfo;
		}
		
		public function getNext():PageInfo{
			var nPageInfo:PageInfo = currentPageInfo;
			// 히스토리 페이지 처리
			if(nextList.length > 0){
				nPageInfo = nextList.pop();
			}
			return nPageInfo;
		}
		
		public function getUpperHistory():PageInfo{
			var pageInfo:PageInfo = null;
			return pageInfo;
		}
		
		public function resetHistoryList():void{
			historyList	= new Array();
			upperHistoryList	= new Array();
		}
		
		/**
		 * 현재 내 페이지를 알기 위함 
		 */
		public function getCurrentPageInfo():PageInfo{
			return currentPageInfo;
		}
		
		/**
		 * 이전 페이지를 알기 위함 
		 */
		public function getPrevPageInfo():PageInfo{
			return prevPageInfo;
		}
		
		public function remove():void{
			historyList	= new Array();
			nextList = new Array();
			currentPageInfo = null;
			prevPageInfo = null;
			
		}
		
	}
}