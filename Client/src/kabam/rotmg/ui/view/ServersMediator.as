// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.ui.view.ServersMediator

package kabam.rotmg.ui.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.screens.ServersScreen;
    import kabam.rotmg.servers.api.ServerModel;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.servers.api.Server;
    import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

    public class ServersMediator extends Mediator {

        [Inject]
        public var view:ServersScreen;
        [Inject]
        public var servers:ServerModel;
        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;

        override public function initialize():void{
            this.view.gotoTitle.add(this.onGotoTitle);
            var _local1:int = ((this.view.isChallenger) ? Server.CHALLENGER_SERVER : Server.NORMAL_SERVER);
            this.servers.setAvailableServers(_local1);
            this.view.initialize(this.servers.getAvailableServers());
        }

        override public function destroy():void{
            this.view.gotoTitle.remove(this.onGotoTitle);
        }

        private function onGotoTitle():void{
            this.setScreen.dispatch(new CharacterSelectionAndNewsScreen());
        }


    }
}//package kabam.rotmg.ui.view

