// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.UsePortal

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class UsePortal extends OutgoingMessage {

        public var objectId_:int;

        public function UsePortal(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeInt(this.objectId_);
        }

        override public function toString():String{
            return (formatToString("USEPORTAL", "objectId_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

