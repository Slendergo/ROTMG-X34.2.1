// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//ru.inspirit.net.events.MultipartURLLoaderEvent

package ru.inspirit.net.events{
    import flash.events.Event;

    public class MultipartURLLoaderEvent extends Event {

        public static const DATA_PREPARE_PROGRESS:String = "dataPrepareProgress";
        public static const DATA_PREPARE_COMPLETE:String = "dataPrepareComplete";

        public var bytesWritten:uint = 0;
        public var bytesTotal:uint = 0;

        public function MultipartURLLoaderEvent(_arg1:String, _arg2:uint=0, _arg3:uint=0){
            super(_arg1);
            this.bytesTotal = _arg3;
            this.bytesWritten = _arg2;
        }

    }
}//package ru.inspirit.net.events

