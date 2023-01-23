// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.ShootAck

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.IDataOutput;

    public class ShootAck extends OutgoingMessage {

        public var time_:int;

        public function ShootAck(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:IDataOutput):void{
            _arg1.writeInt(this.time_);
        }

        override public function toString():String{
            return (formatToString("SHOOTACK", "time_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

