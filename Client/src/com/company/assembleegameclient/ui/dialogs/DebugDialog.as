﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.dialogs.DebugDialog

package com.company.assembleegameclient.ui.dialogs{
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import flash.events.Event;

    public class DebugDialog extends StaticDialog {

        private var f:Function;

        public function DebugDialog(_arg1:String, _arg2:String="Debug", _arg3:Function=null){
            super(_arg2, _arg1, "OK", null, null);
            this.f = _arg3;
            addEventListener(Dialog.LEFT_BUTTON, this.onDialogComplete);
        }

        private function onDialogComplete(_arg1:Event):void{
            var _local2:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
            _local2.dispatch();
            if (((!((this.parent == null))) && (this.parent.contains(this)))){
                this.parent.removeChild(this);
            };
            if (this.f != null){
                this.f();
            };
        }


    }
}//package com.company.assembleegameclient.ui.dialogs

