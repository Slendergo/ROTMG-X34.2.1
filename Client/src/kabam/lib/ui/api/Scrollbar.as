// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.ui.api.Scrollbar

package kabam.lib.ui.api{
    import org.osflash.signals.Signal;

    public interface Scrollbar {

        function get positionChanged():Signal;
        function setSize(_arg1:int, _arg2:int):void;
        function getBarSize():int;
        function getGrooveSize():int;
        function getPosition():Number;
        function setPosition(_arg1:Number):void;

    }
}//package kabam.lib.ui.api

