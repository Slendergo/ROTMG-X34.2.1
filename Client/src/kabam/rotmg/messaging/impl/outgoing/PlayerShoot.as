// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.PlayerShoot

package kabam.rotmg.messaging.impl.outgoing{
    import kabam.rotmg.messaging.impl.data.WorldPosData;
    import flash.utils.IDataOutput;

    public class PlayerShoot extends OutgoingMessage {

        public var time_:int;
        public var bulletId_:uint;
        public var containerType_:int;
        public var startingPos_:WorldPosData;
        public var angle_:Number;
        public var speedMult_:Number;
        public var lifeMult_:Number;

        public function PlayerShoot(_arg1:uint, _arg2:Function){
            this.startingPos_ = new WorldPosData();
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:IDataOutput):void{
            _arg1.writeInt(this.time_);
            _arg1.writeByte(this.bulletId_);
            _arg1.writeShort(this.containerType_);
            this.startingPos_.writeToOutput(_arg1);
            _arg1.writeFloat(this.angle_);
            _arg1.writeShort(int((this.speedMult_ * 1000)));
            _arg1.writeShort(int((this.lifeMult_ * 1000)));
        }

        override public function toString():String{
            return (formatToString("PLAYERSHOOT", "time_", "bulletId_", "containerType_", "startingPos_", "angle_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

