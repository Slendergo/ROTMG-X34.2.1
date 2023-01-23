// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.messages.data.QuestData

package io.decagames.rotmg.dailyQuests.messages.data{
    import flash.utils.IDataInput;

    public class QuestData {

        public var id:String;
        public var name:String;
        public var description:String;
        public var expiration:String;
        public var requirements:Vector.<int>;
        public var rewards:Vector.<int>;
        public var completed:Boolean;
        public var itemOfChoice:Boolean;
        public var repeatable:Boolean;
        public var category:int;
        public var weight:int;

        public function QuestData(){
            this.requirements = new Vector.<int>();
            this.rewards = new Vector.<int>();
            super();
        }

        public function parseFromInput(_arg1:IDataInput):void{
            this.id = _arg1.readUTF();
            this.name = _arg1.readUTF();
            this.description = _arg1.readUTF();
            this.expiration = _arg1.readUTF();
            this.weight = _arg1.readInt();
            this.category = _arg1.readInt();
            var _local2:int = _arg1.readShort();
            var _local3:int;
            while (_local3 < _local2) {
                this.requirements.push(_arg1.readInt());
                _local3++;
            };
            _local2 = _arg1.readShort();
            _local3 = 0;
            while (_local3 < _local2) {
                this.rewards.push(_arg1.readInt());
                _local3++;
            };
            this.completed = _arg1.readBoolean();
            this.itemOfChoice = _arg1.readBoolean();
            this.repeatable = _arg1.readBoolean();
        }


    }
}//package io.decagames.rotmg.dailyQuests.messages.data

