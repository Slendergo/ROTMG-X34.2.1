﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.friends.view.FriendUpdateConfirmDialog

package kabam.rotmg.friends.view{
    import com.company.assembleegameclient.ui.dialogs.Dialog;
    import com.company.assembleegameclient.ui.dialogs.CloseDialogComponent;
    import io.decagames.rotmg.social.model.FriendRequestVO;
    import kabam.rotmg.core.StaticInjectorContext;
    import org.swiftsuspenders.Injector;
    import io.decagames.rotmg.social.signals.FriendActionSignal;
    import flash.events.Event;
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.ui.dialogs.*;

    public class FriendUpdateConfirmDialog extends Dialog implements DialogCloser {

        private const closeDialogComponent:CloseDialogComponent = new CloseDialogComponent();

        private var _friendRequestVO:FriendRequestVO;

        public function FriendUpdateConfirmDialog(_arg1:String, _arg2:String, _arg3:String, _arg4:String, _arg5:FriendRequestVO, _arg6:Object=null){
            super(_arg1, _arg2, _arg3, _arg4, _arg6);
            this._friendRequestVO = _arg5;
            this.closeDialogComponent.add(this, Dialog.RIGHT_BUTTON);
            this.closeDialogComponent.add(this, Dialog.LEFT_BUTTON);
            addEventListener(Dialog.RIGHT_BUTTON, this.onRightButton);
        }

        private function onRightButton(_arg1:Event):void{
            removeEventListener(Dialog.RIGHT_BUTTON, this.onRightButton);
            var _local2:Injector = StaticInjectorContext.getInjector();
            var _local3:FriendActionSignal = _local2.getInstance(FriendActionSignal);
            _local3.dispatch(this._friendRequestVO);
        }

        public function getCloseSignal():Signal{
            return (this.closeDialogComponent.getCloseSignal());
        }


    }
}//package kabam.rotmg.friends.view

