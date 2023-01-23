// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.view.popup.BuyQuestRefreshButton

package io.decagames.rotmg.dailyQuests.view.popup{
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import flash.display.Bitmap;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import kabam.rotmg.assets.services.IconFactory;

    public class BuyQuestRefreshButton extends SliceScalingButton {

        private var _price:int;

        public function BuyQuestRefreshButton(_arg1:int){
            super(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button", 32));
            this._price = _arg1;
            this.init();
        }

        private function init():void{
            var _local1:Bitmap;
            this.width = 100;
            this.setLabelMargin(-10, 0);
            this.setLabel(this._price.toString(), DefaultLabelFormat.defaultButtonLabel);
            _local1 = new Bitmap(IconFactory.makeCoin());
            _local1.x = (this.width - (2 * _local1.width));
            _local1.y = ((this.height - _local1.height) / 2);
            addChild(_local1);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.popup

