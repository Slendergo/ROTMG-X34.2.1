﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.arena.view.ArenaTimer

package kabam.rotmg.arena.view{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.StaticTextDisplay;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.filters.DropShadowFilter;

    public class ArenaTimer extends Sprite {

        private const timerText:StaticTextDisplay = makeTimerText();
        private const timerStringBuilder:StaticStringBuilder = new StaticStringBuilder();
        private const timer:Timer = new Timer(1000);

        private var secs:Number = 0;


        public function start():void{
            this.updateTimer(null);
            this.timer.addEventListener(TimerEvent.TIMER, this.updateTimer);
            this.timer.start();
        }

        public function stop():void{
            this.timer.removeEventListener(TimerEvent.TIMER, this.updateTimer);
            this.timer.stop();
        }

        private function updateTimer(_arg1:TimerEvent):void{
            var _local2:int = (this.secs / 60);
            var _local3:int = (this.secs % 60);
            var _local4:String = (((_local2 < 10)) ? "0" : "");
            _local4 = (_local4 + (_local2 + ":"));
            _local4 = (_local4 + (((_local3 < 10)) ? "0" : ""));
            _local4 = (_local4 + _local3);
            this.timerText.setStringBuilder(this.timerStringBuilder.setString(_local4));
            this.secs++;
        }

        private function makeTimerText():StaticTextDisplay{
            var _local1:StaticTextDisplay = new StaticTextDisplay();
            _local1.setSize(24).setBold(true).setColor(0xFFFFFF);
            _local1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            addChild(_local1);
            return (_local1);
        }


    }
}//package kabam.rotmg.arena.view

