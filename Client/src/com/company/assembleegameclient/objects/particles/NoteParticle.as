// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.NoteParticle

package com.company.assembleegameclient.objects.particles{
    import com.company.assembleegameclient.objects.thrown.BitmapParticle;
    import com.company.assembleegameclient.objects.GameObject;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.geom.Point;
    import kabam.lib.math.easing.Expo;

    public class NoteParticle extends BitmapParticle {

        private var numFramesRemaining:int;
        private var dx_:Number;
        private var dy_:Number;
        private var originX:Number;
        private var originY:Number;
        private var radians:Number;
        private var frameUpdateModulator:uint = 0;
        private var currentFrame:uint = 0;
        private var numFrames:uint;
        private var go:GameObject;
        private var plusX:Number = 0;
        private var plusY:Number = 0;
        private var cameraAngle:Number;
        private var images:Vector.<BitmapData>;
        private var percentageDone:Number = 0;
        private var duration:int;

        public function NoteParticle(_arg1:uint, _arg2:int, _arg3:uint, _arg4:Point, _arg5:Point, _arg6:Number, _arg7:GameObject, _arg8:Vector.<BitmapData>){
            this.cameraAngle = Parameters.data_.cameraAngle;
            this.go = _arg7;
            this.radians = _arg6;
            this.images = _arg8;
            super(_arg8[0], 0);
            this.numFrames = _arg8.length;
            this.dx_ = (_arg5.x - _arg4.x);
            this.dy_ = (_arg5.y - _arg4.y);
            this.originX = (_arg4.x - _arg7.x_);
            this.originY = (_arg4.y - _arg7.y_);
            _rotation = (-(_arg6) - this.cameraAngle);
            this.duration = _arg2;
            this.numFramesRemaining = _arg2;
            var _local9:uint = Math.floor((Math.random() * _arg8.length));
            _bitmapData = _arg8[_local9];
        }

        override public function update(_arg1:int, _arg2:int):Boolean{
            this.numFramesRemaining--;
            if (this.numFramesRemaining <= 0){
                return false;
            };
            this.percentageDone = (1 - (this.numFramesRemaining / this.duration));
            this.plusX = (Expo.easeOut(this.percentageDone) * this.dx_);
            this.plusY = (Expo.easeOut(this.percentageDone) * this.dy_);
            if (Parameters.data_.cameraAngle != this.cameraAngle){
                this.cameraAngle = Parameters.data_.cameraAngle;
                _rotation = (-(this.radians) - this.cameraAngle);
            };
            moveTo(((this.go.x_ + this.originX) + this.plusX), ((this.go.y_ + this.originY) + this.plusY));
            return true;
        }


    }
}//package com.company.assembleegameclient.objects.particles

