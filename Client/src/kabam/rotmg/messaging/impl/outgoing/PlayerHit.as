// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.PlayerHit

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class PlayerHit extends OutgoingMessage {

        public var bulletId_:uint;
        public var objectId_:int;

        public function PlayerHit(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeByte(this.bulletId_);
            _arg1.writeInt(this.objectId_);
        }

        override public function toString():String{
            return (formatToString("PLAYERHIT", "bulletId_", "objectId_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

