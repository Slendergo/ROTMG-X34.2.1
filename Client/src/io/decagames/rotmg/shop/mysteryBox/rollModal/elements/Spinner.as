// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.mysteryBox.rollModal.elements.Spinner

package io.decagames.rotmg.shop.mysteryBox.rollModal.elements{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import kabam.rotmg.assets.EmbeddedAssets;
    import flash.events.Event;
    import io.decagames.rotmg.utils.colors.Tint;
    import io.decagames.rotmg.utils.colors.RGB;
    import io.decagames.rotmg.utils.colors.RandomColorGenerator;
    import flash.utils.getTimer;

    public class Spinner extends Sprite {

        public const graphic:DisplayObject = new EmbeddedAssets.StarburstSpinner();

        private var _degreesPerSecond:int;
        private var secondsElapsed:Number;
        private var previousSeconds:Number;
        private var startColor:uint;
        private var endColor:uint;
        private var direction:Boolean;
        private var previousProgress:Number = 0;
        private var multicolor:Boolean;
        private var rStart:Number = -1;
        private var gStart:Number = -1;
        private var bStart:Number = -1;
        private var rFinal:Number = -1;
        private var gFinal:Number = -1;
        private var bFinal:Number = -1;

        public function Spinner(_arg1:int, _arg2:Boolean=false){
            this._degreesPerSecond = _arg1;
            this.multicolor = _arg2;
            this.secondsElapsed = 0;
            this.setupStartAndFinalColors();
            this.addGraphic();
            this.applyColor(0);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
        }

        private function addGraphic():void{
            addChild(this.graphic);
            this.graphic.x = ((-1 * width) / 2);
            this.graphic.y = ((-1 * height) / 2);
        }

        private function onRemoved(_arg1:Event):void{
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        public function pause():void{
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.previousSeconds = 0;
        }

        public function resume():void{
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onEnterFrame(_arg1:Event):void{
            this.updateTimeElapsed();
            var _local2:Number = ((this._degreesPerSecond * this.secondsElapsed) % 360);
            rotation = _local2;
            this.applyColor((_local2 / 360));
        }

        private function applyColor(_arg1:Number):void{
            if (!this.multicolor){
                return;
            }
            if (_arg1 < this.previousProgress){
                this.direction = !(this.direction);
            }
            this.previousProgress = _arg1;
            if (this.direction){
                _arg1 = (1 - _arg1);
            }
            var _local2:uint = this.getColorByProgress(_arg1);
            Tint.add(this.graphic, _local2, 1);
        }

        private function getColorByProgress(_arg1:Number):uint{
            var _local2:Number = (this.rStart + ((this.rFinal - this.rStart) * _arg1));
            var _local3:Number = (this.gStart + ((this.gFinal - this.gStart) * _arg1));
            var _local4:Number = (this.bStart + ((this.bFinal - this.bStart) * _arg1));
            return (RGB.fromRGB(_local2, _local3, _local4));
        }

        private function setupStartAndFinalColors():void{
            var _local1:RandomColorGenerator = new RandomColorGenerator();
            var _local2:Array = _local1.randomColor();
            var _local3:Array = _local1.randomColor();
            this.rStart = _local2[0];
            this.gStart = _local2[1];
            this.bStart = _local2[2];
            this.rFinal = _local3[0];
            this.gFinal = _local3[1];
            this.bFinal = _local3[2];
        }

        private function updateTimeElapsed():void{
            var _local1:Number = (getTimer() / 1000);
            if (this.previousSeconds){
                this.secondsElapsed = (this.secondsElapsed + (_local1 - this.previousSeconds));
            }
            this.previousSeconds = _local1;
        }

        public function get degreesPerSecond():int{
            return (this._degreesPerSecond);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.rollModal.elements

