// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.data.TradeItem

package kabam.rotmg.messaging.impl.data{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class TradeItem {

        public var item_:int;
        public var slotType_:int;
        public var tradeable_:Boolean;
        public var included_:Boolean;


        public function parseFromInput(_arg1:Socket):void{
            this.item_ = _arg1.readInt();
            this.slotType_ = _arg1.readInt();
            this.tradeable_ = _arg1.readBoolean();
            this.included_ = _arg1.readBoolean();
        }

        public function toString():String{
            return (((((((("item: " + this.item_) + " slotType: ") + this.slotType_) + " tradeable: ") + this.tradeable_) + " included:") + this.included_));
        }


    }
}//package kabam.rotmg.messaging.impl.data

