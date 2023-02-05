// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.tooltip.SlotComparisonFactory

package com.company.assembleegameclient.ui.tooltip{
    import com.company.assembleegameclient.ui.tooltip.slotcomparisons.GeneralProjectileComparison;
    import com.company.assembleegameclient.ui.tooltip.slotcomparisons.GenericArmorComparison;
    import kabam.rotmg.constants.ItemConstants;
    import com.company.assembleegameclient.ui.tooltip.slotcomparisons.TomeComparison;
    import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SealComparison;
    import com.company.assembleegameclient.ui.tooltip.slotcomparisons.CloakComparison;
    import com.company.assembleegameclient.ui.tooltip.slotcomparisons.HelmetComparison;
    import com.company.assembleegameclient.ui.tooltip.slotcomparisons.OrbComparison;
    import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SlotComparison;

    public class SlotComparisonFactory {

        private var hash:Object;

        public function SlotComparisonFactory(){
            var _local1:GeneralProjectileComparison = new GeneralProjectileComparison();
            var _local2:GenericArmorComparison = new GenericArmorComparison();
            this.hash = {};
            this.hash[ItemConstants.TOME_TYPE] = new TomeComparison();
            this.hash[ItemConstants.LEATHER_TYPE] = _local2;
            this.hash[ItemConstants.PLATE_TYPE] = _local2;
            this.hash[ItemConstants.SEAL_TYPE] = new SealComparison();
            this.hash[ItemConstants.CLOAK_TYPE] = new CloakComparison();
            this.hash[ItemConstants.ROBE_TYPE] = _local2;
            this.hash[ItemConstants.HELM_TYPE] = new HelmetComparison();
            this.hash[ItemConstants.ORB_TYPE] = new OrbComparison();
        }

        public function getComparisonResults(_arg1:XML, _arg2:XML):SlotComparisonResult{
            var _local3:int = int(_arg1.SlotType);
            var _local4:SlotComparison = this.hash[_local3];
            var _local5:SlotComparisonResult = new SlotComparisonResult();
            if (_local4 != null){
                _local4.compare(_arg1, _arg2);
                _local5.lineBuilder = _local4.comparisonStringBuilder;
                _local5.processedTags = _local4.processedTags;
            }
            return (_local5);
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

