// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.ChangePetSkin

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class ChangePetSkin extends OutgoingMessage {

        public var petId:int;
        public var skinType:int;
        public var currency:int;

        public function ChangePetSkin(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeInt(this.petId);
            _arg1.writeInt(this.skinType);
            _arg1.writeInt(this.currency);
        }

        override public function toString():String{
            return (formatToString("PET_CHANGE_SKIN_MSG", "petId", "skinType"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

