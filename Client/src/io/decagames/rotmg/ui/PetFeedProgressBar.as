// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.PetFeedProgressBar

package io.decagames.rotmg.ui{
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Shape;
    import flash.text.TextFormat;
    import io.decagames.rotmg.pets.data.ability.AbilitiesUtil;
    import com.greensock.TweenMax;
    import com.gskinner.motion.easing.Linear;
    import com.greensock.easing.Expo;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class PetFeedProgressBar extends UIGridElement {

        private const MAX_COLOR:Number = 6538829;

        private var _componentWidth:int;
        private var _componentHeight:int;
        private var _abilityName:String;
        private var _maxValue:int;
        private var _currentValue:int;
        private var _currentLevel:int;
        private var _previousLevel:int;
        private var _maxLevel:int;
        private var _backgroundColor:uint;
        private var _progressBarColor:uint;
        private var _simulationColor:uint;
        private var _abilityLabel:UILabel;
        private var _levelLabel:UILabel;
        private var _maxLabel:UILabel;
        private var _backgroundShape:Shape;
        private var _progressShape:Shape;
        private var _simulationShape:Shape;
        private var _maxShape:Shape;
        private var _simulatedValue:int;
        private var _showMaxLabel:Boolean;
        private var _simulatedValueTextFormat:TextFormat;
        private var _useMaxColor:Boolean;
        private var _animateCurrentProgress:Boolean;
        private var _animateLevelProgress:Boolean;

        public function PetFeedProgressBar(_arg1:int, _arg2:int, _arg3:String, _arg4:int, _arg5:int, _arg6:int, _arg7:int, _arg8:uint, _arg9:uint, _arg10:uint=0){
            this._componentWidth = _arg1;
            this._componentHeight = _arg2;
            this._abilityName = _arg3;
            this._maxValue = _arg4;
            this._currentValue = _arg5;
            this._previousLevel = (this._currentLevel = _arg6);
            this._maxLevel = _arg7;
            this._backgroundColor = _arg8;
            this._progressBarColor = _arg9;
            this._simulationColor = _arg10;
            this.init();
        }

        private function init():void{
            this._abilityLabel = new UILabel();
            addChild(this._abilityLabel);
            this._abilityLabel.text = this._abilityName;
            this._maxLabel = new UILabel();
            this.createBarShapes();
            this.setLevelLabel(this._currentLevel);
        }

        private function createBarShapes():void{
            var _local1:int;
            _local1 = 16;
            this._backgroundShape = new Shape();
            this._backgroundShape.graphics.clear();
            this._backgroundShape.graphics.beginFill(this._backgroundColor, 1);
            this._backgroundShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
            this._backgroundShape.y = _local1;
            addChild(this._backgroundShape);
            this._simulationShape = new Shape();
            this._simulationShape.graphics.beginFill(this._simulationColor, 1);
            this._simulationShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
            this._simulationShape.scaleX = 0;
            this._simulationShape.y = _local1;
            this._simulationShape.visible = false;
            addChild(this._simulationShape);
            this._progressShape = new Shape();
            this._progressShape.graphics.beginFill(this._progressBarColor, 1);
            this._progressShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
            this._progressShape.scaleX = 0;
            this._progressShape.y = _local1;
            addChild(this._progressShape);
            this._maxShape = new Shape();
            this._maxShape.graphics.beginFill(this.MAX_COLOR, 1);
            this._maxShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
            this._maxShape.scaleX = 0;
            this._maxShape.y = _local1;
            this._maxShape.visible = false;
            addChild(this._maxShape);
        }

        public function set value(_arg1:int):void{
            if (!this._animateLevelProgress){
                this._animateCurrentProgress = true;
                this.render(this._currentValue, this._currentValue);
                this._currentValue = _arg1;
                this._simulatedValue = _arg1;
            }
        }

        public function set simulatedValue(_arg1:int):void{
            this._simulatedValue = _arg1;
            this.render(this._currentValue, this._simulatedValue);
        }

        override public function resize(_arg1:int, _arg2:int=-1):void{
            this._componentWidth = _arg1;
            this.render(this._currentValue, this._simulatedValue);
        }

        private function render(_arg1:int, _arg2:int):void{
            var _local7:int;
            var _local8:int;
            var _local9:int;
            var _local10:int;
            var _local11:int;
            var _local12:Number;
            this._maxShape.visible = false;
            this._simulationShape.visible = false;
            this._progressShape.visible = true;
            this._animateLevelProgress = (this._previousLevel < this._currentLevel);
            var _local3 = (_arg2 > _arg1);
            var _local4:int = (this._maxValue - AbilitiesUtil.abilityPowerToMinPoints(this._currentLevel));
            var _local5:int = (_arg1 - AbilitiesUtil.abilityPowerToMinPoints(this._currentLevel));
            var _local6:Number = (((this._currentLevel == this._maxLevel)) ? 1 : (_local5 / _local4));
            if (this._animateLevelProgress){
                this.setLevelLabel(this._previousLevel);
                this.animateToCurrentLevel();
            }
            else {
                this.drawProgress(_local6);
            }
            if (_local3){
                if (_arg2 >= this._maxValue){
                    _local9 = AbilitiesUtil.abilityPointsToLevel(_arg2);
                    if (_local9 >= this._maxLevel){
                        _local9 = this._maxLevel;
                        this.drawSimulatedProgress(this._componentWidth, this.MAX_COLOR);
                        this.setLevelLabel(_local9);
                    }
                    else {
                        _local10 = AbilitiesUtil.abilityPowerToMinPoints((_local9 + 1));
                        _local11 = AbilitiesUtil.abilityPowerToMinPoints(_local9);
                        _local8 = (_local10 - _local11);
                        _local7 = (_arg2 - _local11);
                        this.drawSimulatedProgress((_local7 / _local8));
                        this.setLevelLabel(_local9);
                    }
                }
                else {
                    _local7 = (_arg2 - AbilitiesUtil.abilityPowerToMinPoints(this._currentLevel));
                    _local12 = (_local7 / _local4);
                    this.drawSimulatedProgress(_local12, _local6);
                }
            }
            this._abilityLabel.x = -2;
        }

        private function animateToCurrentLevel():void{
            TweenMax.to(this._progressShape, 0.4, {
                scaleX:1,
                ease:Linear.easeNone,
                onComplete:this.onLevelUpComplete
            });
        }

        private function onLevelUpComplete():void{
            this.setLevelLabel(++this._previousLevel);
            if (this._previousLevel < this._currentLevel){
                this._progressShape.scaleX = 0;
                this.animateToCurrentLevel();
            }
            else {
                this._progressShape.scaleX = 0;
                this._animateCurrentProgress = true;
                this._animateLevelProgress = false;
                this.render(this._currentValue, this._currentValue);
            }
        }

        private function onLevelUpdateComplete():void{
            this._animateCurrentProgress = false;
            this.render(this._currentValue, this._currentValue);
        }

        private function drawProgress(_arg1:Number):void{
            if (_arg1 > 1){
                _arg1 = 1;
            }
            if (this._animateCurrentProgress){
                TweenMax.to(this._progressShape, 0.6, {
                    scaleX:_arg1,
                    ease:Expo.easeOut,
                    onComplete:this.onLevelUpdateComplete
                });
            }
            else {
                this._progressShape.scaleX = _arg1;
                this.setLevelLabel(this._currentLevel);
            }
        }

        private function drawSimulatedProgress(_arg1:Number, _arg2:Number=0):void{
            if (_arg2 == 0){
                this._progressShape.visible = false;
            }
            this._simulationShape.visible = true;
            this._simulationShape.scaleX = _arg1;
        }

        private function setLevelLabel(_arg1:int):void{
            if (this._levelLabel != null){
                removeChild(this._levelLabel);
            }
            this._levelLabel = new UILabel();
            addChild(this._levelLabel);
            if (_arg1 > this._currentLevel){
                DefaultLabelFormat.petStatLabelRight(this._levelLabel, 6538829);
            }
            else {
                DefaultLabelFormat.petStatLabelRight(this._levelLabel, 0xFFFFFF);
            }
            if (_arg1 < this._maxLevel){
                this._levelLabel.text = _arg1.toString();
            }
            else {
                this._levelLabel.text = "MAX";
                this._maxShape.scaleX = 1;
                this._maxShape.visible = true;
                this._simulationShape.visible = false;
                this._progressShape.visible = false;
            }
            this._levelLabel.x = ((this._componentWidth - this._levelLabel.width) + 2);
        }

        public function get abilityLabel():UILabel{
            return (this._abilityLabel);
        }

        public function get levelLabel():UILabel{
            return (this._levelLabel);
        }

        public function get value():int{
            return (this._currentValue);
        }

        public function get maxValue():int{
            return (this._maxValue);
        }

        public function set maxValue(_arg1:int):void{
            this._maxValue = _arg1;
        }

        public function set simulatedValueTextFormat(_arg1:TextFormat):void{
            this._simulatedValueTextFormat = _arg1;
        }

        public function set showMaxLabel(_arg1:Boolean):void{
            if (((_arg1) && (!(this._maxLabel.parent)))){
                addChild(this._maxLabel);
            }
            if (((!(_arg1)) && (this._maxLabel.parent))){
                removeChild(this._maxLabel);
            }
            this._showMaxLabel = _arg1;
        }

        public function get maxLabel():UILabel{
            return (this._maxLabel);
        }

        public function set maxColor(_arg1:uint):void{
            this._useMaxColor = true;
        }

        public function set currentLevel(_arg1:int):void{
            this._previousLevel = this._currentLevel;
            this._currentLevel = _arg1;
        }

        public function set maxLevel(_arg1:int):void{
            this._maxLevel = _arg1;
        }


    }
}//package io.decagames.rotmg.ui

