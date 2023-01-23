// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.messages.incoming.QuestFetchResponse

package io.decagames.rotmg.dailyQuests.messages.incoming{
    import kabam.rotmg.messaging.impl.incoming.IncomingMessage;
    import io.decagames.rotmg.dailyQuests.messages.data.QuestData;
    import flash.utils.IDataInput;

    public class QuestFetchResponse extends IncomingMessage {

        public var quests:Vector.<QuestData>;
        public var nextRefreshPrice:int;

        public function QuestFetchResponse(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
            this.nextRefreshPrice = -1;
        }

        override public function parseFromInput(_arg1:IDataInput):void{
            this.quests = new Vector.<QuestData>();
            var _local2:int = _arg1.readShort();
            var _local3:int;
            while (_local3 < _local2) {
                this.quests[_local3] = new QuestData();
                this.quests[_local3].parseFromInput(_arg1);
                _local3++;
            };
            this.nextRefreshPrice = _arg1.readShort();
        }

        override public function toString():String{
            return (formatToString("QUESTFETCHRESPONSE"));
        }


    }
}//package io.decagames.rotmg.dailyQuests.messages.incoming

