// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.crypto.hash.IHMAC

package com.hurlant.crypto.hash{
    import flash.utils.ByteArray;

    public interface IHMAC {

        function getHashSize():uint;
        function compute(_arg1:ByteArray, _arg2:ByteArray):ByteArray;
        function dispose():void;
        function toString():String;

    }
}//package com.hurlant.crypto.hash

