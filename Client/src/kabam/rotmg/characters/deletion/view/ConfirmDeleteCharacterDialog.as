// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.characters.deletion.view.ConfirmDeleteCharacterDialog

package kabam.rotmg.characters.deletion.view{
    import flash.display.Sprite;
    import com.company.assembleegameclient.ui.dialogs.Dialog;
    import org.osflash.signals.Signal;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.text.model.TextKey;
    import flash.events.Event;

    public class ConfirmDeleteCharacterDialog extends Sprite {

        private const CANCEL_EVENT:String = Dialog.LEFT_BUTTON;
        private const DELETE_EVENT:String = Dialog.RIGHT_BUTTON;

        public var deleteCharacter:Signal;
        public var cancel:Signal;

        public function ConfirmDeleteCharacterDialog(){
            this.deleteCharacter = new Signal();
            this.cancel = new Signal();
        }

        public function setText(_arg1:String, _arg2:String):void{
            var _local5:Dialog = new Dialog(TextKey.CONFIRMDELETE_VERIFYDELETION, "", TextKey.CONFIRMDELETE_CANCEL, TextKey.CONFIRMDELETE_DELETE, "/deleteDialog");
            _local5.setTextParams(TextKey.CONFIRMDELETECHARACTERDIALOG, {
                name:_arg1,
                displayID:_arg2
            });
            _local5.addEventListener(this.CANCEL_EVENT, this.onCancel);
            _local5.addEventListener(this.DELETE_EVENT, this.onDelete);
            addChild(_local5);
        }

        private function onCancel(_arg1:Event):void{
            this.cancel.dispatch();
        }

        private function onDelete(_arg1:Event):void{
            this.deleteCharacter.dispatch();
        }


    }
}//package kabam.rotmg.characters.deletion.view

