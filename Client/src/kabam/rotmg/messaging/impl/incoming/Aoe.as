// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.Aoe

package kabam.rotmg.messaging.impl.incoming{
    import kabam.rotmg.messaging.impl.data.WorldPosData;
    import flash.utils.IDataInput;

    public class Aoe extends IncomingMessage {

        public var pos_:WorldPosData;
        public var radius_:Number;
        public var damage_:int;
        public var effect_:int;
        public var duration_:Number;
        public var origType_:int;
        public var color_:int;
        public var armorPierce_:Boolean;

        public function Aoe(_arg1:uint, _arg2:Function){
            this.pos_ = new WorldPosData();
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:IDataInput):void{
            this.pos_.parseFromInput(_arg1);
            this.radius_ = _arg1.readFloat();
            this.damage_ = _arg1.readUnsignedShort();
            this.effect_ = _arg1.readUnsignedByte();
            this.duration_ = _arg1.readFloat();
            this.origType_ = _arg1.readUnsignedShort();
            this.color_ = _arg1.readInt();
            this.armorPierce_ = _arg1.readBoolean();
        }

        override public function toString():String{
            return (formatToString("AOE", "pos_", "radius_", "damage_", "effect_", "duration_", "origType_", "color_", "armorPierce_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

