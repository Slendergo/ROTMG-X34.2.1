// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.console.model.Watch

package kabam.lib.console.model{
    public class Watch {

        public var name:String;
        public var data:String;

        public function Watch(_arg1:String, _arg2:String=""){
            this.name = _arg1;
            this.data = _arg2;
        }

        public function toString():String{
            return (this.data);
        }


    }
}//package kabam.lib.console.model

