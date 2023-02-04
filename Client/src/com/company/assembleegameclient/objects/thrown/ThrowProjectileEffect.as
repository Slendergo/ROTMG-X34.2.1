﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.thrown.ThrowProjectileEffect

package com.company.assembleegameclient.objects.thrown{
    import com.company.assembleegameclient.objects.particles.ParticleEffect;
    import flash.geom.Point;

    public class ThrowProjectileEffect extends ParticleEffect {

        public var start_:Point;
        public var end_:Point;
        public var id_:uint;
        public var duration_:int;

        public function ThrowProjectileEffect(_arg1:int, _arg2:Point, _arg3:Point, _arg4:int=1500){
            this.start_ = _arg2;
            this.end_ = _arg3;
            this.id_ = _arg1;
            this.duration_ = _arg4;
        }

        override public function update(_arg1:int, _arg2:int):Boolean{
            x_ = this.start_.x;
            y_ = this.start_.y;
            var _local3 = 10000;
            var _local4:ThrownProjectile = new ThrownProjectile(this.id_, this.duration_, this.start_, this.end_);
            map_.addObj(_local4, x_, y_);
            return false;
        }


    }
}//package com.company.assembleegameclient.objects.thrown

