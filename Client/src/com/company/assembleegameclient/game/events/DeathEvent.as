﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.game.events.DeathEvent

package com.company.assembleegameclient.game.events{
    import flash.events.Event;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.objects.Player;

    public class DeathEvent extends Event {

        public static const DEATH:String = "DEATH";

        public var background_:BitmapData;
        public var player_:Player;
        public var accountId_:int;
        public var charId_:int;

        public function DeathEvent(_arg1:BitmapData, _arg2:int, _arg3:int){
            super(DEATH);
            this.background_ = _arg1;
            this.accountId_ = _arg2;
            this.charId_ = _arg3;
        }

    }
}//package com.company.assembleegameclient.game.events

