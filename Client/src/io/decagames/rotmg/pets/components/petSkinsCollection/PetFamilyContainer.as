// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petSkinsCollection.PetFamilyContainer

package io.decagames.rotmg.pets.components.petSkinsCollection{
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.pets.data.family.PetFamilyColors;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.utils.colors.Tint;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;

    public class PetFamilyContainer extends UIGridElement {

        public function PetFamilyContainer(_arg1:String, _arg2:int, _arg3:int){
            var _local5:SliceScalingBitmap;
            var _local6:UILabel;
            var _local7:SliceScalingBitmap;
            super();
            var _local4:uint = PetFamilyColors.KEYS_TO_COLORS[_arg1];
            _local5 = TextureParser.instance.getSliceScalingBitmap("UI", "content_divider_white", 320);
            Tint.add(_local5, _local4, 1);
            addChild(_local5);
            _local5.x = 10;
            _local5.y = 3;
            _local6 = new UILabel();
            DefaultLabelFormat.petFamilyLabel(_local6, 0xFFFFFF);
            _local6.text = LineBuilder.getLocalizedStringFromKey(_arg1);
            _local6.y = 0;
            _local6.x = (((320 / 2) - (_local6.width / 2)) + 10);
            _local7 = TextureParser.instance.getSliceScalingBitmap("UI", "content_divider_smalltitle_white", (_local6.width + 20));
            Tint.add(_local7, _local4, 1);
            addChild(_local7);
            _local7.x = (((320 / 2) - (_local7.width / 2)) + 10);
            _local7.y = 0;
            addChild(_local6);
        }

    }
}//package io.decagames.rotmg.pets.components.petSkinsCollection

