﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.QuestObjId

package kabam.rotmg.messaging.impl.incoming{
    import flash.utils.IDataInput;

    public class QuestObjId extends IncomingMessage {

        public var objectId_:int;

        public function QuestObjId(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:IDataInput):void{
            this.objectId_ = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("QUESTOBJID", "objectId_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

