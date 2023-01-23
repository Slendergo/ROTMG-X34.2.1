// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.AnimatedEffect

package com.company.assembleegameclient.objects.particles{
    import com.company.assembleegameclient.objects.thrown.BitmapParticle;
    import com.company.assembleegameclient.objects.GameObject;
    import flash.display.BitmapData;
    import kabam.lib.math.easing.Quad;

    public class AnimatedEffect extends BitmapParticle {

        public var go:GameObject;
        private var images:Vector.<BitmapData>;
        public var color1_:uint;
        public var color2_:uint;
        public var color3_:uint;
        private var percentDone:Number;
        private var startZ:Number;
        private var lifeTimeMS:int;
        private var delay:int;
        private var currentTime:int;

        public function AnimatedEffect(_arg1:Vector.<BitmapData>, _arg2:int, _arg3:int, _arg4:int){
            super(_arg1[0], _arg2);
            this.images = _arg1;
            this.delay = _arg3;
            this.currentTime = 0;
            this.percentDone = 0;
            z_ = _arg2;
            this.lifeTimeMS = _arg4;
        }

        override public function update(_arg1:int, _arg2:int):Boolean{
            var _local3:int;
            this.delay = (this.delay - _arg2);
            if (this.delay <= 0){
                this.percentDone = (this.currentTime / this.lifeTimeMS);
                _local3 = Math.min(Math.max(0, Math.floor((this.images.length * Quad.easeOut(this.percentDone)))), (this.images.length - 1));
                _bitmapData = this.images[_local3];
                this.currentTime = (this.currentTime + _arg2);
                return ((this.percentDone < 1));
            };
            return ((this.percentDone < 1));
        }


    }
}//package com.company.assembleegameclient.objects.particles

