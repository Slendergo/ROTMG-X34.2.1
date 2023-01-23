// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.ui.PlayerGroupMenuMediator

package kabam.rotmg.ui{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
    import kabam.rotmg.core.StaticInjectorContext;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.game.signals.AddTextLineSignal;
    import kabam.rotmg.chat.model.ChatMessage;
    import com.company.assembleegameclient.parameters.Parameters;

    public class PlayerGroupMenuMediator extends Mediator {

        [Inject]
        public var view:PlayerGroupMenu;


        override public function initialize():void{
            this.view.unableToTeleport.add(this.onUnableToTeleport);
        }

        override public function destroy():void{
            this.view.unableToTeleport.remove(this.onUnableToTeleport);
        }

        private function onUnableToTeleport():void{
            var _local1:Injector = StaticInjectorContext.getInjector();
            var _local2:AddTextLineSignal = _local1.getInstance(AddTextLineSignal);
            _local2.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, "No players are eligible for teleporting."));
        }


    }
}//package kabam.rotmg.ui

