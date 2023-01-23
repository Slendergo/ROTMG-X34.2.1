﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.NewTick

package kabam.rotmg.messaging.impl.incoming{
    import kabam.rotmg.messaging.impl.data.ObjectStatusData;
    import com.company.assembleegameclient.util.FreeList;
    import flash.utils.IDataInput;

    public class NewTick extends IncomingMessage {

        public var tickId_:int;
        public var tickTime_:int;
        public var serverRealTimeMS_:uint;
        public var serverLastRTTMS_:uint;
        public var statuses_:Vector.<ObjectStatusData>;

        public function NewTick(_arg1:uint, _arg2:Function){
            this.statuses_ = new Vector.<ObjectStatusData>();
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:IDataInput):void{
            var _local3:int;
            this.tickId_ = _arg1.readInt();
            this.tickTime_ = _arg1.readInt();
            this.serverRealTimeMS_ = _arg1.readUnsignedInt();
            this.serverLastRTTMS_ = _arg1.readUnsignedShort();
            var _local2:int = _arg1.readShort();
            _local3 = _local2;
            while (_local3 < this.statuses_.length) {
                FreeList.deleteObject(this.statuses_[_local3]);
                _local3++;
            };
            this.statuses_.length = Math.min(_local2, this.statuses_.length);
            while (this.statuses_.length < _local2) {
                this.statuses_.push((FreeList.newObject(ObjectStatusData) as ObjectStatusData));
            };
            _local3 = 0;
            while (_local3 < _local2) {
                this.statuses_[_local3].parseFromInput(_arg1);
                _local3++;
            };
        }

        override public function toString():String{
            return (formatToString("NEW_TICK", "tickId_", "tickTime_", "statuses_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

