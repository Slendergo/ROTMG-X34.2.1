// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.packages.contentPopup.PackageBoxContentPopupMediator

package io.decagames.rotmg.shop.packages.contentPopup{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import flash.utils.Dictionary;
    import io.decagames.rotmg.shop.mysteryBox.contentPopup.ItemBox;
    import io.decagames.rotmg.shop.mysteryBox.contentPopup.SlotBox;
    import io.decagames.rotmg.ui.buttons.BaseButton;
    import io.decagames.rotmg.shop.mysteryBox.contentPopup.*;

    public class PackageBoxContentPopupMediator extends Mediator {

        [Inject]
        public var view:PackageBoxContentPopup;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        private var closeButton:SliceScalingButton;
        private var contentGrids:UIGrid;


        override public function initialize():void{
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.addContentList(this.view.info.contents, this.view.info.charSlot, this.view.info.vaultSlot, this.view.info.gold);
        }

        private function addContentList(_arg1:String, _arg2:int, _arg3:int, _arg4:int):void{
            var _local7:Array;
            var _local8:Dictionary;
            var _local9:String;
            var _local10:Array;
            var _local11:String;
            var _local12:ItemBox;
            var _local13:SlotBox;
            var _local14:SlotBox;
            var _local15:SlotBox;
            var _local5:int = 5;
            var _local6:Number = (260 - _local5);
            this.contentGrids = new UIGrid(_local6, 1, 2);
            if (_arg1 != ""){
                _local7 = _arg1.split(",");
                _local8 = new Dictionary();
                for each (_local9 in _local7) {
                    if (_local8[_local9]){
                        var _local18 = _local8;
                        var _local19 = _local9;
                        var _local20 = (_local18[_local19] + 1);
                        _local18[_local19] = _local20;
                    }
                    else {
                        _local8[_local9] = 1;
                    };
                };
                _local10 = [];
                for each (_local11 in _local7) {
                    if (_local10.indexOf(_local11) == -1){
                        _local12 = new ItemBox(_local11, _local8[_local11], true, "", false);
                        this.contentGrids.addGridElement(_local12);
                        _local10.push(_local11);
                    };
                };
            };
            if (_arg2 > 0){
                _local13 = new SlotBox(SlotBox.CHAR_SLOT, _arg2, true, "", false);
                this.contentGrids.addGridElement(_local13);
            };
            if (_arg3 > 0){
                _local14 = new SlotBox(SlotBox.VAULT_SLOT, _arg3, true, "", false);
                this.contentGrids.addGridElement(_local14);
            };
            if (_arg4 > 0){
                _local15 = new SlotBox(SlotBox.GOLD_SLOT, _arg4, true, "", false);
                this.contentGrids.addGridElement(_local15);
            };
            this.contentGrids.y = (this.view.infoLabel.textHeight + 8);
            this.contentGrids.x = 10;
            this.view.addChild(this.contentGrids);
        }

        override public function destroy():void{
            this.closeButton.clickSignal.remove(this.onClose);
            this.closeButton.dispose();
            this.contentGrids.dispose();
            this.contentGrids = null;
        }

        private function onClose(_arg1:BaseButton):void{
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.shop.packages.contentPopup

