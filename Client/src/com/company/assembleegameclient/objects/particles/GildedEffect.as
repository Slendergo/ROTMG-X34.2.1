// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.GildedEffect

package com.company.assembleegameclient.objects.particles{
    import com.company.assembleegameclient.objects.GameObject;

    public class GildedEffect extends ParticleEffect {

        public var go_:GameObject;
        public var color1_:uint;
        public var color2_:uint;
        public var color3_:uint;
        public var rad_:Number;
        public var duration_:int;
        private var numArm:int = 3;
        private var partPerArm:int = 10;
        public var delayBetweenParticles:Number = 150;
        public var particlesOffset:Number = 0;
        private var healEffectDelay:int;
        private var lastUpdate:int;
        private var healUpdate:int;
        private var runs:int;

        public function GildedEffect(_arg1:GameObject, _arg2:uint, _arg3:uint, _arg4:uint, _arg5:Number, _arg6:int){
            this.go_ = _arg1;
            this.color1_ = _arg2;
            this.color2_ = _arg3;
            this.color3_ = _arg4;
            this.rad_ = _arg5;
            this.duration_ = _arg6;
            x_ = this.go_.x_;
            y_ = this.go_.y_;
            this.particlesOffset = 0;
            this.healEffectDelay = this.duration_;
            this.lastUpdate = 0;
            this.runs = 0;
        }

        override public function update(_arg1:int, _arg2:int):Boolean{
            if ((_arg1 - this.lastUpdate) > this.delayBetweenParticles){
                if (this.runs < this.partPerArm){
                    this.addParticles();
                    this.lastUpdate = _arg1;
                    this.runs++;
                    if (this.runs >= this.numArm){
                        this.healUpdate = _arg1;
                    };
                };
            };
            if (this.healUpdate != 0){
                if ((_arg1 - this.healUpdate) > this.healEffectDelay){
                    this.go_.map_.addObj(new HealEffect(this.go_, this.color3_, this.color1_), this.go_.x_, this.go_.y_);
                    return false;
                };
            };
            x_ = this.go_.x_;
            y_ = this.go_.y_;
            return true;
        }

        private function addParticles():void{
            var _local2:Number;
            var _local3:Number;
            var _local4:Number;
            var _local5:GildedParticle;
            if (!map_){
                return;
            };
            this.particlesOffset = (this.particlesOffset - 0.01618);
            this.healEffectDelay = (this.healEffectDelay - this.delayBetweenParticles);
            var _local1:int;
            while (_local1 < this.numArm) {
                _local2 = ((_local1 / this.numArm) - this.particlesOffset);
                _local3 = (Math.cos(_local2) * this.rad_);
                _local4 = (Math.sin(_local2) * this.rad_);
                _local5 = new GildedParticle(this.go_, _local3, _local4, _local2, this.rad_, this.healEffectDelay, this.color1_, this.color2_, this.color3_);
                map_.addObj(_local5, (x_ + _local3), (y_ + _local4));
                _local1++;
            };
        }


    }
}//package com.company.assembleegameclient.objects.particles

