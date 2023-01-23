// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.screens.ServerBoxes

package com.company.assembleegameclient.screens{
    import flash.display.Sprite;
    import kabam.rotmg.servers.api.Server;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.parameters.Parameters;

    public class ServerBoxes extends Sprite {

        private var boxes_:Vector.<ServerBox>;
        private var _isChallenger:Boolean;

        public function ServerBoxes(_arg1:Vector.<Server>, _arg2:Boolean=false){
            var _local3:ServerBox;
            var _local5:Server;
            var _local6:String;
            this.boxes_ = new Vector.<ServerBox>();
            super();
            this._isChallenger = _arg2;
            _local3 = new ServerBox(null);
            _local3.setSelected(true);
            _local3.x = ((ServerBox.WIDTH / 2) + 2);
            _local3.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addChild(_local3);
            this.boxes_.push(_local3);
            var _local4:int = 2;
            for each (_local5 in _arg1) {
                _local3 = new ServerBox(_local5);
                _local6 = ((this._isChallenger) ? Parameters.data_.preferredChallengerServer : Parameters.data_.preferredServer);
                if (_local5.name == _local6){
                    this.setSelected(_local3);
                };
                _local3.x = ((_local4 % 2) * (ServerBox.WIDTH + 4));
                _local3.y = (int((_local4 / 2)) * (ServerBox.HEIGHT + 4));
                _local3.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                addChild(_local3);
                this.boxes_.push(_local3);
                _local4++;
            };
        }

        private function onMouseDown(_arg1:MouseEvent):void{
            var _local2:ServerBox = (_arg1.currentTarget as ServerBox);
            if (_local2 == null){
                return;
            };
            this.setSelected(_local2);
            var _local3:String = _local2.value_;
            if (this._isChallenger){
                Parameters.data_.preferredChallengerServer = _local3;
            }
            else {
                Parameters.data_.preferredServer = _local3;
            };
            Parameters.save();
        }

        private function setSelected(_arg1:ServerBox):void{
            var _local2:ServerBox;
            for each (_local2 in this.boxes_) {
                _local2.setSelected(false);
            };
            _arg1.setSelected(true);
        }


    }
}//package com.company.assembleegameclient.screens

