﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.model.UseBuyPotionVO

package kabam.rotmg.game.model{
    public class UseBuyPotionVO {

        public static var SHIFTCLICK:String = "shift_click";
        public static var CONTEXTBUY:String = "context_buy";

        public var objectId:int;
        public var source:String;

        public function UseBuyPotionVO(_arg1:int, _arg2:String){
            this.objectId = _arg1;
            this.source = _arg2;
        }

    }
}//package kabam.rotmg.game.model

