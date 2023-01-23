// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.appengine.CharacterStats

package com.company.assembleegameclient.appengine{
    import com.company.assembleegameclient.util.FameUtil;

    public class CharacterStats {

        public var charStatsXML_:XML;

        public function CharacterStats(_arg1:XML){
            this.charStatsXML_ = _arg1;
        }

        public function bestLevel():int{
            return (this.charStatsXML_.BestLevel);
        }

        public function bestFame():int{
            return (this.charStatsXML_.BestFame);
        }

        public function numStars():int{
            return (FameUtil.numStars(int(this.charStatsXML_.BestFame)));
        }


    }
}//package com.company.assembleegameclient.appengine

