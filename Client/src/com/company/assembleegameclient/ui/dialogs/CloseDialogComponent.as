// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.dialogs.CloseDialogComponent

package com.company.assembleegameclient.ui.dialogs{
    import org.osflash.signals.Signal;
    import flash.events.Event;

    public class CloseDialogComponent {

        private const closeSignal:Signal = new Signal();

        private var dialog:DialogCloser;
        private var types:Vector.<String>;

        public function CloseDialogComponent(){
            this.types = new Vector.<String>();
            super();
        }

        public function add(_arg1:DialogCloser, _arg2:String):void{
            this.dialog = _arg1;
            this.types.push(_arg2);
            _arg1.addEventListener(_arg2, this.onButtonType);
        }

        private function onButtonType(_arg1:Event):void{
            var _local2:String;
            for each (_local2 in this.types) {
                this.dialog.removeEventListener(_local2, this.onButtonType);
            };
            this.dialog.getCloseSignal().dispatch();
        }

        public function getCloseSignal():Signal{
            return (this.closeSignal);
        }


    }
}//package com.company.assembleegameclient.ui.dialogs

