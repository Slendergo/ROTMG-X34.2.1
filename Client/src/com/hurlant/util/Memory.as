// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.hurlant.util.Memory

package com.hurlant.util{
    import flash.net.LocalConnection;
    import flash.system.System;

    public class Memory {


        public static function gc():void{
            try {
                new LocalConnection().connect("foo");
                new LocalConnection().connect("foo");
            }
            catch(e) {
            };
        }

        public static function get used():uint{
            return (System.totalMemory);
        }


    }
}//package com.hurlant.util

