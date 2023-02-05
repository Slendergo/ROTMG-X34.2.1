// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.EnemyChooser

package com.company.assembleegameclient.mapeditor{
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.mapeditor.Layer;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.mapeditor.GroupDivider;
    import com.company.util.MoreStringUtil;
    import com.company.assembleegameclient.mapeditor.*;

    class EnemyChooser extends Chooser {

        private var cache:Dictionary;
        private var lastSearch:String = "";
        private var filterTypes:Dictionary;

        public function EnemyChooser(){
            this.filterTypes = new Dictionary(true);
            super(Layer.OBJECT);
            this.cache = new Dictionary();
            this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[0]] = "";
            this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[1]] = "MaxHitPoints";
            this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[2]] = ObjectLibrary.ENEMY_FILTER_LIST[2];
        }

        public function getLastSearch():String{
            return (this.lastSearch);
        }

        public function reloadObjects(_arg1:String, _arg2:String="", _arg3:Number=0, _arg4:Number=-1):void{
            var _local7:XML;
            var _local10:RegExp;
            var _local12:String;
            var _local13:int;
            var _local14:ObjectElement;
            removeElements();
            this.lastSearch = _arg1;
            var _local5:Boolean = true;
            var _local6:Boolean = true;
            var _local8:Number = -1;
            var _local9:Vector.<String> = new Vector.<String>();
            if (_arg1 != ""){
                _local10 = new RegExp(_arg1, "gix");
            }
            if (_arg2 != ""){
                _arg2 = this.filterTypes[_arg2];
            }
            var _local11:Dictionary = GroupDivider.GROUPS["Enemies"];
            for each (_local7 in _local11) {
                _local12 = String(_local7.@id);
                if (!((!((_local10 == null))) && ((_local12.search(_local10) < 0)))){
                    if (_arg2 != ""){
                        _local8 = ((_local7.hasOwnProperty(_arg2)) ? Number(_local7.elements(_arg2)) : -1);
                        if (_local8 < 0) continue;
                        _local5 = (_local8 >= _arg3);
                        _local6 = !((((_arg4 > 0)) && ((_local8 > _arg4))));
                    }
                    if (((_local5) && (_local6))){
                        _local9.push(_local12);
                    }
                }
            }
            _local9.sort(MoreStringUtil.cmp);
            for each (_local12 in _local9) {
                _local13 = ObjectLibrary.idToType_[_local12];
                if (!this.cache[_local13]){
                    _local14 = new ObjectElement(ObjectLibrary.xmlLibrary_[_local13]);
                    this.cache[_local13] = _local14;
                }
                else {
                    _local14 = this.cache[_local13];
                }
                addElement(_local14);
            }
            hasBeenLoaded = true;
            scrollBar_.setIndicatorSize(HEIGHT, elementContainer_.height, true);
        }


    }
}//package com.company.assembleegameclient.mapeditor

