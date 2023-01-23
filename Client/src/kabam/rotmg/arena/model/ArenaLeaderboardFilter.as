// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.arena.model.ArenaLeaderboardFilter

package kabam.rotmg.arena.model{

    public class ArenaLeaderboardFilter {

        private var name:String;
        private var key:String;
        private var entries:Vector.<ArenaLeaderboardEntry>;

        public function ArenaLeaderboardFilter(_arg1:String, _arg2:String){
            this.name = _arg1;
            this.key = _arg2;
        }

        public function getName():String{
            return (this.name);
        }

        public function getKey():String{
            return (this.key);
        }

        public function getEntries():Vector.<ArenaLeaderboardEntry>{
            return (this.entries);
        }

        public function setEntries(_arg1:Vector.<ArenaLeaderboardEntry>):void{
            this.entries = _arg1;
        }

        public function hasEntries():Boolean{
            return (!((this.entries == null)));
        }

        public function clearEntries():void{
            this.entries = null;
        }


    }
}//package kabam.rotmg.arena.model

