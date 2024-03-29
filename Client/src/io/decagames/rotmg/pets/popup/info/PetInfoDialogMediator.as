﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.popup.info.PetInfoDialogMediator

package io.decagames.rotmg.pets.popup.info{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class PetInfoDialogMediator extends Mediator {

        [Inject]
        public var view:PetInfoDialog;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        private var closeButton:SliceScalingButton;


        override public function initialize():void{
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.addInfo();
        }

        private function addInfo():void{
            this.view.addInfoItem(new PetInfoItem("Pets"));
            this.view.addInfoItem(new PetInfoItem("Feeding"));
            this.view.addInfoItem(new PetInfoItem("Fusing"));
            this.view.addInfoItem(new PetInfoItem("Upgrade"));
            this.view.addInfoItem(new PetInfoItem("Wardrobe"));
        }

        override public function destroy():void{
            this.closeButton.clickSignal.remove(this.onClose);
            this.closeButton.dispose();
        }

        private function onClose(_arg1:BaseButton):void{
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.pets.popup.info

