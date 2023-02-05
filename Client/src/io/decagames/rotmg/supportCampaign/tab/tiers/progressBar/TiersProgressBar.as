// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.supportCampaign.tab.tiers.progressBar.TiersProgressBar

package io.decagames.rotmg.supportCampaign.tab.tiers.progressBar{
    import flash.display.Sprite;
    import io.decagames.rotmg.supportCampaign.data.vo.RankVO;
    import io.decagames.rotmg.supportCampaign.tab.tiers.button.TierButton;
    import io.decagames.rotmg.ui.ProgressBar;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.supportCampaign.tab.tiers.button.status.TierButtonStatus;

    public class TiersProgressBar extends Sprite {

        private var _ranks:Vector.<RankVO>;
        private var _componentWidth:int;
        private var _currentRank:int;
        private var _claimed:int;
        private var buttonAreReady:Boolean;
        private var _buttons:Vector.<TierButton>;
        private var _progressBar:ProgressBar;
        private var _points:int;
        private var supportIcon:SliceScalingBitmap;

        public function TiersProgressBar(_arg1:Vector.<RankVO>, _arg2:int){
            this._ranks = _arg1;
            this._componentWidth = _arg2;
            this._buttons = new Vector.<TierButton>();
            this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI", "campaign_Points");
        }

        public function show(_arg1:int, _arg2:int, _arg3:int):void{
            this._currentRank = _arg2;
            this._claimed = _arg3;
            this._points = _arg1;
            if (!this.buttonAreReady){
                this.renderProgressBar();
                this.renderButtons();
            }
            this.updateProgressBar();
            this.updateButtons();
        }

        private function getStatusByTier(_arg1:int):int{
            if (this._claimed >= _arg1){
                return (TierButtonStatus.CLAIMED);
            }
            if (this._currentRank >= _arg1){
                return (TierButtonStatus.UNLOCKED);
            }
            return (TierButtonStatus.LOCKED);
        }

        private function updateButtons():void{
            var _local2:TierButton;
            var _local1:Boolean;
            for each (_local2 in this._buttons) {
                _local2.updateStatus(this.getStatusByTier(_local2.tier));
                if (((!(_local1)) && ((this.getStatusByTier(_local2.tier) == TierButtonStatus.UNLOCKED)))){
                    _local1 = true;
                    _local2.selected = true;
                }
                else {
                    _local2.selected = false;
                }
            }
            if (!_local1){
                if (this._currentRank != 0){
                    for each (_local2 in this._buttons) {
                        if (this._currentRank == _local2.tier){
                            _local1 = true;
                            _local2.selected = true;
                        }
                    }
                }
            }
            if (!_local1){
                this._buttons[0].selected = true;
            }
        }

        private function updateProgressBar():void{
            var _local1:int = this._points;
            if (this._progressBar.value != _local1){
                if (_local1 > (this._progressBar.maxValue - this._progressBar.minValue)){
                    this._progressBar.value = (this._progressBar.maxValue - this._progressBar.minValue);
                }
                else {
                    this._progressBar.value = _local1;
                }
            }
        }

        private function renderProgressBar():void{
            this._progressBar = new ProgressBar(this._componentWidth, 4, "", "", 0, this._ranks[(this._ranks.length - 1)].points, 0, 0x545454, 1029573);
            this._progressBar.y = 7;
            this._progressBar.shouldAnimate = false;
            addChild(this._progressBar);
            this.supportIcon.x = -4;
            this.supportIcon.y = 5;
            addChild(this.supportIcon);
        }

        private function renderButtons():void{
            var _local2:RankVO;
            var _local3:int;
            var _local4:int;
            var _local5:int;
            var _local6:int;
            var _local7:TierButton;
            var _local8:TierButton;
            var _local1:int = 1;
            for each (_local2 in this._ranks) {
                _local7 = new TierButton(_local1, this.getStatusByTier(_local1));
                this._buttons.push(_local7);
                _local1++;
            }
            _local3 = this._buttons.length;
            _local4 = (this._componentWidth / _local3);
            _local5 = 1;
            _local6 = (_local3 - 1);
            while (_local6 >= 0) {
                _local8 = this._buttons[_local6];
                _local8.x = (this._componentWidth - (_local5 * _local4));
                addChild(_local8);
                _local5++;
                _local6--;
            }
            this.buttonAreReady = true;
        }


    }
}//package io.decagames.rotmg.supportCampaign.tab.tiers.progressBar

