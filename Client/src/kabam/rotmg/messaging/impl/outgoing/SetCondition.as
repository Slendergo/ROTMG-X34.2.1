// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.SetCondition

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.ByteArray;

    public class SetCondition extends OutgoingMessage {

        public var conditionEffect_:uint;
        public var conditionDuration_:Number;

        public function SetCondition(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:ByteArray):void{
            _arg1.writeByte(this.conditionEffect_);
            _arg1.writeFloat(this.conditionDuration_);
        }

        override public function toString():String{
            return (formatToString("SETCONDITION", "conditionEffect_", "conditionDuration_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

