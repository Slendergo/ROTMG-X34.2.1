﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.appengine.RemoteTexture

package com.company.assembleegameclient.appengine{
    import robotlegs.bender.framework.api.ILogger;
    import kabam.rotmg.core.StaticInjectorContext;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.appengine.impl.AppEngineRetryLoader;
    import kabam.rotmg.appengine.api.RetryLoader;
    import flash.net.URLLoaderDataFormat;
    import ion.utils.png.PNGDecoder;
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    public class RemoteTexture {

        private static const URL_PATTERN:String = "https://{DOMAIN}/picture/get";
        private static const ERROR_PATTERN:String = "Remote Texture Error: {ERROR} (id:{ID}, instance:{INSTANCE})";
        private static const START_TIME:int = int(new Date().getTime());

        public var id_:String;
        public var instance_:String;
        public var callback_:Function;
        private var logger:ILogger;

        public function RemoteTexture(_arg1:String, _arg2:String, _arg3:Function):void{
            this.id_ = _arg1;
            this.instance_ = _arg2;
            this.callback_ = _arg3;
            var _local4:Injector = StaticInjectorContext.getInjector();
            this.logger = _local4.getInstance(ILogger);
        }

        public function run():void{
            var _local1:String = (((this.instance_)=="testing") ? "test.realmofthemadgod.com" : "realmofthemadgod.com");
            var _local2:String = URL_PATTERN.replace("{DOMAIN}", _local1);
            var _local3:Object = {};
            _local3.id = this.id_;
            _local3.time = START_TIME;
            var _local4:RetryLoader = new AppEngineRetryLoader();
            _local4.setDataFormat(URLLoaderDataFormat.BINARY);
            _local4.complete.addOnce(this.onComplete);
            _local4.sendRequest(_local2, _local3);
        }

        private function onComplete(_arg1:Boolean, _arg2):void{
            if (_arg1){
                this.makeTexture(_arg2);
            }
            else {
                this.reportError(_arg2);
            };
        }

        public function makeTexture(_arg1:ByteArray):void{
            var _local2:BitmapData = PNGDecoder.decodeImage(_arg1);
            this.callback_(_local2);
        }

        public function reportError(_arg1:String):void{
            _arg1 = ERROR_PATTERN.replace("{ERROR}", _arg1).replace("{ID}", this.id_).replace("{INSTANCE}", this.instance_);
            this.logger.warn("RemoteTexture.reportError: {0}", [_arg1]);
            var _local2:BitmapData = new BitmapDataSpy(1, 1);
            this.callback_(_local2);
        }


    }
}//package com.company.assembleegameclient.appengine

