// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.crypto.prng.IPRNG

package com.hurlant.crypto.prng{
    import flash.utils.ByteArray;

    public interface IPRNG {

        function getPoolSize():uint;
        function init(_arg1:ByteArray):void;
        function next():uint;
        function dispose():void;
        function toString():String;

    }
}//package com.hurlant.crypto.prng

