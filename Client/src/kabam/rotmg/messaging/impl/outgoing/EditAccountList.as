// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.EditAccountList

package kabam.rotmg.messaging.impl.outgoing{
    import flash.utils.IDataOutput;

    public class EditAccountList extends OutgoingMessage {

        public var accountListId_:int;
        public var add_:Boolean;
        public var objectId_:int;

        public function EditAccountList(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:IDataOutput):void{
            _arg1.writeInt(this.accountListId_);
            _arg1.writeBoolean(this.add_);
            _arg1.writeInt(this.objectId_);
        }

        override public function toString():String{
            return (formatToString("EDITACCOUNTLIST", "accountListId_", "add_", "objectId_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

