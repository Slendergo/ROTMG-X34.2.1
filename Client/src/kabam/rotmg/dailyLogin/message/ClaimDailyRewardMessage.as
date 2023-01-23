// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.dailyLogin.message.ClaimDailyRewardMessage

package kabam.rotmg.dailyLogin.message{
    import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;
    import flash.utils.IDataOutput;

    public class ClaimDailyRewardMessage extends OutgoingMessage {

        public var claimKey:String;
        public var type:String;

        public function ClaimDailyRewardMessage(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:IDataOutput):void{
            _arg1.writeUTF(this.claimKey);
            _arg1.writeUTF(this.type);
        }

        override public function toString():String{
            return ("type");
        }


    }
}//package kabam.rotmg.dailyLogin.message

