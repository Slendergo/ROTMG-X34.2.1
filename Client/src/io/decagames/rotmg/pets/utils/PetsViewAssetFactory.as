// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.utils.PetsViewAssetFactory

package io.decagames.rotmg.pets.utils{
    import flash.display.Shape;
    import kabam.rotmg.pets.view.components.DialogCloseButton;
    import com.company.assembleegameclient.ui.LineBreakDesign;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import flash.filters.DropShadowFilter;

    public class PetsViewAssetFactory {


        public static function returnPetSlotShape(_arg1:uint, _arg2:uint, _arg3:int, _arg4:Boolean, _arg5:Boolean, _arg6:int=2):Shape{
            var _local7:Shape = new Shape();
            ((_arg4) && (_local7.graphics.beginFill(0x464646, 1)));
            ((_arg5) && (_local7.graphics.lineStyle(_arg6, _arg2)));
            _local7.graphics.drawRoundRect(0, _arg3, _arg1, _arg1, 16, 16);
            _local7.x = ((100 - _arg1) * 0.5);
            return (_local7);
        }

        public static function returnCloseButton(_arg1:int):DialogCloseButton{
            var _local2:DialogCloseButton;
            _local2 = new DialogCloseButton();
            _local2.y = 4;
            _local2.x = ((_arg1 - _local2.width) - 5);
            return (_local2);
        }

        public static function returnTooltipLineBreak():LineBreakDesign{
            var _local1:LineBreakDesign = new LineBreakDesign(173, 0);
            _local1.x = 5;
            _local1.y = 92;
            return (_local1);
        }

        public static function returnBitmap(_arg1:uint, _arg2:uint=80):Bitmap{
            return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg1, _arg2, true)));
        }

        public static function returnCaretakerBitmap(_arg1:uint):Bitmap{
            return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg1, 80, true, true, 10)));
        }

        public static function returnTextfield(_arg1:int, _arg2:int, _arg3:Boolean, _arg4:Boolean=false):TextFieldDisplayConcrete{
            var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
            _local5.setSize(_arg2).setColor(_arg1).setBold(_arg3);
            _local5.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
            _local5.filters = ((_arg4) ? [new DropShadowFilter(0, 0, 0)] : []);
            return (_local5);
        }


    }
}//package io.decagames.rotmg.pets.utils

