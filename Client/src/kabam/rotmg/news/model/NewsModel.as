// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.news.model.NewsModel

package kabam.rotmg.news.model{
    import kabam.rotmg.news.controller.NewsDataUpdatedSignal;
    import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.constants.GeneralConstants;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.news.view.NewsModalPage;

    public class NewsModel {

        private static const COUNT:int = 3;
        public static const MODAL_PAGE_COUNT:int = 4;

        [Inject]
        public var update:NewsDataUpdatedSignal;
        [Inject]
        public var updateNoParams:NewsButtonRefreshSignal;
        [Inject]
        public var account:Account;
        public var news:Vector.<NewsCellVO>;
        public var modalPageData:Vector.<NewsCellVO>;
        private var inGameNews:Vector.<InGameNews>;

        public function NewsModel(){
            inGameNews = new Vector.<InGameNews>();
        }

        public function addInGameNews(_arg1:InGameNews):void{
            if (isInModeToBeShown(_arg1.showInModes)) {
                inGameNews.push(_arg1);
            }
            sortNews();
        }

        public function clearNews():void{
            if (inGameNews){
                inGameNews.length = 0;
            }
        }

        public function isInModeToBeShown(_arg1:int):Boolean{
            var _local2:Boolean;
            var _local3:Boolean = false;
            switch (_arg1){
                case GeneralConstants.MODE_ALL:
                    _local2 = true;
                    break;
                case GeneralConstants.MODE_ORIGINAL:
                    _local2 = !(_local3);
                    break;
                case GeneralConstants.MODE_RIFT:
                    _local2 = _local3;
                    break;
                default:
                    _local2 = true;
            }
            return (_local2);
        }

        private function sortNews():void{
            inGameNews.sort(function (_arg1:InGameNews, _arg2:InGameNews):int{
                if (_arg1.weight > _arg2.weight){
                    return (-1);
                }
                if (_arg1.weight == _arg2.weight){
                    return (0);
                }
                return (1);
            });
        }

        public function markAsRead():void{
            var _local1:InGameNews = getFirstNews();
            if (_local1 != null){
                Parameters.data_["lastNewsKey"] = _local1.newsKey;
                Parameters.save();
            }
        }

        public function hasUpdates():Boolean{
            var _local1:InGameNews = getFirstNews();
            if ((((_local1 == null)) || ((Parameters.data_["lastNewsKey"] == _local1.newsKey)))){
                return false;
            }
            return true;
        }

        public function getFirstNews():InGameNews{
            if (inGameNews && inGameNews.length > 0) {
                return inGameNews[0];
            }
            return null;
        }

        public function initNews():void{
            news = new Vector.<NewsCellVO>(COUNT, true);

            var _local1:int = 0;
            while (_local1 < COUNT) {
                news[_local1] = new DefaultNewsCellVO(_local1);
                _local1++;
            }
        }

        public function updateNews(_arg1:Vector.<NewsCellVO>):void{
            var _local3:NewsCellVO;
            var _local4:int;
            var _local5:int;
            initNews();
            var _local2:Vector.<NewsCellVO> = new Vector.<NewsCellVO>();
            modalPageData = new Vector.<NewsCellVO>(4, true);
            for each (_local3 in _arg1) {
                if (_local3.slot <= 3){
                    _local2.push(_local3);
                }
                else {
                    _local4 = (_local3.slot - 4);
                    _local5 = (_local4 + 1);
                    modalPageData[_local4] = _local3;
                    if (Parameters.data_[("newsTimestamp" + _local5)] != _local3.endDate){
                        Parameters.data_[("newsTimestamp" + _local5)] = _local3.endDate;
                        Parameters.data_[("hasNewsUpdate" + _local5)] = true;
                    }
                }
            }
            sortByPriority(_local2);
            update.dispatch(news);
            updateNoParams.dispatch();
        }

        private function sortByPriority(_arg1:Vector.<NewsCellVO>):void{
            var _local2:NewsCellVO;
            for each (_local2 in _arg1) {
                if(isNewsTimely(_local2)){
                    prioritize(_local2);
                }
            }
        }

        private function prioritize(_arg1:NewsCellVO):void{
            var _local2:uint = (_arg1.slot - 1);
            if (news[_local2]){
                _arg1 = comparePriority(news[_local2], _arg1);
            }
            news[_local2] = _arg1;
        }

        private function comparePriority(_arg1:NewsCellVO, _arg2:NewsCellVO):NewsCellVO{
            return ((((_arg1.priority) < _arg2.priority) ? _arg1 : _arg2));
        }

        private function isNewsTimely(_arg1:NewsCellVO):Boolean{
            var _local2:Number = new Date().getTime();
            return ((((_arg1.startDate < _local2)) && ((_local2 < _arg1.endDate))));
        }

        public function hasValidNews():Boolean{
            return (((((!((news[0] == null))) && (!((news[1] == null))))) && (!((news[2] == null)))));
        }

        public function hasValidModalNews():Boolean{
            return ((inGameNews.length > 0));
        }

        public function get numberOfNews():int{
            return (inGameNews.length);
        }

        public function getModalPage(_arg1:int):NewsModalPage{
            var _local2:InGameNews;
            if (hasValidModalNews()){
                _local2 = inGameNews[(_arg1 - 1)];
                return (new NewsModalPage(_local2.title, _local2.text));
            }
            return (new NewsModalPage("No new information", "Please check back later."));
        }
    }
}//package kabam.rotmg.news.model

