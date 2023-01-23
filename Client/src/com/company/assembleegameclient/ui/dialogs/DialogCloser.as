// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.dialogs.DialogCloser

package com.company.assembleegameclient.ui.dialogs{
    import org.osflash.signals.Signal;
    import flash.events.*;

    public interface DialogCloser extends IEventDispatcher {

        function getCloseSignal():Signal;

    }
}//package com.company.assembleegameclient.ui.dialogs

