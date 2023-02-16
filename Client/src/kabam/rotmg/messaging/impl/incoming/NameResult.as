// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.NameResult

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class NameResult extends IncomingMessage {

        public var success_:Boolean;
        public var errorText_:String;

        public function NameResult(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.success_ = _arg1.readBoolean();
            this.errorText_ = _arg1.readUTF();
        }

        override public function toString():String{
            return (formatToString("NAMERESULT", "success_", "errorText_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

