// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.DungeonChooser

package com.company.assembleegameclient.mapeditor{
    import flash.utils.Dictionary;
    import com.company.util.MoreStringUtil;
    import com.company.assembleegameclient.objects.ObjectLibrary;

    public class DungeonChooser extends Chooser {

        public var currentDungon:String = "";
        private var cache:Dictionary;
        private var lastSearch:String = "";

        public function DungeonChooser(){
            super(Layer.OBJECT);
            this.cache = new Dictionary();
        }

        public function getLastSearch():String{
            return (this.lastSearch);
        }

        public function reloadObjects(_arg1:String, _arg2:String):void{
            var _local4:RegExp;
            var _local6:String;
            var _local7:XML;
            var _local8:int;
            var _local9:ObjectElement;
            this.currentDungon = _arg1;
            removeElements();
            this.lastSearch = _arg2;
            var _local3:Vector.<String> = new Vector.<String>();
            if (_arg2 != ""){
                _local4 = new RegExp(_arg2, "gix");
            };
            var _local5:Dictionary = GroupDivider.getDungeonsXML(this.currentDungon);
            for each (_local7 in _local5) {
                _local6 = String(_local7.@id);
                if ((((_local4 == null)) || ((_local6.search(_local4) >= 0)))){
                    _local3.push(_local6);
                };
            };
            _local3.sort(MoreStringUtil.cmp);
            for each (_local6 in _local3) {
                _local8 = ObjectLibrary.idToType_[_local6];
                _local7 = _local5[_local8];
                if (!this.cache[_local8]){
                    _local9 = new ObjectElement(_local7);
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


    }
}//package com.company.assembleegameclient.mapeditor

