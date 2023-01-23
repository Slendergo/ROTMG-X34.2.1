// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.mysteryBox.contentPopup.UIItemContainer

package io.decagames.rotmg.shop.mysteryBox.contentPopup{
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import flash.display.BitmapData;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.text.TextFormat;
    import kabam.rotmg.text.model.FontModel;
    import flash.filters.DropShadowFilter;

    public class UIItemContainer extends UIGridElement {

        private var _itemId:int;
        private var size:int;
        private var background:uint;
        private var backgroundAlpha:Number;
        private var _imageBitmap:Bitmap;
        private var _quantity:int = 1;
        private var _showTooltip:Boolean;

        public function UIItemContainer(_arg1:int, _arg2:uint, _arg3:Number=0, _arg4:int=40){
            this._itemId = _arg1;
            this.size = _arg4;
            this.background = _arg2;
            this.backgroundAlpha = _arg3;
            this.graphics.clear();
            this.graphics.beginFill(_arg2, _arg3);
            this.graphics.drawRect(0, 0, _arg4, _arg4);
            this.graphics.endFill();
            var _local5:BitmapData = ObjectLibrary.getRedrawnTextureFromType(int(_arg1), (_arg4 * 2), true, false);
            this._imageBitmap = new Bitmap(_local5);
            this._imageBitmap.x = -(Math.round(((this._imageBitmap.width - _arg4) / 2)));
            this._imageBitmap.y = -(Math.round(((this._imageBitmap.height - _arg4) / 2)));
            this.addChild(this._imageBitmap);
        }

        override public function dispose():void{
            this._imageBitmap.bitmapData.dispose();
            super.dispose();
        }

        public function showQuantityLabel(_arg1:int):void{
            var _local2:UILabel;
            this._quantity = _arg1;
            _local2 = new UILabel();
            var _local3:TextFormat = new TextFormat();
            _local3.color = 0xFFFFFF;
            _local3.bold = true;
            _local3.font = FontModel.DEFAULT_FONT_NAME;
            _local3.size = (this.size * 0.35);
            _local2.defaultTextFormat = _local3;
            _local2.text = (_arg1 + "x");
            _local2.y = ((this.size - _local2.textHeight) - (this.size * 0.1));
            _local2.x = ((this.size - _local2.textWidth) - (this.size * 0.1));
            _local2.filters = [new DropShadowFilter(1, 90, 0, 0.5, 4, 4)];
            addChild(_local2);
        }

        public function clone():UIItemContainer{
            var _local1:UIItemContainer = new UIItemContainer(this._itemId, this.background, this.backgroundAlpha, this.size);
            if (this._quantity > 1){
                _local1.showQuantityLabel(this._quantity);
            };
            return (_local1);
        }

        public function get itemId():int{
            return (this._itemId);
        }

        override public function get width():Number{
            return (this.size);
        }

        override public function get height():Number{
            return (this.size);
        }

        public function get imageBitmap():Bitmap{
            return (this._imageBitmap);
        }

        public function get showTooltip():Boolean{
            return (this._showTooltip);
        }

        public function set showTooltip(_arg1:Boolean):void{
            this._showTooltip = _arg1;
        }

        public function get quantity():int{
            return (this._quantity);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

