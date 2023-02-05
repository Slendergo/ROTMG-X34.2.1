// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.genericBox.GenericBoxTile

package io.decagames.rotmg.shop.genericBox{
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import org.osflash.signals.Signal;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.shop.ShopBuyButton;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.shop.ShopBoxTag;
    import io.decagames.rotmg.ui.spinner.FixedNumbersSpinner;
    import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.geom.ColorTransform;
    import io.decagames.rotmg.utils.colors.Tint;

    public class GenericBoxTile extends UIGridElement {

        public const selfRemoveSignal:Signal = new Signal();

        protected var background:SliceScalingBitmap;
        protected var backgroundTitle:SliceScalingBitmap;
        protected var buyButtonBitmapBackground:String;
        protected var backgroundButton:SliceScalingBitmap;
        protected var titleLabel:UILabel;
        protected var _buyButton:ShopBuyButton;
        protected var _infoButton:SliceScalingButton;
        protected var tags:Vector.<ShopBoxTag>;
        protected var _spinner:FixedNumbersSpinner;
        protected var _boxInfo:GenericBoxInfo;
        protected var _endTimeLabel:UILabel;
        protected var _startTimeLabel:UILabel;
        protected var originalPriceLabel:SalePriceTag;
        protected var _isPopup:Boolean;
        protected var _clickMask:Sprite;
        protected var boxHeight:int = 184;
        private var _isAvailable:Boolean = true;
        private var clickMaskAlpha:Number = 0;
        private var tagContainer:Sprite;
        protected var backgroundContainer:Sprite;

        public function GenericBoxTile(_arg1:GenericBoxInfo, _arg2:Boolean=false){
            this._boxInfo = _arg1;
            this._isPopup = _arg2;
            this.background = TextureParser.instance.getSliceScalingBitmap("UI", "shop_box_background", 10);
            this.tagContainer = new Sprite();
            if (!_arg2){
                this.backgroundTitle = TextureParser.instance.getSliceScalingBitmap("UI", "shop_title_background", 10);
                this._infoButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "tab_info_button"));
            }
            if (this.buyButtonBitmapBackground){
                this.backgroundButton = TextureParser.instance.getSliceScalingBitmap("UI", this.buyButtonBitmapBackground, 10);
            }
            this._spinner = new FixedNumbersSpinner(TextureParser.instance.getSliceScalingBitmap("UI", "spinner_up_arrow"), 0, new <int>[1, 2, 3, 5, 10], "x");
            this._spinner.y = 131;
            this._spinner.x = 43;
            this.titleLabel = new UILabel();
            this.titleLabel.text = _arg1.title;
            DefaultLabelFormat.shopBoxTitle(this.titleLabel);
            if (_arg1.isOnSale()){
                this._buyButton = new ShopBuyButton(_arg1.saleAmount, _arg1.saleCurrency);
            }
            else {
                this._buyButton = new ShopBuyButton(_arg1.priceAmount, _arg1.priceCurrency);
            }
            this._buyButton.width = 95;
            if (_arg1.unitsLeft == 0){
                this._buyButton.soldOut = true;
            }
            this._buyButton.showCampaignTooltip = true;
            this.tags = new <ShopBoxTag>[];
            addChild(this.background);
            this.createBoxBackground();
            if (this.backgroundTitle){
                addChild(this.backgroundTitle);
            }
            this._clickMask = new Sprite();
            this._clickMask.graphics.beginFill(0xFF0000, this.clickMaskAlpha);
            this._clickMask.graphics.drawRect(0, 0, 95, this.boxHeight);
            this._clickMask.graphics.endFill();
            addChild(this._clickMask);
            if (this.backgroundButton){
                addChild(this.backgroundButton);
            }
            addChild(this.titleLabel);
            if (_arg1.isOnSale()){
                this.originalPriceLabel = new SalePriceTag(_arg1.priceAmount, _arg1.priceCurrency);
                addChild(this.originalPriceLabel);
            }
            addChild(this._buyButton);
            addChild(this._spinner);
            if (!_arg2){
                addChild(this._infoButton);
            }
            addChild(this.tagContainer);
            this.createBoxTags();
            this.createEndTime();
            this.createStartTime();
            this.updateStartTimeString(this.background.width);
            this.updateTimeEndString(this.background.width);
            _arg1.updateSignal.add(this.updateBox);
        }

        private function updateBox():void{
            var _local1:ShopBoxTag = this.getTagByName(ShopBoxTag.LEFT_TAG);
            if (_local1){
                _local1.updateLabel((this.getLeftUnits() + " LEFT!"));
            }
            if ((((this.boxInfo.unitsLeft == 0)) || ((this.boxInfo.purchaseLeft == 0)))){
                this.triggerSelfRemove();
            }
        }

        private function createEndTime():void{
            this._endTimeLabel = new UILabel();
            this._endTimeLabel.y = 28;
            this._endTimeLabel.visible = false;
            addChild(this._endTimeLabel);
            if (this._isPopup){
                DefaultLabelFormat.popupEndsIn(this._endTimeLabel);
            }
            else {
                DefaultLabelFormat.mysteryBoxEndsIn(this._endTimeLabel);
            }
        }

        private function createStartTime():void{
            this._startTimeLabel = new UILabel();
            this._startTimeLabel.y = 28;
            this._startTimeLabel.visible = false;
            addChild(this._startTimeLabel);
            if (this._isPopup){
                DefaultLabelFormat.popupStartsIn(this._startTimeLabel);
            }
            else {
                DefaultLabelFormat.mysteryBoxStartsIn(this._startTimeLabel);
            }
        }

        private function getTagByName(_arg1:String):ShopBoxTag{
            var _local2:ShopBoxTag;
            for each (_local2 in this.tags) {
                if (_local2.tagName == _arg1){
                    return (_local2);
                }
            }
            return (null);
        }

        private function createBoxTags():void{
            var _local2:String;
            this.clearTagContainer();
            if (this._boxInfo.isNew()){
                this.addTag(new ShopBoxTag(ShopBoxTag.NEW_TAG, ShopBoxTag.BLUE_TAG, "NEW", this._isPopup));
            }
            var _local1:Array = this._boxInfo.tags.split(",");
            for each (_local2 in _local1) {
                switch (_local2){
                    case "best_seller":
                        this.addTag(new ShopBoxTag(ShopBoxTag.BEST_TAG, ShopBoxTag.GREEN_TAG, "BEST", this._isPopup));
                        break;
                    case "hot":
                        this.addTag(new ShopBoxTag(ShopBoxTag.HOT_TAG, ShopBoxTag.ORANGE_TAG, "HOT", this._isPopup));
                        break;
                }
            }
            if (this._boxInfo.isOnSale()){
                this.addTag(new ShopBoxTag(ShopBoxTag.PROMOTION_TAG, ShopBoxTag.RED_TAG, (this.calculateBoxPromotionPercent(this._boxInfo) + "% OFF"), this._isPopup));
            }
            if (((!((this._boxInfo.unitsLeft == -1))) || (!((this._boxInfo.purchaseLeft == -1))))){
                this.addTag(new ShopBoxTag(ShopBoxTag.LEFT_TAG, ShopBoxTag.PURPLE_TAG, (this.getLeftUnits() + " LEFT!"), this._isPopup));
            }
        }

        private function getLeftUnits():int{
            var _local1:int = (((this._boxInfo.unitsLeft == -1)) ? int.MAX_VALUE : this._boxInfo.unitsLeft);
            var _local2:int = (((this._boxInfo.purchaseLeft == -1)) ? int.MAX_VALUE : this._boxInfo.purchaseLeft);
            return (Math.min(_local1, _local2));
        }

        private function clearTagContainer():void{
            var _local3:ShopBoxTag;
            if (!this.tagContainer){
                return;
            }
            while (this.tagContainer.numChildren > 0) {
                this.tagContainer.removeChildAt(0);
            }
            var _local1:int = this.tags.length;
            var _local2:int = (_local1 - 1);
            while (_local2 >= 0) {
                _local3 = this.tags.pop();
                _local3.dispose();
                _local3 = null;
                _local2--;
            }
        }

        private function calculateBoxPromotionPercent(_arg1:GenericBoxInfo):int{
            return ((((_arg1.priceAmount - _arg1.saleAmount) / _arg1.priceAmount) * 100));
        }

        protected function createBoxBackground():void{
        }

        protected function updateTimeEndString(_arg1:int):void{
            if (!this._isAvailable){
                return;
            }
            var _local2:String = this.boxInfo.getEndTimeString();
            var _local3:String = this.boxInfo.getStartTimeString();
            if ((((_local3 == "")) && (_local2))){
                this._endTimeLabel.text = _local2;
                this._endTimeLabel.x = ((_arg1 - this._endTimeLabel.width) / 2);
                this._endTimeLabel.visible = true;
            }
            else {
                this._endTimeLabel.text = "";
            }
        }

        protected function updateStartTimeString(_arg1:int):void{
            var _local2:String = this.boxInfo.getStartTimeString();
            if (_local2){
                this._startTimeLabel.text = _local2;
                this._startTimeLabel.x = ((_arg1 - this._startTimeLabel.width) / 2);
                this.isAvailable = false;
                this._startTimeLabel.visible = true;
            }
            else {
                this.isAvailable = true;
                this._startTimeLabel.text = "";
                this._startTimeLabel.visible = false;
            }
        }

        private function set isAvailable(_arg1:Boolean):void{
            var _local2:Number;
            if (this._isAvailable == _arg1){
                return;
            }
            if (_arg1){
                this.createBoxTags();
                this._buyButton.disabled = false;
                this.background.transform.colorTransform = new ColorTransform();
                if (!this._isPopup){
                    this.backgroundTitle.transform.colorTransform = new ColorTransform();
                    if (this._infoButton.alpha != 0){
                        this._infoButton.transform.colorTransform = new ColorTransform();
                    }
                }
                this._spinner.transform.colorTransform = new ColorTransform();
                this.titleLabel.transform.colorTransform = new ColorTransform();
                this._buyButton.transform.colorTransform = new ColorTransform();
                if (this.backgroundContainer){
                    this.backgroundContainer.transform.colorTransform = new ColorTransform();
                }
                if (this.buyButtonBitmapBackground){
                    this.backgroundButton.transform.colorTransform = new ColorTransform();
                }
            }
            else {
                _local2 = 0.3;
                Tint.add(this.background, 0, _local2);
                if (!this._isPopup){
                    Tint.add(this.backgroundTitle, 0, _local2);
                    if (this._infoButton.alpha != 0){
                        Tint.add(this._infoButton, 0, _local2);
                    }
                }
                Tint.add(this._spinner, 0, _local2);
                Tint.add(this.titleLabel, 0, _local2);
                Tint.add(this._buyButton, 0, _local2);
                if (this.backgroundContainer){
                    Tint.add(this.backgroundContainer, 0, _local2);
                }
                this._buyButton.disabled = true;
                if (this.buyButtonBitmapBackground){
                    Tint.add(this.backgroundButton, 0, _local2);
                }
            }
            this._isAvailable = _arg1;
        }

        override public function get height():Number{
            return (this.background.height);
        }

        override public function resize(_arg1:int, _arg2:int=-1):void{
            this.background.width = _arg1;
            this.backgroundTitle.width = _arg1;
            this.backgroundButton.width = _arg1;
            this.background.height = this.boxHeight;
            this.backgroundTitle.y = 2;
            this.titleLabel.x = Math.round(((_arg1 - this.titleLabel.textWidth) / 2));
            this.titleLabel.y = 6;
            if (this.backgroundButton){
                this.backgroundButton.y = 133;
                this._buyButton.y = (this.backgroundButton.y + 4);
                this._buyButton.x = (_arg1 - 110);
            }
            else {
                this._buyButton.y = 137;
                this._buyButton.x = (_arg1 - 110);
            }
            if (this._infoButton){
                this._infoButton.x = 130;
                this._infoButton.y = 45;
            }
            this.updateSaleLabel();
            this.updateClickMask(_arg1);
            this.updateStartTimeString(_arg1);
            this.updateTimeEndString(_arg1);
        }

        protected function updateClickMask(_arg1:int):void{
            var _local2:int;
            if (!this._isPopup){
                this.backgroundTitle = TextureParser.instance.getSliceScalingBitmap("UI", "shop_title_background", 10);
                _local2 = ((this.backgroundTitle.y + this.backgroundTitle.height) + 2);
                this._clickMask.y = _local2;
            }
            if (this.backgroundButton){
                this.boxHeight = (this.boxHeight - ((this.boxHeight - this.backgroundButton.y) + 4));
            }
            this._clickMask.graphics.clear();
            this._clickMask.graphics.beginFill(0xFF0000, this.clickMaskAlpha);
            this._clickMask.graphics.drawRect(0, 0, _arg1, (this.boxHeight - _local2));
            this._clickMask.graphics.endFill();
        }

        protected function updateSaleLabel():void{
            if (this.originalPriceLabel){
                this.originalPriceLabel.y = (this._buyButton.y - 23);
                this.originalPriceLabel.x = (((this._buyButton.x + this._buyButton.width) - this.originalPriceLabel.width) - 13);
            }
        }

        override public function update():void{
            this.updateStartTimeString(this.background.width);
            this.updateTimeEndString(this.background.width);
            if (((!(this._isPopup)) && (((!((this._startTimeLabel.text == ""))) || (!((this._endTimeLabel.text == ""))))))){
                this.tagContainer.y = 10;
            }
            else {
                this.tagContainer.y = 0;
            }
            if (((((this._isAvailable) && ((this._endTimeLabel.text == "")))) && (this.boxInfo.endTime))){
                this.triggerSelfRemove();
            }
        }

        private function triggerSelfRemove():void{
            this.selfRemoveSignal.dispatch();
            this.selfRemoveSignal.removeAll();
        }

        public function addTag(_arg1:ShopBoxTag):void{
            this.tagContainer.addChild(_arg1);
            _arg1.y = (33 + (this.tags.length * _arg1.height));
            _arg1.x = -5;
            this.tags.push(_arg1);
        }

        public function get spinner():FixedNumbersSpinner{
            return (this._spinner);
        }

        public function get buyButton():ShopBuyButton{
            return (this._buyButton);
        }

        public function get boxInfo():GenericBoxInfo{
            return (this._boxInfo);
        }

        override public function dispose():void{
            var _local1:ShopBoxTag;
            this.boxInfo.updateSignal.remove(this.updateBox);
            this.selfRemoveSignal.removeAll();
            this.background.dispose();
            if (this.backgroundTitle){
                this.backgroundTitle.dispose();
            }
            this.backgroundButton.dispose();
            this._buyButton.dispose();
            if (this._infoButton){
                this._infoButton.dispose();
            }
            this._spinner.dispose();
            if (this.originalPriceLabel){
                this.originalPriceLabel.dispose();
            }
            for each (_local1 in this.tags) {
                _local1.dispose();
            }
            this.tags = null;
            super.dispose();
        }

        public function get infoButton():SliceScalingButton{
            return (this._infoButton);
        }

        public function get isPopup():Boolean{
            return (this._isPopup);
        }

        public function get clickMask():Sprite{
            return (this._clickMask);
        }


    }
}//package io.decagames.rotmg.shop.genericBox

