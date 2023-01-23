// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.Text

package kabam.rotmg.messaging.impl.incoming{
    import flash.utils.IDataInput;

    public class Text extends IncomingMessage {

        public var name_:String;
        public var objectId_:int;
        public var numStars_:int;
        public var bubbleTime_:uint;
        public var recipient_:String;
        public var text_:String;
        public var cleanText_:String;
        public var isSupporter:Boolean = false;
        public var starBg:int;

        public function Text(_arg1:uint, _arg2:Function){
            this.name_ = new String();
            this.text_ = new String();
            this.cleanText_ = new String();
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:IDataInput):void{
            this.name_ = _arg1.readUTF();
            this.objectId_ = _arg1.readInt();
            this.numStars_ = _arg1.readInt();
            this.bubbleTime_ = _arg1.readUnsignedByte();
            this.recipient_ = _arg1.readUTF();
            this.text_ = _arg1.readUTF();
            this.cleanText_ = _arg1.readUTF();
            this.isSupporter = _arg1.readBoolean();
            this.starBg = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("TEXT", "name_", "objectId_", "numStars_", "bubbleTime_", "recipient_", "text_", "cleanText_", "isSupporter", "starBg"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

