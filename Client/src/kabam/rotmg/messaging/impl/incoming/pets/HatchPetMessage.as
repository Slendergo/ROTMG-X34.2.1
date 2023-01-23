// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.pets.HatchPetMessage

package kabam.rotmg.messaging.impl.incoming.pets{
    import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import flash.utils.IDataInput;

    public class HatchPetMessage extends IncomingMessage {

        public var petName:String;
        public var petSkin:int;
        public var itemType:int;

        public function HatchPetMessage(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:IDataInput):void{
            this.petName = _arg1.readUTF();
            this.petSkin = _arg1.readInt();
            this.itemType = _arg1.readInt();
        }


    }
}//package kabam.rotmg.messaging.impl.incoming.pets

