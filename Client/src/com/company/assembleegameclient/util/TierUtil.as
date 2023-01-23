// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.util.TierUtil

package com.company.assembleegameclient.util{
    import io.decagames.rotmg.ui.labels.UILabel;
    import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class TierUtil {


        public static function getTierTag(_arg1:XML, _arg2:int=12):UILabel{
            var _local9:UILabel;
            var _local10:Number;
            var _local11:String;
            var _local3 = (isPet(_arg1) == false);
            var _local4 = (_arg1.hasOwnProperty("Consumable") == false);
            var _local5 = (_arg1.hasOwnProperty("InvUse") == false);
            var _local6 = (_arg1.hasOwnProperty("Treasure") == false);
            var _local7 = (_arg1.hasOwnProperty("PetFood") == false);
            var _local8:Boolean = _arg1.hasOwnProperty("Tier");
            if (((((((((_local3) && (_local4))) && (_local5))) && (_local6))) && (_local7))){
                _local9 = new UILabel();
                if (_local8){
                    _local10 = 0xFFFFFF;
                    _local11 = ("T" + _arg1.Tier);
                }
                else {
                    if (_arg1.hasOwnProperty("@setType")){
                        _local10 = TooltipHelper.SET_COLOR;
                        _local11 = "ST";
                    }
                    else {
                        _local10 = TooltipHelper.UNTIERED_COLOR;
                        _local11 = "UT";
                    };
                };
                _local9.text = _local11;
                DefaultLabelFormat.tierLevelLabel(_local9, _arg2, _local10);
                return (_local9);
            };
            return (null);
        }

        public static function isPet(_arg1:XML):Boolean{
            var activateTags:XMLList;
            var itemDataXML:XML = _arg1;
            activateTags = itemDataXML.Activate.(text() == "PermaPet");
            return ((activateTags.length() >= 1));
        }


    }
}//package com.company.assembleegameclient.util

