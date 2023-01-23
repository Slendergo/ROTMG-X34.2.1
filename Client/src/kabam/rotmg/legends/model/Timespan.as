﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.legends.model.Timespan

package kabam.rotmg.legends.model{
    import kabam.rotmg.text.model.TextKey;

    public class Timespan {

        public static const WEEK:Timespan = new Timespan(TextKey.TIMESPAN_WEEK, "week");
        public static const MONTH:Timespan = new Timespan(TextKey.TIMESPAN_MONTH, "month");
        public static const ALL:Timespan = new Timespan(TextKey.TIMESPAN_ALL, "all");
        public static const TIMESPANS:Vector.<Timespan> = new <Timespan>[WEEK, MONTH, ALL];

        private var name:String;
        private var id:String;

        public function Timespan(_arg1:String, _arg2:String){
            this.name = _arg1;
            this.id = _arg2;
        }

        public function getName():String{
            return (this.name);
        }

        public function getId():String{
            return (this.id);
        }


    }
}//package kabam.rotmg.legends.model

