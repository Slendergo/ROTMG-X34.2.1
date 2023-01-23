// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.util.der.Set

package com.hurlant.util.der{
    public dynamic class Set extends Sequence implements IAsn1Type {

        public function Set(_arg1:uint=49, _arg2:uint=0){
            super(_arg1, _arg2);
        }

        override public function toString():String{
            var _local1:String;
            _local1 = DER.indent;
            DER.indent = (DER.indent + "    ");
            var _local2:String = join("\n");
            DER.indent = _local1;
            return ((((((((((DER.indent + "Set[") + type) + "][") + len) + "][\n") + _local2) + "\n") + _local1) + "]"));
        }


    }
}//package com.hurlant.util.der

