// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.packages.PackageBoxTile

package io.decagames.rotmg.shop.packages{
    import io.decagames.rotmg.shop.genericBox.GenericBoxTile;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import flash.display.Sprite;
    import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
    import flash.display.Loader;
    import kabam.rotmg.packages.model.PackageInfo;

    public class PackageBoxTile extends GenericBoxTile {

        private var imageMask:SliceScalingBitmap;

        public function PackageBoxTile(_arg1:GenericBoxInfo, _arg2:Boolean=false){
            buyButtonBitmapBackground = "buy_button_background";
            backgroundContainer = new Sprite();
            super(_arg1, _arg2);
        }

        override protected function createBoxBackground():void{
            addChild(backgroundContainer);
            this.resizeBackgroundImage();
        }

        private function resizeBackgroundImage():void{
            var _local1:Loader;
            if (_isPopup){
                _local1 = PackageInfo(_boxInfo).popupLoader;
            }
            else {
                _local1 = PackageInfo(_boxInfo).loader;
            }
            if (((_local1) && (!((_local1.parent == backgroundContainer))))){
                backgroundContainer.addChild(_local1);
                backgroundContainer.cacheAsBitmap = true;
                this.imageMask = background.clone();
                addChild(this.imageMask);
                this.imageMask.cacheAsBitmap = true;
                backgroundContainer.mask = this.imageMask;
            }
            if (this.imageMask){
                this.imageMask.width = (background.width - 6);
                this.imageMask.height = (background.height - 6);
                this.imageMask.x = (background.x + 3);
                this.imageMask.y = (background.y + 3);
                this.imageMask.cacheAsBitmap = true;
            }
        }

        override public function dispose():void{
            this.imageMask.dispose();
            super.dispose();
        }

        override public function resize(_arg1:int, _arg2:int=-1):void{
            background.width = _arg1;
            if (backgroundTitle){
                backgroundTitle.width = _arg1;
                backgroundTitle.y = 2;
            }
            backgroundButton.width = 158;
            if (_arg2 == -1){
                background.height = 184;
            }
            else {
                background.height = _arg2;
            }
            titleLabel.x = Math.round(((_arg1 - titleLabel.textWidth) / 2));
            titleLabel.y = 6;
            backgroundButton.y = (background.height - 51);
            backgroundButton.x = Math.round(((_arg1 - backgroundButton.width) / 2));
            _buyButton.y = (backgroundButton.y + 4);
            _buyButton.x = (((backgroundButton.x + backgroundButton.width) - _buyButton.width) - 6);
            if (_infoButton){
                _infoButton.x = ((background.width - _infoButton.width) - 3);
                _infoButton.y = 2;
            }
            _spinner.x = (backgroundButton.x + 34);
            _spinner.y = (background.height - 53);
            this.resizeBackgroundImage();
            updateSaleLabel();
            updateClickMask(_arg1);
            updateStartTimeString(_arg1);
            updateTimeEndString(_arg1);
        }


    }
}//package io.decagames.rotmg.shop.packages

