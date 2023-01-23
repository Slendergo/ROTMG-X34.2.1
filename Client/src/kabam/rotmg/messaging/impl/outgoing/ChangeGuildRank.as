// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.ChangeGuildRank

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.IDataOutput;

    public class ChangeGuildRank extends OutgoingMessage {

        public var name_:String;
        public var guildRank_:int;

        public function ChangeGuildRank(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:IDataOutput):void{
            _arg1.writeUTF(this.name_);
            _arg1.writeInt(this.guildRank_);
        }

        override public function toString():String{
            return (formatToString("CHANGEGUILDRANK", "name_", "guildRank_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

