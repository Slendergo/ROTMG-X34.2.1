// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.dailyLogin.message.ClaimDailyRewardResponse

package kabam.rotmg.dailyLogin.message{
import flash.net.Socket;
import flash.utils.ByteArray;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import flash.utils.ByteArray;

    public class ClaimDailyRewardResponse extends IncomingMessage {

        public var itemId:int;
        public var quantity:int;
        public var gold:int;

        public function ClaimDailyRewardResponse(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.itemId = _arg1.readInt();
            this.quantity = _arg1.readInt();
            this.gold = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("CLAIMDAILYREWARDRESPONSE", "itemId", "quantity", "gold"));
        }


    }
}//package kabam.rotmg.dailyLogin.message

