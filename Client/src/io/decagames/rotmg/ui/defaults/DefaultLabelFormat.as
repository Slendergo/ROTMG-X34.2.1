// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.defaults.DefaultLabelFormat

package io.decagames.rotmg.ui.defaults{
    import flash.text.TextFormat;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.text.TextFormatAlign;
    import com.company.assembleegameclient.util.FilterUtil;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.text.model.FontModel;

    public class DefaultLabelFormat {


        public static function createLabelFormat(_arg1:UILabel, _arg2:int=12, _arg3:Number=0xFFFFFF, _arg4:String="left", _arg5:Boolean=false, _arg6:Array=null):void{
            var _local7:TextFormat = createTextFormat(_arg2, _arg3, _arg4, _arg5);
            applyTextFormat(_local7, _arg1);
            if (_arg6){
                _arg1.filters = _arg6;
            }
        }

        public static function defaultButtonLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 16, 0xFFFFFF, TextFormatAlign.CENTER);
        }

        public static function defaultPopupTitle(_arg1:UILabel):void{
            createLabelFormat(_arg1, 32, 0xEAEAEA, TextFormatAlign.LEFT, true, FilterUtil.getUILabelDropShadowFilter01());
        }

        public static function defaultMediumPopupTitle(_arg1:UILabel, _arg2:String="left"):void{
            createLabelFormat(_arg1, 22, 0xEAEAEA, _arg2, true, FilterUtil.getUILabelDropShadowFilter01());
        }

        public static function defaultSmallPopupTitle(_arg1:UILabel, _arg2:String="left"):void{
            createLabelFormat(_arg1, 14, 0xEAEAEA, _arg2, true, FilterUtil.getUILabelDropShadowFilter01());
        }

        public static function friendsItemLabel(_arg1:UILabel, _arg2:Number=0xFFFFFF):void{
            createLabelFormat(_arg1, 14, _arg2, TextFormatAlign.LEFT, true, FilterUtil.getUILabelDropShadowFilter01());
        }

        public static function guildInfoLabel(_arg1:UILabel, _arg2:int=14, _arg3:Number=0xFFFFFF, _arg4:String="left"):void{
            createLabelFormat(_arg1, _arg2, _arg3, _arg4, true, FilterUtil.getUILabelDropShadowFilter01());
        }

        public static function characterViewNameLabel(_arg1:UILabel, _arg2:int=18):void{
            createLabelFormat(_arg1, _arg2, 0xB3B3B3, TextFormatAlign.LEFT, true, [new DropShadowFilter(0, 0, 0)]);
        }

        public static function characterFameNameLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xFFFFFF, TextFormatAlign.LEFT, true, FilterUtil.getUILabelDropShadowFilter01());
        }

        public static function characterFameInfoLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 12, 0x8C8C8C, TextFormatAlign.LEFT, true, FilterUtil.getUILabelDropShadowFilter01());
        }

        public static function characterToolTipLabel(_arg1:UILabel, _arg2:Number):void{
            createLabelFormat(_arg1, 12, _arg2, TextFormatAlign.LEFT, true);
        }

        public static function coinsFieldLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xFFFFFF, TextFormatAlign.RIGHT);
        }

        public static function numberSpinnerLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xEAEAEA, TextFormatAlign.CENTER);
        }

        public static function shopTag(_arg1:UILabel):void{
            createLabelFormat(_arg1, 12, 0xFFFFFF, TextFormatAlign.LEFT, true, FilterUtil.getUILabelDropShadowFilter02());
        }

        public static function popupTag(_arg1:UILabel):void{
            createLabelFormat(_arg1, 24, 0xFFFFFF, TextFormatAlign.LEFT, true, FilterUtil.getUILabelDropShadowFilter02());
        }

        public static function shopBoxTitle(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0xEAEAEA, TextFormatAlign.LEFT);
        }

        public static function defaultModalTitle(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xFFFFFF, TextFormatAlign.LEFT, false, FilterUtil.getUILabelDropShadowFilter01());
        }

        public static function defaultTextModalText(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0xFFFFFF, TextFormatAlign.CENTER);
        }

        public static function mysteryBoxContentInfo(_arg1:UILabel):void{
            createLabelFormat(_arg1, 12, 0x999999, TextFormatAlign.CENTER, true);
        }

        public static function mysteryBoxContentItemName(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0xFFFFFF, TextFormatAlign.LEFT);
        }

        public static function popupEndsIn(_arg1:UILabel):void{
            createLabelFormat(_arg1, 24, 0xFE9700, TextFormatAlign.LEFT, true, FilterUtil.getUILabelComboFilter());
        }

        public static function mysteryBoxEndsIn(_arg1:UILabel):void{
            createLabelFormat(_arg1, 12, 0xFE9700, TextFormatAlign.LEFT, true, FilterUtil.getUILabelComboFilter());
        }

        public static function popupStartsIn(_arg1:UILabel):void{
            createLabelFormat(_arg1, 24, 0xFF4200, TextFormatAlign.LEFT, true, FilterUtil.getUILabelComboFilter());
        }

        public static function mysteryBoxStartsIn(_arg1:UILabel):void{
            createLabelFormat(_arg1, 12, 0xFF4200, TextFormatAlign.LEFT, true, FilterUtil.getUILabelComboFilter());
        }

        public static function priceButtonLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xEAEAEA, TextFormatAlign.LEFT, false, FilterUtil.getUILabelDropShadowFilter01());
        }

        public static function originalPriceButtonLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 16, 0xEAEAEA, TextFormatAlign.LEFT, false, FilterUtil.getUILabelComboFilter());
        }

        public static function defaultInactiveTab(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0x616161, TextFormatAlign.LEFT, true);
        }

        public static function defaultActiveTab(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0xEAEAEA, TextFormatAlign.LEFT, true, FilterUtil.getUILabelDropShadowFilter02());
        }

        public static function mysteryBoxVaultInfo(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0xFE9700, TextFormatAlign.LEFT, true, FilterUtil.getUILabelDropShadowFilter02());
        }

        public static function currentFameLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 22, 16760388, TextFormatAlign.LEFT, true);
        }

        public static function deathFameLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xEAEAEA, TextFormatAlign.LEFT, true);
        }

        public static function deathFameCount(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xFFC800, TextFormatAlign.RIGHT, true);
        }

        public static function tierLevelLabel(_arg1:UILabel, _arg2:int=12, _arg3:Number=0xFFFFFF, _arg4:String="right"):void{
            createLabelFormat(_arg1, _arg2, _arg3, _arg4, true);
        }

        public static function questRefreshLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0xA3A3A3, TextFormatAlign.CENTER, true);
        }

        public static function questCompletedLabel(_arg1:UILabel, _arg2:Boolean, _arg3:Boolean):void{
            var _local4:Number = ((_arg2) ? 3971635 : 13224136);
            createLabelFormat(_arg1, 16, _local4, TextFormatAlign.LEFT, true);
        }

        public static function questNameLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 20, 15241232, TextFormatAlign.CENTER, true);
        }

        public static function notificationLabel(_arg1:UILabel, _arg2:int, _arg3:Number, _arg4:String, _arg5:Boolean):void{
            createLabelFormat(_arg1, _arg2, _arg3, _arg4, _arg5, FilterUtil.getUILabelDropShadowFilter01());
        }

        private static function applyTextFormat(_arg1:TextFormat, _arg2:UILabel):void{
            _arg2.defaultTextFormat = _arg1;
            _arg2.setTextFormat(_arg1);
        }

        public static function createTextFormat(_arg1:int, _arg2:uint, _arg3:String, _arg4:Boolean):TextFormat{
            var _local5:TextFormat = new TextFormat();
            _local5.color = _arg2;
            _local5.bold = _arg4;
            _local5.font = FontModel.DEFAULT_FONT_NAME;
            _local5.size = _arg1;
            _local5.align = _arg3;
            return (_local5);
        }

        public static function questDescriptionLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 16, 13224136, TextFormatAlign.CENTER);
        }

        public static function questRewardLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 16, 0xFFFFFF, TextFormatAlign.CENTER, true);
        }

        public static function questChoiceLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 13224136, TextFormatAlign.CENTER);
        }

        public static function questButtonCompleteLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xFFFFFF, TextFormatAlign.CENTER, true);
        }

        public static function questNameListLabel(_arg1:UILabel, _arg2:uint):void{
            createLabelFormat(_arg1, 14, _arg2, TextFormatAlign.LEFT, true);
        }

        public static function petNameLabel(_arg1:UILabel, _arg2:uint):void{
            createLabelFormat(_arg1, 18, _arg2, TextFormatAlign.CENTER, true);
        }

        public static function petNameLabelSmall(_arg1:UILabel, _arg2:uint):void{
            createLabelFormat(_arg1, 14, _arg2, TextFormatAlign.CENTER, true);
        }

        public static function petFamilyLabel(_arg1:UILabel, _arg2:uint):void{
            createLabelFormat(_arg1, 14, _arg2, TextFormatAlign.CENTER, true, FilterUtil.getUILabelComboFilter());
        }

        public static function petInfoLabel(_arg1:UILabel, _arg2:uint):void{
            createLabelFormat(_arg1, 12, _arg2, TextFormatAlign.CENTER);
        }

        public static function petStatLabelLeft(_arg1:UILabel, _arg2:uint):void{
            createLabelFormat(_arg1, 12, _arg2, TextFormatAlign.LEFT);
        }

        public static function petStatLabelRight(_arg1:UILabel, _arg2:uint, _arg3:Boolean=false):void{
            createLabelFormat(_arg1, 12, _arg2, TextFormatAlign.RIGHT, _arg3);
        }

        public static function petStatLabelLeftSmall(_arg1:UILabel, _arg2:uint):void{
            createLabelFormat(_arg1, 11, _arg2, TextFormatAlign.LEFT);
        }

        public static function petStatLabelRightSmall(_arg1:UILabel, _arg2:uint, _arg3:Boolean=false):void{
            createLabelFormat(_arg1, 11, _arg2, TextFormatAlign.RIGHT, _arg3);
        }

        public static function fusionStrengthLabel(_arg1:UILabel, _arg2:uint, _arg3:int):void{
            var _local4:Number = (((_arg3)!=0) ? _arg2 : 0xFFFFFF);
            createLabelFormat(_arg1, 14, _local4, TextFormatAlign.CENTER, true);
        }

        public static function feedPetInfo(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0xFFFFFF, TextFormatAlign.CENTER, true);
        }

        public static function wardrobeCollectionLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 12, 0xFFFFFF, TextFormatAlign.CENTER, true);
        }

        public static function petYardRarity(_arg1:UILabel):void{
            createLabelFormat(_arg1, 12, 0xA2A2A2, TextFormatAlign.CENTER, true);
        }

        public static function petYardUpgradeInfo(_arg1:UILabel):void{
            createLabelFormat(_arg1, 12, 0x8C8C8C, TextFormatAlign.CENTER, true);
        }

        public static function petYardUpgradeRarityInfo(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0xFFFFFF, TextFormatAlign.CENTER, true);
        }

        public static function newAbilityInfo(_arg1:UILabel):void{
            createLabelFormat(_arg1, 12, 0x999999, TextFormatAlign.CENTER, true);
        }

        public static function newAbilityName(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 8971493, TextFormatAlign.CENTER, true);
        }

        public static function newSkinHatched(_arg1:UILabel):void{
            createLabelFormat(_arg1, 14, 0x939393, TextFormatAlign.CENTER, true);
        }

        public static function infoTooltipText(_arg1:UILabel, _arg2:uint):void{
            createLabelFormat(_arg1, 14, _arg2, TextFormatAlign.LEFT);
        }

        public static function newSkinLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 9, 0, TextFormatAlign.CENTER, true);
        }

        public static function donateAmountLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xEAEAEA, TextFormatAlign.RIGHT, false);
        }

        public static function pointsAmountLabel(_arg1:UILabel):void{
            createLabelFormat(_arg1, 18, 0xEAEAEA, TextFormatAlign.CENTER, false);
        }


    }
}//package io.decagames.rotmg.ui.defaults

