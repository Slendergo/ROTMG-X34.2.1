// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGrid

package io.decagames.rotmg.pets.components.petStatsGrid{
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.pets.data.vo.IPetVO;
    import io.decagames.rotmg.ui.ProgressBar;
    import io.decagames.rotmg.pets.data.vo.AbilityVO;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;

    public class PetStatsGrid extends UIGrid {

        private var _petVO:IPetVO;
        private var abilityBars:Vector.<ProgressBar>;

        public function PetStatsGrid(_arg1:int, _arg2:IPetVO){
            super(_arg1, 1, 3);
            this.abilityBars = new Vector.<ProgressBar>();
            this._petVO = _arg2;
            if (_arg2){
                this.refreshAbilities(_arg2);
            }
        }

        public function renderSimulation(_arg1:Array):void{
            var _local3:AbilityVO;
            var _local2:int;
            for each (_local3 in _arg1) {
                this.renderAbilitySimulation(_local3, _local2);
                _local2++;
            }
        }

        private function refreshAbilities(_arg1:IPetVO):void{
            var _local3:AbilityVO;
            var _local2:int;
            for each (_local3 in _arg1.abilityList) {
                this.renderAbility(_local3, _local2);
                _local2++;
            }
        }

        private function renderAbilitySimulation(_arg1:AbilityVO, _arg2:int):void{
            if (_arg1.getUnlocked()){
                this.abilityBars[_arg2].simulatedValue = _arg1.level;
            }
        }

        private function renderAbility(_arg1:AbilityVO, _arg2:int):void{
            var _local3:ProgressBar;
            if (this.abilityBars.length > _arg2){
                _local3 = this.abilityBars[_arg2];
                if (((!((_local3.maxValue == this._petVO.maxAbilityPower))) && (_arg1.getUnlocked()))){
                    _local3.maxValue = this._petVO.maxAbilityPower;
                    _local3.value = _arg1.level;
                }
                if (((!((_local3.value == _arg1.level))) && (_arg1.getUnlocked()))){
                    _local3.dynamicLabelString = ((("Lvl. " + ProgressBar.DYNAMIC_LABEL_TOKEN) + "/") + ProgressBar.MAX_VALUE_TOKEN);
                    _local3.value = _arg1.level;
                }
            }
            else {
                _local3 = new ProgressBar(150, 4, _arg1.name, ((_arg1.getUnlocked()) ? ((("Lvl. " + ProgressBar.DYNAMIC_LABEL_TOKEN) + "/") + ProgressBar.MAX_VALUE_TOKEN) : ""), 0, this._petVO.maxAbilityPower, ((_arg1.getUnlocked()) ? _arg1.level : 0), 0x545454, 15306295, 6538829);
                _local3.showMaxLabel = true;
                _local3.maxColor = 6538829;
                DefaultLabelFormat.petStatLabelLeft(_local3.staticLabel, 0xFFFFFF);
                DefaultLabelFormat.petStatLabelRight(_local3.dynamicLabel, 0xFFFFFF);
                DefaultLabelFormat.petStatLabelRight(_local3.maxLabel, 6538829, true);
                _local3.simulatedValueTextFormat = DefaultLabelFormat.createTextFormat(12, 6538829, TextFormatAlign.RIGHT, true);
                this.abilityBars.push(_local3);
                addGridElement(_local3);
            }
            if (!_arg1.getUnlocked()){
                _local3.alpha = 0.4;
            }
            else {
                if (_local3.alpha != 1){
                    _local3.dynamicLabelString = ((("Lvl. " + ProgressBar.DYNAMIC_LABEL_TOKEN) + "/") + ProgressBar.MAX_VALUE_TOKEN);
                    _local3.maxValue = this._petVO.maxAbilityPower;
                    _local3.value = _arg1.level;
                }
                _local3.alpha = 1;
            }
        }

        public function updateVO(_arg1:IPetVO):void{
            if (this._petVO != _arg1){
                this.abilityBars = new Vector.<ProgressBar>();
                clearGrid();
            }
            this._petVO = _arg1;
            if (this._petVO != null){
                this.refreshAbilities(_arg1);
            }
        }

        public function get petVO():IPetVO{
            return (this._petVO);
        }


    }
}//package io.decagames.rotmg.pets.components.petStatsGrid

