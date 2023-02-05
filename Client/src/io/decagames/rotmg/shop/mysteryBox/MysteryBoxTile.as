// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.mysteryBox.MysteryBoxTile

package io.decagames.rotmg.shop.mysteryBox{
    import io.decagames.rotmg.shop.genericBox.GenericBoxTile;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import flash.geom.Point;
    import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
    import io.decagames.rotmg.shop.mysteryBox.contentPopup.UIItemContainer;

    public class MysteryBoxTile extends GenericBoxTile {

        private var displayedItemsGrid:UIGrid;
        private var maxResultHeight:int = 75;
        private var maxResultWidth:int;
        private var resultElementWidth:int;
        private var gridConfig:Point;

        public function MysteryBoxTile(_arg1:MysteryBoxInfo){
            buyButtonBitmapBackground = "shop_box_button_background";
            super(_arg1);
        }

        private function prepareResultGrid(_arg1:int):void{
            this.maxResultWidth = 160;
            this.gridConfig = this.calculateGrid(_arg1);
            this.resultElementWidth = this.calculateElementSize(this.gridConfig);
            this.displayedItemsGrid = new UIGrid((this.resultElementWidth * this.gridConfig.x), this.gridConfig.x, 0);
            this.displayedItemsGrid.x = (20 + Math.round(((this.maxResultWidth - (this.resultElementWidth * this.gridConfig.x)) / 2)));
            this.displayedItemsGrid.y = Math.round((42 + ((this.maxResultHeight - (this.resultElementWidth * this.gridConfig.y)) / 2)));
            this.displayedItemsGrid.centerLastRow = true;
            addChild(this.displayedItemsGrid);
        }

        private function calculateGrid(_arg1:int):Point{
            var _local5:int;
            var _local6:int;
            var _local2:Point = new Point(11, 4);
            var _local3:int = int.MIN_VALUE;
            if (_arg1 >= (_local2.x * _local2.y)){
                return (_local2);
            }
            var _local4:int = 11;
            while (_local4 >= 1) {
                _local5 = 4;
                while (_local5 >= 1) {
                    if (((((_local4 * _local5) >= _arg1)) && ((((_local4 - 1) * (_local5 - 1)) < _arg1)))){
                        _local6 = this.calculateElementSize(new Point(_local4, _local5));
                        if (_local6 != -1){
                            if (_local6 > _local3){
                                _local3 = _local6;
                                _local2 = new Point(_local4, _local5);
                            }
                            else {
                                if (_local6 == _local3){
                                    if (((_local2.x * _local2.y) - _arg1) > ((_local4 * _local5) - _arg1)){
                                        _local3 = _local6;
                                        _local2 = new Point(_local4, _local5);
                                    }
                                }
                            }
                        }
                    }
                    _local5--;
                }
                _local4--;
            }
            return (_local2);
        }

        private function calculateElementSize(_arg1:Point):int{
            var _local2:int = Math.floor((this.maxResultHeight / _arg1.y));
            if ((_local2 * _arg1.x) > this.maxResultWidth){
                _local2 = Math.floor((this.maxResultWidth / _arg1.x));
            }
            if ((_local2 * _arg1.y) > this.maxResultHeight){
                return (-1);
            }
            return (_local2);
        }

        override protected function createBoxBackground():void{
            var _local2:int;
            var _local4:UIItemContainer;
            var _local1:Array = MysteryBoxInfo(_boxInfo).displayedItems.split(",");
            if ((((_local1.length == 0)) || ((MysteryBoxInfo(_boxInfo).displayedItems == "")))){
                return;
            }
            if (_infoButton){
                _infoButton.alpha = 0;
            }
            switch (_local1.length){
                case 1:
                    break;
                case 2:
                    _local2 = 50;
                    break;
                case 3:
                    break;
            }
            this.prepareResultGrid(_local1.length);
            var _local3:int;
            while (_local3 < _local1.length) {
                _local4 = new UIItemContainer(_local1[_local3], 0, 0, this.resultElementWidth);
                this.displayedItemsGrid.addGridElement(_local4);
                _local3++;
            }
        }

        override public function resize(_arg1:int, _arg2:int=-1):void{
            background.width = _arg1;
            backgroundTitle.width = _arg1;
            backgroundButton.width = _arg1;
            background.height = 184;
            backgroundTitle.y = 2;
            titleLabel.x = Math.round(((_arg1 - titleLabel.textWidth) / 2));
            titleLabel.y = 6;
            backgroundButton.y = 133;
            _buyButton.y = (backgroundButton.y + 4);
            _buyButton.x = (_arg1 - 110);
            _infoButton.x = 130;
            _infoButton.y = 45;
            if (this.displayedItemsGrid){
                this.displayedItemsGrid.x = (10 + Math.round(((this.maxResultWidth - (this.resultElementWidth * this.gridConfig.x)) / 2)));
            }
            updateSaleLabel();
            updateClickMask(_arg1);
            updateStartTimeString(_arg1);
            updateTimeEndString(_arg1);
        }

        override public function dispose():void{
            if (this.displayedItemsGrid){
                this.displayedItemsGrid.dispose();
            }
            super.dispose();
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox

