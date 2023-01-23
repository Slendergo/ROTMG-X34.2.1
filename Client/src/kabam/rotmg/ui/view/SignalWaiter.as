﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.ui.view.SignalWaiter

package kabam.rotmg.ui.view{
    import org.osflash.signals.Signal;
    import flash.utils.Dictionary;
    import com.adobe.utils.DictionaryUtil;

    public class SignalWaiter {

        public var complete:Signal;
        private var texts:Dictionary;

        public function SignalWaiter(){
            this.complete = new Signal();
            this.texts = new Dictionary();
            super();
        }

        public function push(_arg1:Signal):SignalWaiter{
            this.texts[_arg1] = true;
            this.listenTo(_arg1);
            return (this);
        }

        public function pushArgs(... _args):SignalWaiter{
            var _local2:Signal;
            for each (_local2 in _args) {
                this.push(_local2);
            };
            return (this);
        }

        private function listenTo(_arg1:Signal):void{
            var onTextChanged:Function;
            var value:Signal = _arg1;
            onTextChanged = function ():void{
                delete texts[value];
                checkEmpty();
            };
            value.addOnce(onTextChanged);
        }

        private function checkEmpty():void{
            if (this.isEmpty()){
                this.complete.dispatch();
            };
        }

        public function isEmpty():Boolean{
            return ((DictionaryUtil.getKeys(this.texts).length == 0));
        }


    }
}//package kabam.rotmg.ui.view

