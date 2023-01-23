﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.AllyShoot

package kabam.rotmg.messaging.impl.incoming{
    import flash.utils.IDataInput;

    public class AllyShoot extends IncomingMessage {

        public var bulletId_:uint;
        public var ownerId_:int;
        public var containerType_:int;
        public var angle_:Number;
        public var bard_:Boolean;

        public function AllyShoot(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:IDataInput):void{
            this.bulletId_ = _arg1.readUnsignedByte();
            this.ownerId_ = _arg1.readInt();
            this.containerType_ = _arg1.readShort();
            this.angle_ = _arg1.readFloat();
            this.bard_ = _arg1.readBoolean();
        }

        override public function toString():String{
            return (formatToString("ALLYSHOOT", "bulletId_", "ownerId_", "containerType_", "angle_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

