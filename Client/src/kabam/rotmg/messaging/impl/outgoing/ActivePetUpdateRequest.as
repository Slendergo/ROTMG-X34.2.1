// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.ActivePetUpdateRequest

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class ActivePetUpdateRequest extends OutgoingMessage {

        public var commandtype:uint;
        public var instanceid:uint;

        public function ActivePetUpdateRequest(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeByte(this.commandtype);
            _arg1.writeInt(this.instanceid);
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

