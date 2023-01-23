// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.crypto.symmetric.ISymmetricKey

package com.hurlant.crypto.symmetric{
    import flash.utils.ByteArray;

    public interface ISymmetricKey {

        function getBlockSize():uint;
        function encrypt(_arg1:ByteArray, _arg2:uint=0):void;
        function decrypt(_arg1:ByteArray, _arg2:uint=0):void;
        function dispose():void;
        function toString():String;

    }
}//package com.hurlant.crypto.symmetric

