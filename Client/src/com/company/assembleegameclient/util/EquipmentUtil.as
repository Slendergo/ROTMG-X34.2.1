// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.util.EquipmentUtil

package com.company.assembleegameclient.util{
    import flash.display.Bitmap;
    import kabam.rotmg.constants.ItemConstants;
    import flash.display.BitmapData;

    public class EquipmentUtil {

        public static const NUM_SLOTS:uint = 4;


        public static function getEquipmentBackground(_arg1:int, _arg2:Number=1):Bitmap{
            var _local3:Bitmap;
            var _local4:BitmapData = ItemConstants.itemTypeToBaseSprite(_arg1);
            if (_local4 != null){
                _local3 = new Bitmap(_local4);
                _local3.scaleX = _arg2;
                _local3.scaleY = _arg2;
            }
            return (_local3);
        }


    }
}//package com.company.assembleegameclient.util

