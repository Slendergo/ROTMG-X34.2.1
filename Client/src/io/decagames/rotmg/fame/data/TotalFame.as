// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.fame.data.TotalFame

package io.decagames.rotmg.fame.data{
    import io.decagames.rotmg.fame.data.bonus.FameBonus;
    import flash.utils.Dictionary;

    public class TotalFame {

        private var _bonuses:Vector.<FameBonus>;
        private var _baseFame:Number;
        private var _currentFame:Number;

        public function TotalFame(_arg1:Number){
            this._bonuses = new Vector.<FameBonus>();
            super();
            this._baseFame = _arg1;
            this._currentFame = _arg1;
        }

        public function addBonus(_arg1:FameBonus):void{
            if (_arg1 != null){
                this._bonuses.push(_arg1);
                this._currentFame = (this._currentFame + _arg1.fameAdded);
            }
        }

        public function get bonuses():Dictionary{
            var _local2:FameBonus;
            var _local1:Dictionary = new Dictionary();
            for each (_local2 in this._bonuses) {
                _local1[_local2.id] = _local2;
            }
            return (_local1);
        }

        public function get baseFame():int{
            return (this._baseFame);
        }

        public function get currentFame():int{
            return (this._currentFame);
        }


    }
}//package io.decagames.rotmg.fame.data

