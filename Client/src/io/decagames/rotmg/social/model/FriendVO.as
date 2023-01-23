// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.model.FriendVO

package io.decagames.rotmg.social.model{
    import com.company.assembleegameclient.objects.Player;
    import flash.display.BitmapData;

    public class FriendVO {

        public var playerName:String;
        protected var _player:Player;
        protected var _isOnline:Boolean;
        protected var _serverName:String;
        protected var _serverAddr:String;
        private var _lastLogin:Number;

        public function FriendVO(_arg1:Player, _arg2:Boolean=false, _arg3:String="", _arg4:String=""){
            this._player = _arg1;
            this._isOnline = _arg2;
            this._serverName = _arg3;
            this._serverAddr = _arg4;
            this.playerName = this._player.getName();
        }

        public function updatePlayer(_arg1:Player):void{
            this._player = _arg1;
            this.playerName = this._player.getName();
        }

        public function getServerName():String{
            return (this._serverName);
        }

        public function getName():String{
            return (this._player.getName());
        }

        public function getPortrait():BitmapData{
            return (this._player.getPortrait());
        }

        public function get isOnline():Boolean{
            return (this._isOnline);
        }

        public function online(_arg1:String, _arg2:String):void{
            this._isOnline = true;
            this._serverName = _arg1;
            this._serverAddr = _arg2;
        }

        public function offline():void{
            this._isOnline = false;
            this._serverName = "";
            this._serverAddr = "";
        }

        public function get lastLogin():Number{
            return (this._lastLogin);
        }

        public function set lastLogin(_arg1:Number):void{
            this._lastLogin = _arg1;
        }


    }
}//package io.decagames.rotmg.social.model

