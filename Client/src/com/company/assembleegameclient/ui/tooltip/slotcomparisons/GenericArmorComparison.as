// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.tooltip.slotcomparisons.GenericArmorComparison

package com.company.assembleegameclient.ui.tooltip.slotcomparisons{
    import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

    public class GenericArmorComparison extends SlotComparison {

        private static const DEFENSE_STAT:String = "21";

        private var defTags:XMLList;
        private var otherDefTags:XMLList;

        public function GenericArmorComparison(){
            comparisonStringBuilder = new AppendingLineBuilder();
        }

        override protected function compareSlots(_arg1:XML, _arg2:XML):void{
            var defense:int;
            var otherDefense:int;
            var itemXML:XML = _arg1;
            var curItemXML:XML = _arg2;
            this.defTags = itemXML.ActivateOnEquip.(@stat == DEFENSE_STAT);
            this.otherDefTags = curItemXML.ActivateOnEquip.(@stat == DEFENSE_STAT);
            if ((((this.defTags.length() == 1)) && ((this.otherDefTags.length() == 1)))){
                defense = int(this.defTags.@amount);
                otherDefense = int(this.otherDefTags.@amount);
            }
        }

        private function compareDefense(_arg1:int, _arg2:int):String{
            var _local3:uint = getTextColor((_arg1 - _arg2));
            return (wrapInColoredFont((("+" + _arg1) + " Defense"), _local3));
        }


    }
}//package com.company.assembleegameclient.ui.tooltip.slotcomparisons

