// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.application.EnvironmentConfig

package kabam.rotmg.application{
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.application.model.DomainModel;
    import robotlegs.bender.framework.api.*;

    public class EnvironmentConfig implements IConfig {

        [Inject]
        public var injector:Injector;

        public function configure():void{
            this.injector.map(DomainModel).asSingleton();
        }
    }
}//package kabam.rotmg.application

