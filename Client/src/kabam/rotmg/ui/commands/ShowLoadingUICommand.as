﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.ui.commands.ShowLoadingUICommand

package kabam.rotmg.ui.commands{
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.application.model.DomainModel;
    import robotlegs.bender.framework.api.ILogger;
    import com.company.assembleegameclient.screens.AccountLoadingScreen;
    import kabam.rotmg.core.view.BadDomainView;

    public class ShowLoadingUICommand {

        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var domain:DomainModel;
        [Inject]
        public var logger:ILogger;


        public function execute():void{
            if (this.domain.isLocalDomainValid()){
                this.showLoadingScreen();
            }
            else {
                this.openBadDomainView();
            }
        }

        private function showLoadingScreen():void{
            this.setScreen.dispatch(new AccountLoadingScreen());
        }

        private function openBadDomainView():void{
            this.logger.debug("bad domain, deny");
            this.setScreen.dispatch(new BadDomainView());
        }


    }
}//package kabam.rotmg.ui.commands

