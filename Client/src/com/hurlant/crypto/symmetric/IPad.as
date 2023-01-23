// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.crypto.symmetric.IPad

package com.hurlant.crypto.symmetric{
    import flash.utils.ByteArray;

    public interface IPad {

        function pad(_arg1:ByteArray):void;
        function unpad(_arg1:ByteArray):void;
        function setBlockSize(_arg1:uint):void;

    }
}//package com.hurlant.crypto.symmetric

