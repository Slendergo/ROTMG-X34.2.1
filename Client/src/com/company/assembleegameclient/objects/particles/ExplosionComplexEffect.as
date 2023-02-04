// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.ExplosionComplexEffect

package com.company.assembleegameclient.objects.particles{
    import com.company.assembleegameclient.objects.GameObject;

    public class ExplosionComplexEffect extends ParticleEffect {

        public var go_:GameObject;
        public var color_:uint;
        public var rise_:Number;
        public var minRad_:Number;
        public var maxRad_:Number;
        public var lastUpdate_:int = -1;
        public var amount_:int;
        public var maxLife_:int;
        public var speed_:Number;
        public var bInitialized_:Boolean = false;

        public function ExplosionComplexEffect(_arg1:GameObject, _arg2:EffectProperties){
            this.go_ = _arg1;
            this.color_ = _arg2.color;
            this.rise_ = _arg2.rise;
            this.minRad_ = _arg2.minRadius;
            this.maxRad_ = _arg2.maxRadius;
            this.amount_ = _arg2.amount;
            this.maxLife_ = (_arg2.life * 1000);
            size_ = _arg2.size;
        }

        private function run(_arg1:int, _arg2:int, _arg3:int):Boolean{
            var _local5:Number;
            var _local6:Number;
            var _local7:Number;
            var _local8:Number;
            var _local9:Number;
            var _local10:Number;
            var _local11:ExplosionComplexParticle;
            var _local4:int;
            while (_local4 < _arg3) {
                _local5 = ((Math.random() * Math.PI) * 2);
                _local6 = (this.minRad_ + (Math.random() * (this.maxRad_ - this.minRad_)));
                _local7 = ((_local6 * Math.cos(_local5)) / (0.008 * this.maxLife_));
                _local8 = ((_local6 * Math.sin(_local5)) / (0.008 * this.maxLife_));
                _local9 = (Math.random() * Math.PI);
                _local10 = 0;
                _local11 = new ExplosionComplexParticle(this.color_, 0.2, size_, this.maxLife_, _local7, _local8, _local10);
                map_.addObj(_local11, x_, y_);
                _local4++;
            };
            return false;
        }

        override public function runNormalRendering(_arg1:int, _arg2:int):Boolean{
            return (this.run(_arg1, _arg2, this.amount_));
        }

        override public function runEasyRendering(_arg1:int, _arg2:int):Boolean{
            return (this.run(_arg1, _arg2, (this.amount_ / 6)));
        }


    }
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.particles.Particle;
import flash.geom.Vector3D;

class ExplosionComplexParticle extends Particle {

    public static var total_:int = 0;

    public var lifetime_:int;
    public var timeLeft_:int;
    protected var moveVec_:Vector3D;
    private var deleted:Boolean = false;

    public function ExplosionComplexParticle(_arg1:uint, _arg2:Number, _arg3:int, _arg4:int, _arg5:Number, _arg6:Number, _arg7:Number){
        this.moveVec_ = new Vector3D();
        super(_arg1, _arg2, _arg3);
        this.timeLeft_ = (this.lifetime_ = _arg4);
        this.moveVec_.x = _arg5;
        this.moveVec_.y = _arg6;
        this.moveVec_.z = _arg7;
        total_++;
    }

    override public function update(_arg1:int, _arg2:int):Boolean{
        this.timeLeft_ = (this.timeLeft_ - _arg2);
        if (this.timeLeft_ <= 0){
            if (!this.deleted){
                total_--;
                this.deleted = true;
            };
            return false;
        };
        x_ = (x_ + ((this.moveVec_.x * _arg2) * 0.008));
        y_ = (y_ + ((this.moveVec_.y * _arg2) * 0.008));
        z_ = (z_ + ((this.moveVec_.z * _arg2) * 0.008));
        return true;
    }


}

