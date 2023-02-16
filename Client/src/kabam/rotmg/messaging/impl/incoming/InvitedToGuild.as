// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.InvitedToGuild

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class InvitedToGuild extends IncomingMessage {

        public var name_:String;
        public var guildName_:String;

        public function InvitedToGuild(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.name_ = _arg1.readUTF();
            this.guildName_ = _arg1.readUTF();
        }

        override public function toString():String{
            return (formatToString("INVITEDTOGUILD", "name_", "guildName_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

