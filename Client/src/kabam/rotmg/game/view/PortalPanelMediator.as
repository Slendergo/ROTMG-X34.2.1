// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.view.PortalPanelMediator

package kabam.rotmg.game.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.ui.panels.PortalPanel;
    import kabam.rotmg.game.signals.ExitGameSignal;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import flash.events.MouseEvent;

    public class PortalPanelMediator extends Mediator {

        [Inject]
        public var view:PortalPanel;
        [Inject]
        public var exitGameSignal:ExitGameSignal;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipsSignal:HideTooltipsSignal;

        override public function initialize():void{
            this.view.exitGameSignal.add(this.onExitGame);
            this.view.enterButton_.addEventListener(MouseEvent.CLICK, this.view.onEnterSpriteClick);
        }

        private function onExitGame():void{
            this.exitGameSignal.dispatch();
        }

        override public function destroy():void{
            this.view.exitGameSignal.remove(this.onExitGame);
        }
    }
}//package kabam.rotmg.game.view

