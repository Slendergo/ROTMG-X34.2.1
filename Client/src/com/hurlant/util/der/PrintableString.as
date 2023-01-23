// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.util.der.PrintableString

package com.hurlant.util.der{
    import flash.utils.ByteArray;

    public class PrintableString implements IAsn1Type {

        protected var type:uint;
        protected var len:uint;
        protected var str:String;

        public function PrintableString(_arg1:uint, _arg2:uint){
            this.type = _arg1;
            this.len = _arg2;
        }

        public function getLength():uint{
            return (this.len);
        }

        public function getType():uint{
            return (this.type);
        }

        public function setString(_arg1:String):void{
            this.str = _arg1;
        }

        public function getString():String{
            return (this.str);
        }

        public function toString():String{
            return ((DER.indent + this.str));
        }

        public function toDER():ByteArray{
            return (null);
        }


    }
}//package com.hurlant.util.der

