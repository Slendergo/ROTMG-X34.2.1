// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.KeyInfoRequest

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class KeyInfoRequest extends OutgoingMessage {

        public var itemType_:int;

        public function KeyInfoRequest(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeInt(this.itemType_);
        }

        override public function toString():String{
            return (formatToString("ITEMTYPE", "itemType_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

