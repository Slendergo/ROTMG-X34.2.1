// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.model.FriendRequestVO

package io.decagames.rotmg.social.model{
    public class FriendRequestVO {

        public var request:String;
        public var target:String;
        public var callback:Function;

        public function FriendRequestVO(_arg1:String, _arg2:String, _arg3:Function=null){
            this.request = _arg1;
            this.target = _arg2;
            this.callback = _arg3;
        }

    }
}//package io.decagames.rotmg.social.model

