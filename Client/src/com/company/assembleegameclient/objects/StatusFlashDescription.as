// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.StatusFlashDescription

package com.company.assembleegameclient.objects{
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import kabam.rotmg.stage3D.GraphicsFillExtra;

    public class StatusFlashDescription {

        public var startTime_:int;
        public var color_:uint;
        public var periodMS_:int;
        public var repeats_:int;
        public var duration_:int;
        public var percentDone:Number;
        public var curTime:Number;
        public var targetR:int;
        public var targetG:int;
        public var targetB:int;

        public function StatusFlashDescription(_arg1:int, _arg2:uint, _arg3:int){
            this.startTime_ = _arg1;
            this.color_ = _arg2;
            this.duration_ = (_arg3 * 1000);
            this.targetR = ((_arg2 >> 16) & 0xFF);
            this.targetG = ((_arg2 >> 8) & 0xFF);
            this.targetB = (_arg2 & 0xFF);
            this.curTime = 0;
        }

        public function apply(_arg1:BitmapData, _arg2:int):BitmapData{
            var _local3:BitmapData = _arg1.clone();
            var _local4:int = ((_arg2 - this.startTime_) % this.duration_);
            var _local5:Number = Math.abs(Math.sin((((_local4 / this.duration_) * Math.PI) * (this.percentDone * 10))));
            var _local6:Number = (_local5 * 0.5);
            var _local7:ColorTransform = new ColorTransform((1 - _local6), (1 - _local6), (1 - _local6), 1, (_local6 * this.targetR), (_local6 * this.targetG), (_local6 * this.targetB), 0);
            _local3.colorTransform(_local3.rect, _local7);
            return (_local3);
        }

        public function applyGPUTextureColorTransform(_arg1:BitmapData, _arg2:int):void{
            var _local3:int = ((_arg2 - this.startTime_) % this.duration_);
            var _local4:Number = Math.abs(Math.sin((((_local3 / this.duration_) * Math.PI) * (this.percentDone * 10))));
            var _local5:Number = (_local4 * 0.5);
            var _local6:ColorTransform = new ColorTransform((1 - _local5), (1 - _local5), (1 - _local5), 1, (_local5 * this.targetR), (_local5 * this.targetG), (_local5 * this.targetB), 0);
            GraphicsFillExtra.setColorTransform(_arg1, _local6);
        }

        public function doneAt(_arg1:int):Boolean{
            this.percentDone = (this.curTime / this.duration_);
            this.curTime = (_arg1 - this.startTime_);
            return ((this.percentDone > 1));
        }


    }
}//package com.company.assembleegameclient.objects

