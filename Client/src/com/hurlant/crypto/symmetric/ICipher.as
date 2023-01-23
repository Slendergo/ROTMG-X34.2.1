// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.crypto.symmetric.ICipher

package com.hurlant.crypto.symmetric{
    import flash.utils.ByteArray;

    public interface ICipher {

        function getBlockSize():uint;
        function encrypt(_arg1:ByteArray):void;
        function decrypt(_arg1:ByteArray):void;
        function dispose():void;
        function toString():String;

    }
}//package com.hurlant.crypto.symmetric

