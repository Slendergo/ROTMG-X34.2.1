﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.util.components.InfoHoverPaneFactory

package kabam.rotmg.util.components{
    import flash.display.Sprite;
    import kabam.rotmg.pets.view.components.PopupWindowBackground;
    import flash.display.DisplayObject;

    public class InfoHoverPaneFactory extends Sprite {


        public static function make(_arg1:DisplayObject):Sprite{
            var _local4:PopupWindowBackground;
            if (_arg1 == null){
                return (null);
            };
            var _local2:Sprite = new Sprite();
            var _local3:int = 8;
            _arg1.width = (291 - _local3);
            _arg1.height = ((598 - (_local3 * 2)) - 2);
            _local2.addChild(_arg1);
            _local4 = new PopupWindowBackground();
            _local4.draw(_arg1.width, (_arg1.height + 2), PopupWindowBackground.TYPE_TRANSPARENT_WITHOUT_HEADER);
            _local4.x = _arg1.x;
            _local4.y = (_arg1.y - 1);
            _local2.addChild(_local4);
            return (_local2);
        }


    }
}//package kabam.rotmg.util.components

