// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.characterMetrics.tracker.CharactersMetricsTracker

package io.decagames.rotmg.characterMetrics.tracker{
    import flash.utils.Dictionary;
    import com.hurlant.util.Base64;
    import io.decagames.rotmg.characterMetrics.data.CharacterMetricsData;
    import flash.utils.IDataInput;

    public class CharactersMetricsTracker {

        public static const STATS_SIZE:int = 5;

        private var charactersStats:Dictionary;
        private var _lastUpdate:Date;

        public function setBinaryStringData(_arg1:int, _arg2:String):void{
            var _local3:RegExp = /-/g;
            var _local4:RegExp = /_/g;
            var _local5:int = (4 - (_arg2.length % 4));
            while (_local5--) {
                _arg2 = (_arg2 + "=");
            };
            _arg2 = _arg2.replace(_local3, "+").replace(_local4, "/");
            this.setBinaryData(_arg1, Base64.decodeToByteArray(_arg2));
        }

        public function setBinaryData(_arg1:int, _arg2:IDataInput):void{
            var _local3:int;
            var _local4:int;
            if (!this.charactersStats){
                this.charactersStats = new Dictionary();
            }
            if (!this.charactersStats[_arg1]){
                this.charactersStats[_arg1] = new CharacterMetricsData();
            }
            while (_arg2.bytesAvailable >= STATS_SIZE) {
                _local3 = _arg2.readByte();
                _local4 = _arg2.readInt();
                this.charactersStats[_arg1].setStat(_local3, _local4);
            }
            this._lastUpdate = new Date();
        }

        public function get lastUpdate():Date{
            return (this._lastUpdate);
        }

        public function getCharacterStat(_arg1:int, _arg2:int):int{
            if (!this.charactersStats){
                this.charactersStats = new Dictionary();
            }
            if (!this.charactersStats[_arg1]){
                return (0);
            }
            return (this.charactersStats[_arg1].getStat(_arg2));
        }

        public function parseCharListData(_arg1:XML):void{
            var _local2:XML;
            for each (_local2 in _arg1.Char) {
                this.setBinaryStringData(int(_local2.@id), _local2.PCStats);
            }
        }
    }
}//package io.decagames.rotmg.characterMetrics.tracker

