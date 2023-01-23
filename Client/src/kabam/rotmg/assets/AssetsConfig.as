// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.assets.AssetsConfig

package kabam.rotmg.assets{
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.startup.control.StartupSequence;
    import kabam.rotmg.assets.services.CharacterFactory;
    import kabam.rotmg.assets.services.IconFactory;
    import kabam.rotmg.assets.task.InitializeEffects;
    import robotlegs.bender.framework.api.*;

    public class AssetsConfig implements IConfig {

        [Inject]
        public var injector:Injector;
        [Inject]
        public var startupSequence:StartupSequence;


        public function configure():void{
            this.injector.map(CharacterFactory).asSingleton();
            this.injector.map(IconFactory).asSingleton();
            this.startupSequence.addTask(InitializeEffects);
        }


    }
}//package kabam.rotmg.assets

