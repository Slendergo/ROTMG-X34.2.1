// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.ui.view.CurrentCharacterMediator

package kabam.rotmg.ui.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
    import kabam.rotmg.game.signals.PlayGameSignal;
    import kabam.rotmg.ui.signals.NameChangedSignal;
    import kabam.rotmg.packages.control.InitPackagesSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
    import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
    import com.company.assembleegameclient.screens.ServersScreen;
    import com.company.assembleegameclient.screens.NewCharacterScreen;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import kabam.rotmg.classes.model.CharacterClass;
    import kabam.rotmg.game.model.GameInitData;

    public class CurrentCharacterMediator extends Mediator {

        [Inject]
        public var view:CharacterSelectionAndNewsScreen;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var classesModel:ClassesModel;
        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var setScreenWithValidData:SetScreenWithValidDataSignal;
        [Inject]
        public var playGame:PlayGameSignal;
        [Inject]
        public var nameChanged:NameChangedSignal;
        [Inject]
        public var initPackages:InitPackagesSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var addToQueueSignal:AddPopupToStartupQueueSignal;
        [Inject]
        public var flushQueueSignal:FlushPopupStartupQueueSignal;

        override public function initialize():void {
            this.view.initialize(this.playerModel);
            this.view.close.add(this.onClose);
            this.view.newCharacter.add(this.onNewCharacter);
            this.view.showClasses.add(this.onNewCharacter);
            this.view.playGame.add(this.onPlayGame);
            this.view.serversClicked.add(this.showServersScreen);
            this.nameChanged.add(this.onNameChanged);
            this.initPackages.dispatch();
        }

        override public function destroy():void{
            this.nameChanged.remove(this.onNameChanged);
            this.view.close.remove(this.onClose);
            this.view.newCharacter.remove(this.onNewCharacter);
            this.view.showClasses.remove(this.onNewCharacter);
            this.view.playGame.remove(this.onPlayGame);
        }

        private function onNameChanged(_arg1:String):void{
            this.view.setName(_arg1);
        }

        private function showServersScreen():void{
            this.setScreen.dispatch(new ServersScreen());
        }

        private function onNewCharacter():void{
            this.setScreen.dispatch(new NewCharacterScreen());
        }

        private function onClose():void{
            this.playerModel.isInvalidated = true;
            this.playerModel.isLogOutLogIn = true;
            this.setScreenWithValidData.dispatch(new TitleView());
        }

        private function onPlayGame():void{
            var _local1:SavedCharacter = this.playerModel.getCharacterByIndex(0);
            this.playerModel.currentCharId = _local1.charId();
            var _local2:CharacterClass = this.classesModel.getCharacterClass(_local1.objectType());
            _local2.setIsSelected(true);
            _local2.skins.getSkin(_local1.skinType()).setIsSelected(true);
            var _local4:GameInitData = new GameInitData();
            _local4.createCharacter = false;
            _local4.charId = _local1.charId();
            _local4.isNewGame = true;
            this.playGame.dispatch(_local4);
        }


    }
}//package kabam.rotmg.ui.view

