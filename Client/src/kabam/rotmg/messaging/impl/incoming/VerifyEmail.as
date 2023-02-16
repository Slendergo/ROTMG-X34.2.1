// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.VerifyEmail

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class VerifyEmail extends IncomingMessage {

        public function VerifyEmail(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
        }

        override public function toString():String{
            return (formatToString("VERIFYEMAIL", "asdf", "asdf"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

