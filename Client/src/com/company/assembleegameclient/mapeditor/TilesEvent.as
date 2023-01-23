// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.TilesEvent

package com.company.assembleegameclient.mapeditor{
    import flash.events.Event;
    import com.company.util.IntPoint;

    class TilesEvent extends Event {

        public static const TILES_EVENT:String = "TILES_EVENT";

        public var tiles_:Vector.<IntPoint>;

        public function TilesEvent(_arg1:Vector.<IntPoint>){
            super(TILES_EVENT);
            this.tiles_ = _arg1;
        }

    }
}//package com.company.assembleegameclient.mapeditor

