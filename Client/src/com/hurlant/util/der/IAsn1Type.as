// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.util.der.IAsn1Type

package com.hurlant.util.der{
    import flash.utils.ByteArray;

    public interface IAsn1Type {

        function getType():uint;
        function getLength():uint;
        function toDER():ByteArray;

    }
}//package com.hurlant.util.der

