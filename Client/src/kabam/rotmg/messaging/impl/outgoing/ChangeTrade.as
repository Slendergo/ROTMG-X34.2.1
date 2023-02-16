// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.ChangeTrade

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class ChangeTrade extends OutgoingMessage {

        public var offer_:Vector.<Boolean>;

        public function ChangeTrade(_arg1:uint, _arg2:Function){
            this.offer_ = new Vector.<Boolean>();
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeShort(this.offer_.length);
            var _local2:int;
            while (_local2 < this.offer_.length) {
                _arg1.writeBoolean(this.offer_[_local2]);
                _local2++;
            }
        }

        override public function toString():String{
            return (formatToString("CHANGETRADE", "offer_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

