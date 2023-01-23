// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.model.QuestModel

package kabam.rotmg.game.model{

    public class QuestModel {

        public static const LEVEL_REQUIREMENT:int = 0;
        public static const REMAINING_HEROES_REQUIREMENT:int = 1;
        public static const ORYX_KILLED:int = 2;
        public static const ORYX_THE_MAD_GOD:String = "Oryx the Mad God";

        private var _previousRealm:String = "";
        private var _currentQuestHero:String;
        private var _remainingHeroes:int = -1;
        private var _requirementsStates:Vector.<Boolean>;
        private var _hasOryxBeenKilled:Boolean;

        public function QuestModel(){
            this._requirementsStates = new <Boolean>[false, false, false];
            super();
        }

        public function get currentQuestHero():String{
            return (this._currentQuestHero);
        }

        public function set currentQuestHero(_arg1:String):void{
            this._currentQuestHero = _arg1;
        }

        public function get remainingHeroes():int{
            return (this._remainingHeroes);
        }

        public function set remainingHeroes(_arg1:int):void{
            this._remainingHeroes = _arg1;
        }

        public function get previousRealm():String{
            return (this._previousRealm);
        }

        public function set previousRealm(_arg1:String):void{
            this._previousRealm = _arg1;
        }

        public function get requirementsStates():Vector.<Boolean>{
            return (this._requirementsStates);
        }

        public function set requirementsStates(_arg1:Vector.<Boolean>):void{
            this._requirementsStates = _arg1;
        }

        public function get hasOryxBeenKilled():Boolean{
            return (this._hasOryxBeenKilled);
        }

        public function set hasOryxBeenKilled(_arg1:Boolean):void{
            this._hasOryxBeenKilled = _arg1;
        }

        public function resetRequirementsStates():void{
            var _local1:int = this._requirementsStates.length;
            var _local2:int;
            while (_local2 < _local1) {
                this._requirementsStates[_local2] = false;
                _local2++;
            };
        }


    }
}//package kabam.rotmg.game.model

