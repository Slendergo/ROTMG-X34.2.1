// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.characterMetrics.data.CharacterMetricsData

package io.decagames.rotmg.characterMetrics.data{
    import flash.utils.Dictionary;

    public class CharacterMetricsData {

        private var stats:Dictionary;

        public function CharacterMetricsData(){
            this.stats = new Dictionary();
        }

        public function setStat(_arg1:int, _arg2:int):void{
            this.stats[_arg1] = _arg2;
        }

        public function getStat(_arg1:int):int{
            if (!this.stats[_arg1]){
                return (0);
            };
            return (this.stats[_arg1]);
        }


    }
}//package io.decagames.rotmg.characterMetrics.data

