// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.supportCampaign.tab.SupporterShopTabView

package io.decagames.rotmg.supportCampaign.tab{
    import io.decagames.rotmg.ui.tabs.UITab;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.shop.ShopBuyButton;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.supportCampaign.tab.tiers.preview.TiersPreview;
    import io.decagames.rotmg.supportCampaign.tab.tiers.progressBar.TiersProgressBar;
    import flash.display.DisplayObject;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import io.decagames.rotmg.utils.date.TimeSpan;
    import io.decagames.rotmg.supportCampaign.data.vo.RankVO;
    import io.decagames.rotmg.supportCampaign.tab.donate.DonatePanel;

    public class SupporterShopTabView extends UITab {

        private var backgroundWidth:int = 561;
        private var background:SliceScalingBitmap;
        private var _unlockButton:ShopBuyButton;
        private var _countdown:UILabel;
        private var _campaignTimer:UILabel;
        private var unlockScreenContainer:Sprite;
        private var pointsInfo:UILabel;
        private var supportIcon:SliceScalingBitmap;
        private var _infoButton:SliceScalingButton;
        private var fieldBackground:SliceScalingBitmap;
        private var endDateInfo:UILabel;
        private var tiersPreview:TiersPreview;
        private var progressBar:TiersProgressBar;
        private var pName:String;
        private var _campaignTitle:String;
        private var _campaignDescription:String;

        public function SupporterShopTabView(_arg1:String, _arg2:String){
            super(_arg1);
            this._campaignTitle = _arg1;
            this._campaignDescription = _arg2;
            this._countdown = new UILabel();
            this._campaignTimer = new UILabel();
        }

        public function show(_arg1:String, _arg2:Boolean, _arg3:Boolean, _arg4:int, _arg5:int, _arg6:Boolean, _arg7:DisplayObject):void{
            this.pName = _arg1;
            this.drawBackground(_arg2);
            if (_arg2){
                if (this.unlockScreenContainer != null){
                    removeChild(this.unlockScreenContainer);
                    this.unlockScreenContainer = null;
                };
                this.drawDonatePanel(_arg5, _arg6);
            }
            else {
                this.showUnlockScreen(_arg3, _arg4, _arg5, _arg6, _arg7);
            };
        }

        public function updateStartCountdown(_arg1:String):void{
            this._countdown.text = _arg1;
            if (_arg1 == ""){
                this._campaignTimer.text = "";
            };
        }

        public function updatePoints(_arg1:int, _arg2:int):void{
            if (!this.pointsInfo){
                this.fieldBackground = TextureParser.instance.getSliceScalingBitmap("UI", "bordered_field", 150);
                addChild(this.fieldBackground);
                this.pointsInfo = new UILabel();
                DefaultLabelFormat.createLabelFormat(this.pointsInfo, 18, 15585539, TextFormatAlign.CENTER, true);
                addChild(this.pointsInfo);
                this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI", "campaign_Points");
                addChild(this.supportIcon);
                this._infoButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "tier_info"));
                addChild(this._infoButton);
            };
            this.pointsInfo.text = ((_arg1) ? _arg1.toString() : "0");
            this.pointsInfo.x = (((this.background.width / 2) - (this.pointsInfo.width / 2)) + 8);
            this.pointsInfo.y = (this.background.y - 8);
            this.fieldBackground.y = (this.pointsInfo.y - 5);
            this.fieldBackground.x = (((this.background.width / 2) - (this.fieldBackground.width / 2)) + 13);
            this.supportIcon.y = (this.pointsInfo.y + 1);
            this.supportIcon.x = (this.pointsInfo.x + this.pointsInfo.width);
            this._infoButton.y = (this.fieldBackground.y + 1);
            this._infoButton.x = (this.fieldBackground.x + 3);
        }

        public function updateTime(_arg1:Number):void{
            var _local2:TimeSpan = new TimeSpan(_arg1);
            var _local3 = "Campaign will end in: ";
            if (_local2.totalMilliseconds <= 0){
                _local3 = "Campaign has ended!";
            }
            else {
                if (_local2.totalDays == 0){
                    _local3 = (_local3 + ((((((_local2.hours > 9)) ? _local2.hours.toString() : ("0" + _local2.hours.toString())) + "h ") + (((_local2.minutes > 9)) ? _local2.minutes.toString() : ("0" + _local2.minutes.toString()))) + "m"));
                }
                else {
                    _local3 = (_local3 + ((((((_local2.days > 9)) ? _local2.days.toString() : ("0" + _local2.days.toString())) + "d ") + (((_local2.hours > 9)) ? _local2.hours.toString() : ("0" + _local2.hours.toString()))) + "h"));
                };
            };
            if (!this.endDateInfo){
                this.endDateInfo = new UILabel();
                DefaultLabelFormat.createLabelFormat(this.endDateInfo, 14, 0xFE9700, TextFormatAlign.CENTER, false);
                addChild(this.endDateInfo);
            };
            this.endDateInfo.text = _local3;
            this.endDateInfo.wordWrap = true;
            this.endDateInfo.width = (this.background.width - 13);
            this.endDateInfo.x = (this.background.x + 13);
            this.endDateInfo.y = ((this.background.y + this.background.height) - 115);
        }

        public function showTier(_arg1:int, _arg2:Array, _arg3:int, _arg4:int, _arg5:DisplayObject):void{
            if (!this.tiersPreview){
                this.tiersPreview = new TiersPreview(_arg2, 530);
                this.tiersPreview.x = (this.background.x + 15);
                this.tiersPreview.y = (this.background.y + 20);
                addChild(this.tiersPreview);
            };
            this.tiersPreview.showTier(_arg1, _arg3, _arg4, _arg5);
        }

        public function drawProgress(_arg1:int, _arg2:Vector.<RankVO>, _arg3:int, _arg4:int):void{
            if (!this.progressBar){
                this.progressBar = new TiersProgressBar(_arg2, 530);
                this.progressBar.x = (this.background.x + 15);
                this.progressBar.y = 285;
                addChild(this.progressBar);
            };
            this.progressBar.show(_arg1, _arg3, _arg4);
        }

        private function showUnlockScreen(_arg1:Boolean, _arg2:int, _arg3:int, _arg4:Boolean, _arg5:DisplayObject):void{
            this.unlockScreenContainer = new Sprite();
            this.unlockScreenContainer.x = 30;
            this.unlockScreenContainer.y = 10;
            this.unlockScreenContainer.addChild(_arg5);
            var _local6:UILabel = new UILabel();
            _local6.text = (((("Welcome to the " + this._campaignTitle) + ", ") + this.pName) + "!");
            DefaultLabelFormat.createLabelFormat(_local6, 18, 0xEAEAEA, TextFormatAlign.LEFT, true);
            _local6.wordWrap = true;
            _local6.width = (_arg5.width - 20);
            _local6.x = 10;
            _local6.y = (_arg5.height + 10);
            this.unlockScreenContainer.addChild(_local6);
            var _local7:UILabel = new UILabel();
            _local7.text = this._campaignDescription;
            DefaultLabelFormat.createLabelFormat(_local7, 14, 0xEAEAEA, TextFormatAlign.JUSTIFY, false);
            _local7.wordWrap = true;
            _local7.width = (_arg5.width - 20);
            _local7.x = 10;
            _local7.y = (_local6.y + _local6.height);
            this.unlockScreenContainer.addChild(_local7);
            var _local8:SliceScalingBitmap = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration_dark", 150);
            this.unlockScreenContainer.addChild(_local8);
            this._unlockButton = new ShopBuyButton(_arg2);
            this._unlockButton.width = (_local8.width - 48);
            this._unlockButton.disabled = ((!(_arg1)) || (_arg4));
            this.unlockScreenContainer.addChild(this._unlockButton);
            _local8.x = Math.round(((_arg5.width - _local8.width) / 2));
            _local8.y = (_local7.y + _local7.height);
            this._unlockButton.x = (_local8.x + 24);
            this._unlockButton.y = (_local8.y + 6);
            if (!_arg1){
                this._campaignTimer.text = (("The " + this._campaignTitle) + " will start in:");
                DefaultLabelFormat.createLabelFormat(this._countdown, 18, 0xFE9700, TextFormatAlign.CENTER, true);
                this._countdown.text = "";
                this._countdown.wordWrap = true;
                this._countdown.width = _arg5.width;
                this._countdown.y = (_local6.y - 20);
                this.unlockScreenContainer.addChild(this._countdown);
            }
            else {
                if (_arg4){
                    this._campaignTimer.text = (("The " + this._campaignTitle) + " has ended!");
                    DefaultLabelFormat.createLabelFormat(this._countdown, 18, 0xFE9700, TextFormatAlign.CENTER, true);
                    this._countdown.text = "";
                    this._countdown.wordWrap = true;
                    this._countdown.width = _arg5.width;
                    this._countdown.y = 197;
                    this.unlockScreenContainer.addChild(this._countdown);
                };
            };
            DefaultLabelFormat.createLabelFormat(this._campaignTimer, 14, 0xFE9700, TextFormatAlign.CENTER, false);
            this._campaignTimer.wordWrap = true;
            this._campaignTimer.width = _arg5.width;
            this._campaignTimer.y = (this._countdown.y = (_local6.y - 20));
            this.unlockScreenContainer.addChild(this._campaignTimer);
            addChild(this.unlockScreenContainer);
        }

        public function updateTimerPosition():void{
        }

        private function drawBackground(_arg1:Boolean):void{
            this.background = TextureParser.instance.getSliceScalingBitmap("UI", "shop_box_background", this.backgroundWidth);
            addChild(this.background);
            this.background.height = 375;
            this.background.x = 14;
            this.background.y = 0;
        }

        private function drawDonatePanel(_arg1:int, _arg2:Boolean):void{
            var _local3:DonatePanel = new DonatePanel(_arg1, _arg2);
            addChild(_local3);
            _local3.x = (this.background.x + Math.round(((this.backgroundWidth - _local3.width) / 2)));
            _local3.y = (this.background.height - 55);
        }

        public function get unlockButton():ShopBuyButton{
            return (this._unlockButton);
        }

        public function get infoButton():SliceScalingButton{
            return (this._infoButton);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tab

