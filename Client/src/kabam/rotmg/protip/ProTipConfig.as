// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.protip.ProTipConfig

package kabam.rotmg.protip{
    import org.swiftsuspenders.Injector;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
    import kabam.rotmg.protip.view.ProTipView;
    import kabam.rotmg.protip.model.IProTipModel;
    import kabam.rotmg.protip.model.EmbeddedProTipModel;
    import kabam.rotmg.protip.signals.ShowProTipSignal;
    import kabam.rotmg.protip.commands.ShowProTipCommand;
    import robotlegs.bender.framework.api.*;

    public class ProTipConfig implements IConfig {

        [Inject]
        public var injector:Injector;
        [Inject]
        public var commandMap:ISignalCommandMap;


        public function configure():void{
            this.injector.map(ProTipView).asSingleton();
            this.injector.map(IProTipModel).toSingleton(EmbeddedProTipModel);
            this.commandMap.map(ShowProTipSignal).toCommand(ShowProTipCommand);
        }


    }
}//package kabam.rotmg.protip

