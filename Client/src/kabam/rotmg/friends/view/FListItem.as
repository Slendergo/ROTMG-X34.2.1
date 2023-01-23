// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.friends.view.FListItem

package kabam.rotmg.friends.view{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import io.decagames.rotmg.social.model.FriendVO;

    public class FListItem extends Sprite {

        public var actionSignal:Signal;

        public function FListItem(){
            this.actionSignal = new Signal(String, String);
            super();
        }

        protected function init(_arg1:Number, _arg2:Number):void{
        }

        public function update(_arg1:FriendVO, _arg2:String):void{
        }

        public function destroy():void{
        }


    }
}//package kabam.rotmg.friends.view

