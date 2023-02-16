// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.GroundDamage

package kabam.rotmg.messaging.impl.outgoing{
    import kabam.rotmg.messaging.impl.data.WorldPosData;
    import flash.utils.ByteArray;

    public class GroundDamage extends OutgoingMessage {

        public var time_:int;
        public var position_:WorldPosData;

        public function GroundDamage(_arg1:uint, _arg2:Function){
            this.position_ = new WorldPosData();
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeInt(this.time_);
            this.position_.writeToOutput(_arg1);
        }

        override public function toString():String{
            return (formatToString("GROUNDDAMAGE", "time_", "position_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

