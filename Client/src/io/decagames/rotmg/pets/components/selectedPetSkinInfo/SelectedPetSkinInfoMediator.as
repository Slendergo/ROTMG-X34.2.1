﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.selectedPetSkinInfo.SelectedPetSkinInfoMediator

package io.decagames.rotmg.pets.components.selectedPetSkinInfo{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.pets.signals.SelectPetSkinSignal;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.ui.model.HUDModel;
    import io.decagames.rotmg.pets.signals.SelectPetSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.pets.signals.ChangePetSkinSignal;
    import io.decagames.rotmg.pets.data.vo.IPetVO;
    import io.decagames.rotmg.pets.data.vo.PetVO;
    import io.decagames.rotmg.pets.data.skin.SelectedPetButtonType;
    import com.company.assembleegameclient.objects.Player;
    import io.decagames.rotmg.shop.ShopBuyButton;
    import com.company.assembleegameclient.util.Currency;
    import io.decagames.rotmg.shop.NotEnoughResources;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class SelectedPetSkinInfoMediator extends Mediator {

        [Inject]
        public var view:SelectedPetSkinInfo;
        [Inject]
        public var selectPetSkinSignal:SelectPetSkinSignal;
        [Inject]
        public var model:PetsModel;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var selectPetSignal:SelectPetSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var changePetSkinSignal:ChangePetSkinSignal;
        private var selectedSkin:IPetVO;
        private var selectedPet:PetVO;


        override public function initialize():void{
            this.selectPetSkinSignal.add(this.onSkinSelected);
            this.selectPetSignal.add(this.onPetSelected);
            if (this.currentPet){
                this.currentPet.updated.add(this.currentPetUpdate);
            };
        }

        private function currentPetUpdate():void{
            this.onSkinSelected(this.selectedSkin);
        }

        private function onSkinSelected(_arg1:IPetVO):void{
            this.selectedSkin = _arg1;
            this.view.showPetInfo(_arg1);
            if ((((this.currentPet == null)) || ((_arg1 == null)))){
                this.setAction(SelectedPetButtonType.NONE, _arg1);
            }
            else {
                if (_arg1.family != this.currentPet.skinVO.family){
                    this.setAction(SelectedPetButtonType.FAMILY, _arg1);
                }
                else {
                    if (_arg1.skinType != this.currentPet.skinVO.skinType){
                        this.setAction(SelectedPetButtonType.SKIN, _arg1);
                    }
                    else {
                        this.setAction(SelectedPetButtonType.NONE, _arg1);
                    };
                };
            };
        }

        private function onPetSelected(_arg1:PetVO):void{
            this.selectedPet = _arg1;
            this.onSkinSelected(this.selectedSkin);
        }

        private function setAction(_arg1:int, _arg2:IPetVO):void{
            if (this.view.goldActionButton){
                this.view.goldActionButton.clickSignal.remove(this.onActionButtonClickHandler);
            };
            if (this.view.fameActionButton){
                this.view.fameActionButton.clickSignal.remove(this.onActionButtonClickHandler);
            };
            this.view.actionButtonType = _arg1;
            if (this.view.goldActionButton){
                this.view.goldActionButton.clickSignal.add(this.onActionButtonClickHandler);
            };
            if (this.view.fameActionButton){
                this.view.fameActionButton.clickSignal.add(this.onActionButtonClickHandler);
            };
        }

        private function get currentPet():PetVO{
            return (((this.selectedPet) ? this.selectedPet : this.model.getActivePet()));
        }

        private function get currentGold():int{
            var _local1:Player = this.gameModel.player;
            if (_local1 != null){
                return (_local1.credits_);
            };
            if (this.playerModel != null){
                return (this.playerModel.getCredits());
            };
            return (0);
        }

        private function get currentFame():int{
            var _local1:Player = this.gameModel.player;
            if (_local1 != null){
                return (_local1.fame_);
            };
            if (this.playerModel != null){
                return (this.playerModel.getFame());
            };
            return (0);
        }

        private function onActionButtonClickHandler(_arg1:BaseButton):void{
            var _local2:ShopBuyButton = ShopBuyButton(_arg1);
            switch (this.view.actionButtonType){
                case SelectedPetButtonType.SKIN:
                case SelectedPetButtonType.FAMILY:
                    if ((((((_local2.currency == Currency.GOLD)) && ((this.currentGold < _local2.price)))) || ((((_local2.currency == Currency.FAME)) && ((this.currentFame < _local2.price)))))){
                        this.showPopupSignal.dispatch(new NotEnoughResources(300, _local2.currency));
                        return;
                    };
                    break;
            };
            this.hudModel.gameSprite.gsc_.changePetSkin(this.currentPet.getID(), this.selectedSkin.skinType, _local2.currency);
            this.onSkinSelected(null);
        }

        override public function destroy():void{
            this.selectPetSkinSignal.remove(this.onSkinSelected);
            if (this.currentPet){
                this.currentPet.updated.remove(this.currentPetUpdate);
            };
            this.selectPetSignal.remove(this.onPetSelected);
        }


    }
}//package io.decagames.rotmg.pets.components.selectedPetSkinInfo

