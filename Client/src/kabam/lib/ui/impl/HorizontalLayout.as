﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.ui.impl.HorizontalLayout

package kabam.lib.ui.impl{
    import flash.display.DisplayObject;
    import kabam.lib.ui.api.*;

    public class HorizontalLayout implements Layout {

        private var padding:int = 0;


        public function getPadding():int{
            return (this.padding);
        }

        public function setPadding(_arg1:int):void{
            this.padding = _arg1;
        }

        public function layout(_arg1:Vector.<DisplayObject>, _arg2:int=0):void{
            var _local6:DisplayObject;
            var _local3:int = _arg2;
            var _local4:int = _arg1.length;
            var _local5:int;
            while (_local5 < _local4) {
                _local6 = _arg1[_local5];
                _local6.x = _local3;
                _local3 = (_local3 + (_local6.width + this.padding));
                _local5++;
            };
        }


    }
}//package kabam.lib.ui.impl

