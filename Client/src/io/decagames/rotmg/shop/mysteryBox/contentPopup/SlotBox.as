// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.mysteryBox.contentPopup.SlotBox

package io.decagames.rotmg.shop.mysteryBox.contentPopup{
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Bitmap;
    import flash.text.TextFieldAutoSize;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.display.Shape;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.assets.services.IconFactory;

    public class SlotBox extends UIGridElement {

        public static const CHAR_SLOT:String = "CHAR_SLOT";
        public static const VAULT_SLOT:String = "VAULT_SLOT";
        public static const GOLD_SLOT:String = "GOLD_SLOT";

        private var itemSize:int = 40;
        private var itemMargin:int = 2;
        private var _itemBackground:Sprite;
        private var targetWidth:int = 260;
        private var showFullName:Boolean;
        private var isLastElement:Boolean;
        private var amount:int;
        private var label:UILabel;
        private var isBackgroundCleared:Boolean;
        private var _slotType:String;
        private var imageBitmap:Bitmap;

        public function SlotBox(_arg1:String, _arg2:int, _arg3:Boolean, _arg4:String="", _arg5:Boolean=false){
            this.isLastElement = _arg5;
            this.amount = _arg2;
            this.showFullName = _arg3;
            this._slotType = _arg1;
            this.label = new UILabel();
            this.label.multiline = true;
            this.label.autoSize = TextFieldAutoSize.LEFT;
            this.label.wordWrap = true;
            DefaultLabelFormat.mysteryBoxContentItemName(this.label);
            this.drawBackground("", _arg5, 260);
            this.drawElement(_arg2);
            this.resizeLabel();
        }

        private function buildCharSlotIcon():Shape{
            var _local1:Shape = new Shape();
            _local1.graphics.beginFill(3880246);
            _local1.graphics.lineStyle(1, 4603457);
            _local1.graphics.drawCircle(19, 19, 19);
            _local1.graphics.lineStyle();
            _local1.graphics.endFill();
            _local1.graphics.beginFill(0x1F1F1F);
            _local1.graphics.drawRect(11, 17, 16, 4);
            _local1.graphics.endFill();
            _local1.graphics.beginFill(0x1F1F1F);
            _local1.graphics.drawRect(17, 11, 4, 16);
            _local1.graphics.endFill();
            _local1.scaleX = 0.95;
            _local1.scaleY = 0.95;
            return (_local1);
        }

        private function drawElement(_arg1:int):void{
            var _local2:String;
            var _local3:BitmapData;
            var _local4:BitmapData;
            this._itemBackground = new Sprite();
            this._itemBackground.graphics.clear();
            this._itemBackground.graphics.beginFill(0xFFFFFF, 0);
            this._itemBackground.graphics.drawRect(0, 0, this.itemSize, this.itemSize);
            this._itemBackground.graphics.endFill();
            addChild(this._itemBackground);
            this._itemBackground.x = 10;
            this._itemBackground.y = 4;
            switch (this._slotType){
                case CHAR_SLOT:
                    _local2 = (_arg1.toString() + "x Character Slot");
                    this._itemBackground.addChild(this.buildCharSlotIcon());
                    break;
                case VAULT_SLOT:
                    _local2 = (_arg1.toString() + "x Vault Slot");
                    _local3 = ObjectLibrary.getRedrawnTextureFromType(ObjectLibrary.idToType_["Vault Chest"], (this._itemBackground.width * 2), true, false);
                    this.imageBitmap = new Bitmap(_local3);
                    this.imageBitmap.x = -(Math.round(((this.imageBitmap.width - this.itemSize) / 2)));
                    this.imageBitmap.y = -(Math.round(((this.imageBitmap.height - this.itemSize) / 2)));
                    this._itemBackground.addChild(this.imageBitmap);
                    break;
                case GOLD_SLOT:
                    _local2 = (_arg1.toString() + " Gold");
                    _local4 = IconFactory.makeCoin((this._itemBackground.width * 2));
                    this.imageBitmap = new Bitmap(_local4);
                    this.imageBitmap.x = -(Math.round(((this.imageBitmap.width - this.itemSize) / 2)));
                    this.imageBitmap.y = (-(Math.round(((this.imageBitmap.height - this.itemSize) / 2))) - 2);
                    this._itemBackground.addChild(this.imageBitmap);
                    break;
            };
            if (this.showFullName){
                this.label.text = _local2;
                this.label.x = 55;
            }
            else {
                this.label.text = (_arg1 + "x");
                this.label.x = 10;
                this._itemBackground.x = (this._itemBackground.x + (this.label.x + 10));
            };
            addChild(this.label);
        }

        private function resizeLabel():void{
            this.label.width = ((this.targetWidth - (this.itemSize + (2 * this.itemMargin))) - 16);
            this.label.y = (((height - this.label.textHeight) - 4) / 2);
        }

        override public function resize(_arg1:int, _arg2:int=-1):void{
            if (!this.isBackgroundCleared){
                this.drawBackground("", this.isLastElement, _arg1);
            };
            this.targetWidth = _arg1;
            this.resizeLabel();
        }

        override public function dispose():void{
            if (this.imageBitmap){
                this.imageBitmap.bitmapData.dispose();
            };
            super.dispose();
        }

        public function get itemId():String{
            return ("Vault Chest");
        }

        public function get itemBackground():Sprite{
            return (this._itemBackground);
        }

        private function drawBackground(_arg1:String, _arg2:Boolean, _arg3:int):void{
            if (_arg1 == ""){
                this.graphics.clear();
                this.graphics.beginFill(0x2D2D2D);
                this.graphics.drawRect(0, 0, _arg3, (this.itemSize + (2 * this.itemMargin)));
                this.graphics.endFill();
            };
        }

        public function get slotType():String{
            return (this._slotType);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

