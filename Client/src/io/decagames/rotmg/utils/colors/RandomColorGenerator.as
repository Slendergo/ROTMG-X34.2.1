// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.utils.colors.RandomColorGenerator

package io.decagames.rotmg.utils.colors{
    import flash.utils.Dictionary;

    public class RandomColorGenerator {

        private var colorDictionary:Dictionary;
        private var seed:int = -1;

        public function RandomColorGenerator(_arg1:int=-1){
            this.seed = _arg1;
            this.colorDictionary = new Dictionary();
            this.loadColorBounds();
        }

        public function randomColor(_arg1:String=""):Array{
            var _local2:int = this.pickHue();
            var _local3:int = this.pickSaturation(_local2, _arg1);
            var _local4:int = this.pickBrightness(_local2, _local3, _arg1);
            var _local5:Array = this.HSVtoRGB([_local2, _local3, _local4]);
            return (_local5);
        }

        private function HSVtoRGB(_arg1:Array):Array{
            var _local2:Number = _arg1[0];
            if (_local2 === 0){
                _local2 = 1;
            }
            if (_local2 === 360){
                _local2 = 359;
            }
            _local2 = (_local2 / 360);
            var _local3:Number = (_arg1[1] / 100);
            var _local4:Number = (_arg1[2] / 100);
            var _local5:Number = Math.floor((_local2 * 6));
            var _local6:Number = ((_local2 * 6) - _local5);
            var _local7:Number = (_local4 * (1 - _local3));
            var _local8:Number = (_local4 * (1 - (_local6 * _local3)));
            var _local9:Number = (_local4 * (1 - ((1 - _local6) * _local3)));
            var _local10:Number = 0x0100;
            var _local11:Number = 0x0100;
            var _local12:Number = 0x0100;
            switch (_local5){
                case 0:
                    _local10 = _local4;
                    _local11 = _local9;
                    _local12 = _local7;
                    break;
                case 1:
                    _local10 = _local8;
                    _local11 = _local4;
                    _local12 = _local7;
                    break;
                case 2:
                    _local10 = _local7;
                    _local11 = _local4;
                    _local12 = _local9;
                    break;
                case 3:
                    _local10 = _local7;
                    _local11 = _local8;
                    _local12 = _local4;
                    break;
                case 4:
                    _local10 = _local9;
                    _local11 = _local7;
                    _local12 = _local4;
                    break;
                case 5:
                    _local10 = _local4;
                    _local11 = _local7;
                    _local12 = _local8;
                    break;
            }
            return ([Math.floor((_local10 * 0xFF)), Math.floor((_local11 * 0xFF)), Math.floor((_local12 * 0xFF))]);
        }

        private function pickSaturation(_arg1:int, _arg2:String):int{
            var _local3:Array = this.getSaturationRange(_arg1);
            var _local4:int = _local3[0];
            var _local5:int = _local3[1];
            switch (_arg2){
                case "bright":
                    _local4 = 55;
                    break;
                case "dark":
                    _local4 = (_local5 - 10);
                    break;
                case "light":
                    _local5 = 55;
                    break;
            }
            return (this.randomWithin([_local4, _local5]));
        }

        private function getColorInfo(_arg1:int):Object{
            var _local2:String;
            var _local3:Object;
            if ((((_arg1 >= 334)) && ((_arg1 <= 360)))){
                _arg1 = (_arg1 - 360);
            }
            for (_local2 in this.colorDictionary) {
                _local3 = this.colorDictionary[_local2];
                if (((((_local3.hueRange) && ((_arg1 >= _local3.hueRange[0])))) && ((_arg1 <= _local3.hueRange[1])))){
                    return (this.colorDictionary[_local2]);
                }
            }
            return (null);
        }

        private function getSaturationRange(_arg1:int):Array{
            return (this.getColorInfo(_arg1).saturationRange);
        }

        private function pickBrightness(_arg1:int, _arg2:int, _arg3:String):int{
            var _local4:int = this.getMinimumBrightness(_arg1, _arg2);
            var _local5:int = 100;
            switch (_arg3){
                case "dark":
                    _local5 = (_local4 + 20);
                    break;
                case "light":
                    _local4 = ((_local5 + _local4) / 2);
                    break;
                case "random":
                    _local4 = 0;
                    _local5 = 100;
                    break;
            }
            return (this.randomWithin([_local4, _local5]));
        }

        private function getMinimumBrightness(_arg1:int, _arg2:int):int{
            var _local5:int;
            var _local6:int;
            var _local7:int;
            var _local8:int;
            var _local9:Number;
            var _local10:Number;
            var _local3:Array = this.getColorInfo(_arg1).lowerBounds;
            var _local4:int;
            while (_local4 < (_local3.length - 1)) {
                _local5 = _local3[_local4][0];
                _local6 = _local3[_local4][1];
                _local7 = _local3[(_local4 + 1)][0];
                _local8 = _local3[(_local4 + 1)][1];
                if ((((_arg2 >= _local5)) && ((_arg2 <= _local7)))){
                    _local9 = ((_local8 - _local6) / (_local7 - _local5));
                    _local10 = (_local6 - (_local9 * _local5));
                    return (((_local9 * _arg2) + _local10));
                }
                _local4++;
            }
            return (0);
        }

        private function randomWithin(_arg1:Array):int{
            var _local2:Number;
            var _local3:Number;
            var _local4:Number;
            if (this.seed == -1){
                return (Math.floor((_arg1[0] + (Math.random() * ((_arg1[1] + 1) - _arg1[0])))));
            }
            _local2 = ((_arg1[1]) || (1));
            _local3 = ((_arg1[0]) || (0));
            this.seed = (((this.seed * 9301) + 49297) % 233280);
            _local4 = (this.seed / 233280);
            return (Math.floor((_local3 + (_local4 * (_local2 - _local3)))));
        }

        private function pickHue(_arg1:int=-1):int{
            var _local2:Array = this.getHueRange(_arg1);
            var _local3:int = this.randomWithin(_local2);
            if (_local3 < 0){
                _local3 = (360 + _local3);
            }
            return (_local3);
        }

        private function getHueRange(_arg1:int):Array{
            if ((((_arg1 < 360)) && ((_arg1 > 0)))){
                return ([_arg1, _arg1]);
            }
            return ([0, 360]);
        }

        private function defineColor(_arg1:String, _arg2:Array, _arg3:Array):void{
            var _local4:int = _arg3[0][0];
            var _local5:int = _arg3[(_arg3.length - 1)][0];
            var _local6:int = _arg3[(_arg3.length - 1)][1];
            var _local7:int = _arg3[0][1];
            this.colorDictionary[_arg1] = {
                hueRange:_arg2,
                lowerBounds:_arg3,
                saturationRange:[_local4, _local5],
                brightnessRange:[_local6, _local7]
            }
        }

        private function loadColorBounds():void{
            this.defineColor("monochrome", null, [[0, 0], [100, 0]]);
            this.defineColor("red", [-26, 18], [[20, 100], [30, 92], [40, 89], [50, 85], [60, 78], [70, 70], [80, 60], [90, 55], [100, 50]]);
            this.defineColor("orange", [19, 46], [[20, 100], [30, 93], [40, 88], [50, 86], [60, 85], [70, 70], [100, 70]]);
            this.defineColor("yellow", [47, 62], [[25, 100], [40, 94], [50, 89], [60, 86], [70, 84], [80, 82], [90, 80], [100, 75]]);
            this.defineColor("green", [63, 178], [[30, 100], [40, 90], [50, 85], [60, 81], [70, 74], [80, 64], [90, 50], [100, 40]]);
            this.defineColor("blue", [179, 0x0101], [[20, 100], [30, 86], [40, 80], [50, 74], [60, 60], [70, 52], [80, 44], [90, 39], [100, 35]]);
            this.defineColor("purple", [258, 282], [[20, 100], [30, 87], [40, 79], [50, 70], [60, 65], [70, 59], [80, 52], [90, 45], [100, 42]]);
            this.defineColor("pink", [283, 334], [[20, 100], [30, 90], [40, 86], [60, 84], [80, 80], [90, 75], [100, 73]]);
        }


    }
}//package io.decagames.rotmg.utils.colors

