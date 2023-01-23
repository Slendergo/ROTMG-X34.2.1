// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.build.BuildConfig

package kabam.rotmg.build{
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.build.impl.BuildEnvironments;
    import kabam.rotmg.build.api.BuildData;
    import kabam.rotmg.build.impl.CompileTimeBuildData;
    import robotlegs.bender.framework.api.*;

    public class BuildConfig implements IConfig {

        [Inject]
        public var injector:Injector;


        public function configure():void{
            this.injector.map(BuildEnvironments).asSingleton();
            this.injector.map(BuildData).toSingleton(CompileTimeBuildData);
        }


    }
}//package kabam.rotmg.build

