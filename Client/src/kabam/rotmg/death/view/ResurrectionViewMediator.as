﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.death.view.ResurrectionViewMediator

package kabam.rotmg.death.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.death.model.DeathModel;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.game.signals.PlayGameSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import flash.display.Sprite;
    import kabam.rotmg.game.model.GameInitData;

    public class ResurrectionViewMediator extends Mediator {

        [Inject]
        public var death:DeathModel;
        [Inject]
        public var view:ResurrectionView;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var playGame:PlayGameSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;


        override public function initialize():void{
            this.view.closed.add(this.onClosed);
            this.view.showDialog.add(this.onShowDialog);
            this.view.init(this.death.getLastDeath().background);
        }

        override public function destroy():void{
            this.view.showDialog.remove(this.onShowDialog);
            this.view.closed.remove(this.onClosed);
        }

        private function onShowDialog(_arg1:Sprite):void{
            this.openDialog.dispatch(_arg1);
        }

        private function onClosed():void{
            this.closeDialogs.dispatch();
            var _local1:GameInitData = new GameInitData();
            _local1.createCharacter = false;
            _local1.charId = this.playerModel.currentCharId;
            _local1.isNewGame = true;
            this.playGame.dispatch(_local1);
        }


    }
}//package kabam.rotmg.death.view

