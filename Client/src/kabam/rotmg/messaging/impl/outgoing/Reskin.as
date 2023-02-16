// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.Reskin

package kabam.rotmg.messaging.impl.outgoing{
    import com.company.assembleegameclient.objects.Player;
    import flash.utils.ByteArray;

    public class Reskin extends OutgoingMessage {

        public var skinID:int;
        public var player:Player;

        public function Reskin(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeInt(this.skinID);
        }

        override public function consume():void{
            super.consume();
            this.player = null;
        }

        override public function toString():String{
            return (formatToString("RESKIN", "skinID"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

