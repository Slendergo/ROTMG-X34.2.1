// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.Create

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class Create extends OutgoingMessage {

        public var classType:int;
        public var skinType:int;

        public function Create(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeShort(this.classType);
            _arg1.writeShort(this.skinType);
        }

        override public function toString():String{
            return (formatToString("CREATE", "classType"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

