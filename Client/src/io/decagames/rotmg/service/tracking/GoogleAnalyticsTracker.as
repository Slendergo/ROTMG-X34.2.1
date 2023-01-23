// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.service.tracking.GoogleAnalyticsTracker

package io.decagames.rotmg.service.tracking{
    import robotlegs.bender.framework.api.ILogger;
    import flash.net.SharedObject;
    import flash.utils.ByteArray;
    import flash.crypto.generateRandomBytes;
    import flash.display.Loader;
    import flash.net.URLRequest;

    public class GoogleAnalyticsTracker {

        public static const VERSION:String = "1";

        private var _debug:Boolean = false;
        private var trackingURL:String = "https://www.google-analytics.com/collect";
        private var account:String;
        private var logger:ILogger;
        private var clientID:String;

        public function GoogleAnalyticsTracker(_arg1:String, _arg2:ILogger, _arg3:String, _arg4:Boolean=false){
            this.account = _arg1;
            this.logger = _arg2;
            this._debug = _arg4;
            if (_arg4){
                this.trackingURL = "http://www.google-analytics.com/debug/collect";
            };
            this.clientID = this.getClientID();
        }

        private function getClientID():String{
            var cid:String;
            var so:SharedObject = SharedObject.getLocal("_ga2");
            if (!so.data.clientid){
                this.logger.debug("CID not found, generate Client ID");
                cid = this._generateUUID();
                so.data.clientid = cid;
                try {
                    so.flush(0x0400);
                }
                catch(e:Error) {
                    logger.debug(("Could not write SharedObject to disk: " + e.message));
                };
            }
            else {
                this.logger.debug(("CID found, restore from SharedObject: " + so.data.clientid));
                cid = so.data.clientid;
            };
            return (cid);
        }

        private function _generateUUID():String{
            var i:uint;
            var b:uint;
            var randomBytes:ByteArray = generateRandomBytes(16);
            randomBytes[6] = (randomBytes[6] & 15);
            randomBytes[6] = (randomBytes[6] | 64);
            randomBytes[8] = (randomBytes[8] & 63);
            randomBytes[8] = (randomBytes[8] | 128);
            var toHex:Function = function (_arg1:uint):String{
                var _local2:String = _arg1.toString(16);
                _local2 = (((_local2.length)>1) ? _local2 : ("0" + _local2));
                return (_local2);
            };
            var str:String = "";
            var l:uint = randomBytes.length;
            randomBytes.position = 0;
            i = 0;
            while (i < l) {
                b = randomBytes[i];
                str = (str + toHex(b));
                i = (i + 1);
            };
            var uuid:String = "";
            uuid = (uuid + str.substr(0, 8));
            uuid = (uuid + "-");
            uuid = (uuid + str.substr(8, 4));
            uuid = (uuid + "-");
            uuid = (uuid + str.substr(12, 4));
            uuid = (uuid + "-");
            uuid = (uuid + str.substr(16, 4));
            uuid = (uuid + "-");
            uuid = (uuid + str.substr(20, 12));
            return (uuid);
        }

        public function trackEvent(_arg1:String, _arg2:String, _arg3:String="", _arg4:Number=NaN):void{
            this.triggerEvent((((((("&t=event" + "&ec=") + _arg1) + "&ea=") + _arg2) + (((_arg3)!="") ? ("&el=" + _arg3) : "")) + ((isNaN(_arg4)) ? "" : ("&ev=" + _arg4))));
        }

        public function trackPageView(_arg1:String):void{
            this.triggerEvent((("&t=pageview" + "&dp=") + _arg1));
        }

        private function prepareURL(_arg1:String):String{
            return ((((((((this.trackingURL + "?v=") + VERSION) + "&tid=") + this.account) + "&cid=") + this.clientID) + _arg1));
        }

        private function triggerEvent(_arg1:String):void{
            var urlLoader:Loader;
            var request:URLRequest;
            var url:String = _arg1;
            url = this.prepareURL(url);
            if (this._debug){
                this.logger.debug(("DEBUGGING GA:" + url));
                return;
            };
            try {
                urlLoader = new Loader();
                request = new URLRequest(url);
                urlLoader.load(request);
            }
            catch(e:Error) {
                logger.error(((((("Tracking Error:" + e.message) + ", ") + e.name) + ", ") + e.getStackTrace()));
            };
        }

        public function get debug():Boolean{
            return (this._debug);
        }


    }
}//package io.decagames.rotmg.service.tracking

