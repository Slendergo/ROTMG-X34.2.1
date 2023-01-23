// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.EquipmentToolTipFactory

package com.company.assembleegameclient.ui{
    import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
    import com.company.assembleegameclient.objects.Player;
    import flash.display.Sprite;

    public class EquipmentToolTipFactory {


        public function make(_arg1:int, _arg2:Player, _arg3:int, _arg4:String, _arg5:uint):Sprite{
            return (new EquipmentToolTip(_arg1, _arg2, _arg3, _arg4));
        }


    }
}//package com.company.assembleegameclient.ui

