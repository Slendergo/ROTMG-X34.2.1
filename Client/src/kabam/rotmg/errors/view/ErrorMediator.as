﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.errors.view.ErrorMediator

package kabam.rotmg.errors.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import flash.display.DisplayObjectContainer;
    import kabam.rotmg.errors.control.ErrorSignal;
    import robotlegs.bender.framework.api.ILogger;
    import flash.display.LoaderInfo;
    import flash.events.IEventDispatcher;
    import flash.events.ErrorEvent;

    public class ErrorMediator extends Mediator {

        private const UNCAUGHT_ERROR_EVENTS:String = "uncaughtErrorEvents";
        private const UNCAUGHT_ERROR:String = "uncaughtError";

        [Inject]
        public var contextView:DisplayObjectContainer;
        [Inject]
        public var error:ErrorSignal;
        [Inject]
        public var logger:ILogger;
        private var loaderInfo:LoaderInfo;


        override public function initialize():void{
            this.loaderInfo = this.contextView.loaderInfo;
            if (this.canCatchGlobalErrors()){
                this.addGlobalErrorListener();
            };
        }

        override public function destroy():void{
            if (this.canCatchGlobalErrors()){
                this.removeGlobalErrorListener();
            };
        }

        private function canCatchGlobalErrors():Boolean{
            return (this.loaderInfo.hasOwnProperty(this.UNCAUGHT_ERROR_EVENTS));
        }

        private function addGlobalErrorListener():void{
            var _local1:IEventDispatcher = IEventDispatcher(this.loaderInfo[this.UNCAUGHT_ERROR_EVENTS]);
            _local1.addEventListener(this.UNCAUGHT_ERROR, this.handleUncaughtError);
        }

        private function removeGlobalErrorListener():void{
            var _local1:IEventDispatcher = IEventDispatcher(this.loaderInfo[this.UNCAUGHT_ERROR_EVENTS]);
            _local1.removeEventListener(this.UNCAUGHT_ERROR, this.handleUncaughtError);
        }

        private function handleUncaughtError(_arg1:ErrorEvent):void{
            this.error.dispatch(_arg1);
        }


    }
}//package kabam.rotmg.errors.view

