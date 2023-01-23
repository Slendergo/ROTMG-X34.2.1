// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.core.service.GoogleAnalytics

package kabam.rotmg.core.service{
    import io.decagames.rotmg.service.tracking.GoogleAnalyticsTracker;
    import robotlegs.bender.framework.api.ILogger;
    import flash.system.Capabilities;

    public class GoogleAnalytics {

        private var tracker:GoogleAnalyticsTracker;
        [Inject]
        public var logger:ILogger;


        public function init(_arg1:String, _arg2:String):void{
            this.logger.debug(((("GA setup: " + _arg1) + ", type:") + Capabilities.playerType));
            this.tracker = new GoogleAnalyticsTracker(_arg1, this.logger, _arg2);
        }

        public function trackEvent(_arg1:String, _arg2:String, _arg3:String="", _arg4:Number=NaN):void{
            this.tracker.trackEvent(_arg1, _arg2, _arg3, _arg4);
            this.logger.debug(((((((("Track event - category: " + _arg1) + ", action:") + _arg2) + ", label: ") + _arg3) + ", value:") + _arg4));
        }

        public function trackPageView(_arg1:String):void{
        }


    }
}//package kabam.rotmg.core.service

