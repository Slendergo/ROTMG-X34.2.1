﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.appengine.impl.TrackingAppEngineClient

package kabam.rotmg.appengine.impl{
    import kabam.rotmg.core.signals.TrackEventSignal;
    import org.osflash.signals.OnceSignal;
    import flash.utils.getTimer;
    import kabam.rotmg.core.service.TrackingData;
    import kabam.rotmg.appengine.api.*;

    public class TrackingAppEngineClient implements AppEngineClient {

        [Inject]
        public var track:TrackEventSignal;
        [Inject]
        public var wrapped:SimpleAppEngineClient;
        private var target:String;
        private var time:int;


        public function get complete():OnceSignal{
            return (this.wrapped.complete);
        }

        public function setDataFormat(_arg1:String):void{
            this.wrapped.setDataFormat(_arg1);
        }

        public function setSendEncrypted(_arg1:Boolean):void{
            this.wrapped.setSendEncrypted(_arg1);
        }

        public function setMaxRetries(_arg1:int):void{
            this.wrapped.setMaxRetries(_arg1);
        }

        public function sendRequest(_arg1:String, _arg2:Object):void{
            this.target = _arg1;
            this.time = getTimer();
            this.wrapped.complete.addOnce(this.trackResponse);
            this.wrapped.sendRequest(_arg1, _arg2);
        }

        private function trackResponse(_arg1:Boolean, _arg2):void{
            var _local3:TrackingData = new TrackingData();
            _local3.category = "AppEngineResponseTime";
            _local3.action = this.target;
            _local3.value = (getTimer() - this.time);
        }

        public function requestInProgress():Boolean{
            return (false);
        }


    }
}//package kabam.rotmg.appengine.impl

