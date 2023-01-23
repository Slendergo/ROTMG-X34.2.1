// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.PasswordPrompt

package kabam.rotmg.messaging.impl.incoming{
    import flash.utils.IDataInput;

    public class PasswordPrompt extends IncomingMessage {

        public var cleanPasswordStatus:int;

        public function PasswordPrompt(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:IDataInput):void{
            this.cleanPasswordStatus = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("PASSWORDPROMPT", "cleanPasswordStatus"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

