// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.MapInfo

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class MapInfo extends IncomingMessage {

        public var width_:int;
        public var height_:int;
        public var name_:String;
        public var displayName_:String;
        public var difficulty_:int;
        public var fp_:uint;
        public var background_:int;
        public var allowPlayerTeleport_:Boolean;
        public var showDisplays_:Boolean;
        public var maxPlayers_:int;
        public var connectionGuid_:String;
        public var gameOpenedTime_:int;

        public function MapInfo(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.width_ = _arg1.readInt();
            this.height_ = _arg1.readInt();
            this.name_ = _arg1.readUTF();
            this.displayName_ = _arg1.readUTF();
            this.fp_ = _arg1.readUnsignedInt();
            this.background_ = _arg1.readInt();
            this.difficulty_ = _arg1.readInt();
            this.allowPlayerTeleport_ = _arg1.readBoolean();
            this.showDisplays_ = _arg1.readBoolean();
            this.maxPlayers_ = _arg1.readShort();
            this.connectionGuid_ = _arg1.readUTF();
            this.gameOpenedTime_ = _arg1.readUnsignedInt();
        }

        override public function toString():String{
            return (formatToString("MAPINFO", "width_", "height_", "name_", "fp_", "background_", "allowPlayerTeleport_", "showDisplays_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

