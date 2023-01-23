// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.crypto.hash.IHash

package com.hurlant.crypto.hash{
    import flash.utils.ByteArray;

    public interface IHash {

        function getInputSize():uint;
        function getHashSize():uint;
        function hash(_arg1:ByteArray):ByteArray;
        function toString():String;
        function getPadSize():int;

    }
}//package com.hurlant.crypto.hash

