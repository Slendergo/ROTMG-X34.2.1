// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.chat.model.ChatMessage

package kabam.rotmg.chat.model{
    public class ChatMessage {

        public var name:String;
        public var text:String;
        public var objectId:int = -1;
        public var numStars:int = -1;
        public var recipient:String = "";
        public var isToMe:Boolean;
        public var isWhisper:Boolean;
        public var isFromSupporter:Boolean;
        public var tokens:Object;
        public var starBg:int;


        public static function make(_arg1:String, _arg2:String, _arg3:int=-1, _arg4:int=-1, _arg5:String="", _arg6:Boolean=false, _arg7:Object=null, _arg8:Boolean=false, _arg9:Boolean=false, _arg10:int=0):ChatMessage{
            var _local11:ChatMessage = new (ChatMessage)();
            _local11.name = _arg1;
            _local11.text = _arg2;
            _local11.objectId = _arg3;
            _local11.numStars = _arg4;
            _local11.recipient = _arg5;
            _local11.isToMe = _arg6;
            _local11.isWhisper = _arg8;
            _local11.isFromSupporter = _arg9;
            _local11.tokens = (((_arg7 == null)) ? {} : _arg7);
            _local11.starBg = _arg10;
            return (_local11);
        }


    }
}//package kabam.rotmg.chat.model

