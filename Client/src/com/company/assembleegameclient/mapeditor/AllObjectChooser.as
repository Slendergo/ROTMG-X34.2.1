// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.AllObjectChooser

package com.company.assembleegameclient.mapeditor{
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.mapeditor.Layer;
    import com.company.assembleegameclient.mapeditor.GroupDivider;
    import com.company.util.MoreStringUtil;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.mapeditor.*;

    class AllObjectChooser extends Chooser {

        public static const GROUP_NAME_MAP_OBJECTS:String = "All Map Objects";
        public static const GROUP_NAME_GAME_OBJECTS:String = "All Game Objects";

        private var cache:Dictionary;
        private var lastSearch:String = "";

        public function AllObjectChooser(){
            super(Layer.OBJECT);
            this.cache = new Dictionary();
        }

        public function getLastSearch():String{
            return (this.lastSearch);
        }

        public function reloadObjects(_arg1:String="", _arg2:String="All Map Objects"):void{
            var _local4:RegExp;
            var _local6:String;
            var _local7:int;
            var _local8:XML;
            var _local9:int;
            var _local10:ObjectElement;
            removeElements();
            this.lastSearch = _arg1;
            var _local3:Vector.<String> = new Vector.<String>();
            if (_arg1 != ""){
                _local4 = new RegExp(_arg1, "gix");
            }
            var _local5:Dictionary = GroupDivider.GROUPS[_arg2];
            for each (_local8 in _local5) {
                _local6 = String(_local8.@id);
                _local7 = int(_local8.@type);
                if ((((((_local4 == null)) || ((_local6.search(_local4) >= 0)))) || ((_local7 == int(_arg1))))){
                    _local3.push(_local6);
                }
            }
            _local3.sort(MoreStringUtil.cmp);
            for each (_local6 in _local3) {
                _local9 = ObjectLibrary.idToType_[_local6];
                _local8 = ObjectLibrary.xmlLibrary_[_local9];
                if (!this.cache[_local9]){
                    _local10 = new ObjectElement(_local8);
                    if (_arg2 == GROUP_NAME_GAME_OBJECTS){
                        _local10.downloadOnly = true;
                    }
                    this.cache[_local9] = _local10;
                }
                else {
                    _local10 = this.cache[_local9];
                }
                addElement(_local10);
            }
            hasBeenLoaded = true;
            scrollBar_.setIndicatorSize(HEIGHT, elementContainer_.height, true);
        }


    }
}//package com.company.assembleegameclient.mapeditor

