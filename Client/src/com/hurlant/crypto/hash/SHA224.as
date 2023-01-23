// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.crypto.hash.SHA224

package com.hurlant.crypto.hash{
    public class SHA224 extends SHA256 {

        public function SHA224(){
            h = [3238371032, 914150663, 812702999, 4144912697, 4290775857, 1750603025, 1694076839, 3204075428];
        }

        override public function getHashSize():uint{
            return (28);
        }

        override public function toString():String{
            return ("sha224");
        }


    }
}//package com.hurlant.crypto.hash

