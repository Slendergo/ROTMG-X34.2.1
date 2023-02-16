// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.KeyInfoResponse

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class KeyInfoResponse extends IncomingMessage {

        public var name:String;
        public var description:String;
        public var creator:String;

        public function KeyInfoResponse(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.name = _arg1.readUTF();
            this.description = _arg1.readUTF();
            this.creator = _arg1.readUTF();
        }

        override public function toString():String{
            return (formatToString("KEYINFORESPONSE", "name", "description", "creator"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

