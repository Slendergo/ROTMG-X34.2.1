// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petStatsGrid.PetFeedStatsGrid

package io.decagames.rotmg.pets.components.petStatsGrid{
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.pets.data.vo.IPetVO;
    import io.decagames.rotmg.ui.PetFeedProgressBar;
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.pets.components.petInfoSlot.PetInfoSlot;
    import io.decagames.rotmg.pets.data.vo.AbilityVO;
    import io.decagames.rotmg.pets.data.ability.AbilitiesUtil;
    import flash.text.TextFormatAlign;

    public class PetFeedStatsGrid extends UIGrid {

        private var _petVO:IPetVO;
        private var abilityBars:Vector.<PetFeedProgressBar>;
        private var _labelContainer:Sprite;
        private var _plusLabels:Vector.<UILabel>;
        private var _currentLevels:Vector.<int>;
        private var _maxLevel:int;

        public function PetFeedStatsGrid(_arg1:int, _arg2:IPetVO){
            super(_arg1, 1, 3);
            this._petVO = _arg2;
            this.init();
        }

        private function init():void{
            this.abilityBars = new Vector.<PetFeedProgressBar>();
            this._currentLevels = new <int>[];
            this._labelContainer = new Sprite();
            this._labelContainer.x = -2;
            this._labelContainer.y = -13;
            this._labelContainer.visible = false;
            addChild(this._labelContainer);
            this.createLabels();
            this.createPlusLabels();
            if (this._petVO){
                this._maxLevel = this._petVO.maxAbilityPower;
                this.refreshAbilities(this._petVO);
            };
        }

        private function createPlusLabels():void{
            var _local1:int;
            var _local2:UILabel;
            this._plusLabels = new <UILabel>[];
            _local1 = 0;
            while (_local1 < 3) {
                _local2 = new UILabel();
                DefaultLabelFormat.petStatLabelRight(_local2, 6538829);
                _local2.x = (PetInfoSlot.FEED_STATS_WIDTH + 8);
                _local2.y = (_local1 * 23);
                _local2.visible = false;
                addChild(_local2);
                this._plusLabels.push(_local2);
                _local1++;
            };
        }

        private function createLabels():void{
            var _local2:UILabel;
            var _local1:UILabel = new UILabel();
            DefaultLabelFormat.petStatLabelLeftSmall(_local1, 0xA2A2A2);
            _local1.text = "Ability";
            _local1.y = -3;
            this._labelContainer.addChild(_local1);
            _local2 = new UILabel();
            DefaultLabelFormat.petStatLabelRightSmall(_local2, 0xA2A2A2);
            _local2.text = "Level";
            _local2.x = ((195 - _local2.width) + 4);
            _local2.y = -3;
            this._labelContainer.addChild(_local2);
        }

        public function renderSimulation(_arg1:Array):void{
            var _local3:AbilityVO;
            var _local2:int;
            for each (_local3 in _arg1) {
                this.renderAbilitySimulation(_local3, _local2);
                _local2++;
            };
        }

        private function refreshAbilities(_arg1:IPetVO):void{
            var _local2:int;
            var _local3:AbilityVO;
            this._currentLevels.length = 0;
            this._maxLevel = this._petVO.maxAbilityPower;
            this._labelContainer.visible = true;
            _local2 = 0;
            for each (_local3 in _arg1.abilityList) {
                this._currentLevels.push(_local3.level);
                this._plusLabels[_local2].text = "";
                this._plusLabels[_local2].visible = false;
                this.renderAbility(_local3, _local2);
                _local2++;
            };
        }

        private function renderAbilitySimulation(_arg1:AbilityVO, _arg2:int):void{
            var _local3:PetFeedProgressBar;
            if (_arg1.getUnlocked()){
                _local3 = this.abilityBars[_arg2];
                _local3.maxLevel = this._maxLevel;
                _local3.simulatedValue = _arg1.points;
                if ((_arg1.level - this._currentLevels[_arg2]) > 0){
                    this._plusLabels[_arg2].text = ("+" + (_arg1.level - this._currentLevels[_arg2]));
                    this._plusLabels[_arg2].visible = true;
                }
                else {
                    this._plusLabels[_arg2].visible = false;
                };
            };
        }

        private function renderAbility(_arg1:AbilityVO, _arg2:int):void{
            var _local3:PetFeedProgressBar;
            var _local4:int = AbilitiesUtil.abilityPowerToMinPoints((_arg1.level + 1));
            if (this.abilityBars.length > _arg2){
                _local3 = this.abilityBars[_arg2];
                if (_arg1.getUnlocked()){
                    if (((!((_local3.maxValue == _local4))) || (!((_local3.value == _arg1.points))))){
                        this.updateProgressBarValues(_local3, _arg1, _local4);
                    };
                };
            }
            else {
                _local3 = new PetFeedProgressBar(195, 4, _arg1.name, _local4, ((_arg1.getUnlocked()) ? _arg1.points : 0), _arg1.level, this._maxLevel, 0x545454, 15306295, 6538829);
                _local3.showMaxLabel = true;
                _local3.maxColor = 6538829;
                DefaultLabelFormat.petStatLabelLeft(_local3.abilityLabel, 0xFFFFFF);
                DefaultLabelFormat.petStatLabelRight(_local3.levelLabel, 0xFFFFFF);
                DefaultLabelFormat.petStatLabelRight(_local3.maxLabel, 6538829, true);
                _local3.simulatedValueTextFormat = DefaultLabelFormat.createTextFormat(12, 6538829, TextFormatAlign.RIGHT, true);
                this.abilityBars.push(_local3);
                addGridElement(_local3);
            };
            if (!_arg1.getUnlocked()){
                _local3.alpha = 0.4;
            }
            else {
                if (_local3.alpha != 1){
                    _local3.maxValue = _local4;
                    _local3.value = _arg1.points;
                };
                _local3.alpha = 1;
            };
        }

        private function updateProgressBarValues(_arg1:PetFeedProgressBar, _arg2:AbilityVO, _arg3:int):void{
            _arg1.maxLevel = this._maxLevel;
            _arg1.currentLevel = _arg2.level;
            _arg1.maxValue = _arg3;
            _arg1.value = _arg2.points;
        }

        public function updateVO(_arg1:IPetVO):void{
            if (this._petVO != _arg1){
                this.abilityBars.length = 0;
                this._labelContainer.visible = false;
                clearGrid();
            };
            this._petVO = _arg1;
            if (this._petVO != null){
                this.refreshAbilities(_arg1);
            };
        }

        public function get petVO():IPetVO{
            return (this._petVO);
        }


    }
}//package io.decagames.rotmg.pets.components.petStatsGrid

