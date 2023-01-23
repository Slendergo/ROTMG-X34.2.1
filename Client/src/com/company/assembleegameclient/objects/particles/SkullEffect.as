// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.SkullEffect

package com.company.assembleegameclient.objects.particles{
    import com.company.assembleegameclient.objects.thrown.BitmapParticle;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import kabam.lib.math.easing.Quart;

    public class SkullEffect extends BitmapParticle {

        public var target_:Point;
        private var images:Vector.<BitmapData>;
        private var percentDone:Number;
        private var lifeTimeMS:int = 1000;
        private var currentTime:int;

        public function SkullEffect(_arg1:Point, _arg2:Vector.<BitmapData>){
            super(_arg2[0], 0);
            this.target_ = _arg1;
            this.images = _arg2;
            this.currentTime = 0;
            this.percentDone = 0;
            z_ = 0.3;
            x_ = this.target_.x;
            y_ = this.target_.y;
        }

        override public function update(_arg1:int, _arg2:int):Boolean{
            this.percentDone = (this.currentTime / this.lifeTimeMS);
            var _local3:int = Math.min(Math.max(0, Math.floor((this.images.length * this.percentDone))), (this.images.length - 1));
            _bitmapData = this.images[_local3];
            z_ = (1.618 * Quart.easeOut(this.percentDone));
            this.currentTime = (this.currentTime + _arg2);
            return ((this.percentDone < 1));
        }


    }
}//package com.company.assembleegameclient.objects.particles

