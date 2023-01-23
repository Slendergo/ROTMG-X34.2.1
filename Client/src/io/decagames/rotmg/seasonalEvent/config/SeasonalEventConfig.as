// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.seasonalEvent.config.SeasonalEventConfig

package io.decagames.rotmg.seasonalEvent.config{
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import org.swiftsuspenders.Injector;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import io.decagames.rotmg.seasonalEvent.tasks.GetSeasonalEventTask;
    import robotlegs.bender.framework.api.*;

    public class SeasonalEventConfig implements IConfig {

        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var injector:Injector;


        public function configure():void{
            this.injector.map(SeasonalEventModel).asSingleton();
            this.injector.map(GetSeasonalEventTask);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.config

