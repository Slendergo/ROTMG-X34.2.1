// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.genericBox.SalePriceTag

package io.decagames.rotmg.shop.genericBox{
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import com.company.assembleegameclient.util.Currency;
    import kabam.rotmg.assets.services.IconFactory;
    import flash.display.BitmapData;

    public class SalePriceTag extends Sprite {

        private var coinBitmap:Bitmap;

        public function SalePriceTag(_arg1:int, _arg2:int){
            var _local4:Sprite;
            super();
            var _local3:UILabel = new UILabel();
            DefaultLabelFormat.originalPriceButtonLabel(_local3);
            _local3.text = _arg1.toString();
            _local4 = new Sprite();
            var _local5:BitmapData = (((_arg2 == Currency.GOLD)) ? IconFactory.makeCoin(35) : IconFactory.makeFame(35));
            this.coinBitmap = new Bitmap(_local5);
            this.coinBitmap.y = 0;
            addChild(this.coinBitmap);
            addChild(_local3);
            this.coinBitmap.x = (_local3.textWidth + 5);
            addChild(_local4);
            _local4.graphics.lineStyle(2, 0xFF002A, 0.6);
            _local4.graphics.lineTo(this.width, 0);
            _local4.y = ((_local3.textHeight + 2) / 2);
        }

        public function dispose():void{
            this.coinBitmap.bitmapData.dispose();
        }


    }
}//package io.decagames.rotmg.shop.genericBox

