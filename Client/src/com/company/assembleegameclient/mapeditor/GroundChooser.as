// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.GroundChooser

package com.company.assembleegameclient.mapeditor{
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.mapeditor.Layer;
    import flash.events.Event;
    import com.company.assembleegameclient.mapeditor.GroupDivider;
    import com.company.util.MoreStringUtil;
    import com.company.assembleegameclient.map.GroundLibrary;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.mapeditor.*;

    class GroundChooser extends Chooser {

        private var cache:Dictionary;
        private var lastSearch:String = "";

        public function GroundChooser(){
            super(Layer.GROUND);
            this._init();
        }

        private function _init():void{
            this.cache = new Dictionary();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        public function getLastSearch():String{
            return (this.lastSearch);
        }

        public function reloadObjects(_arg1:String, _arg2:String="ALL"):void{
            var _local4:RegExp;
            var _local6:String;
            var _local7:XML;
            var _local8:int;
            var _local9:GroundElement;
            removeElements();
            this.lastSearch = _arg1;
            var _local3:Vector.<String> = new Vector.<String>();
            if (_arg1 != ""){
                _local4 = new RegExp(_arg1, "gix");
            };
            var _local5:Dictionary = GroupDivider.GROUPS["Ground"];
            for each (_local7 in _local5) {
                _local6 = String(_local7.@id);
                if (!((!((_arg2 == "ALL"))) && (!(this.runFilter(_local7, _arg2))))){
                    if ((((_local4 == null)) || ((_local6.search(_local4) >= 0)))){
                        _local3.push(_local6);
                    };
                };
            };
            _local3.sort(MoreStringUtil.cmp);
            for each (_local6 in _local3) {
                _local8 = GroundLibrary.idToType_[_local6];
                _local7 = GroundLibrary.xmlLibrary_[_local8];
                if (!this.cache[_local8]){
                    _local9 = new GroundElement(_local7);
                    this.cache[_local8] = _local9;
                }
                else {
                    _local9 = this.cache[_local8];
                };
                addElement(_local9);
            };
            hasBeenLoaded = true;
            scrollBar_.setIndicatorSize(HEIGHT, elementContainer_.height, true);
        }

        private function runFilter(_arg1:XML, _arg2:String):Boolean{
            var _local3:int;
            switch (_arg2){
                case ObjectLibrary.TILE_FILTER_LIST[1]:
                    return (!(_arg1.hasOwnProperty("NoWalk")));
                case ObjectLibrary.TILE_FILTER_LIST[2]:
                    return (_arg1.hasOwnProperty("NoWalk"));
                case ObjectLibrary.TILE_FILTER_LIST[3]:
                    return (((_arg1.hasOwnProperty("Speed")) && ((Number(_arg1.elements("Speed")) < 1))));
                case ObjectLibrary.TILE_FILTER_LIST[4]:
                    return (((!(_arg1.hasOwnProperty("Speed"))) || ((Number(_arg1.elements("Speed")) >= 1))));
            };
            return true;
        }


    }
}//package com.company.assembleegameclient.mapeditor

