// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.HealParticle

package com.company.assembleegameclient.objects.particles{
    import com.company.assembleegameclient.objects.GameObject;
    import flash.geom.Vector3D;
    import com.company.util.MoreColorUtil;

    public class HealParticle extends Particle {

        public var duration_:int;
        private var percentDone:Number;
        private var currentLife:int;
        public var go_:GameObject;
        public var angle_:Number;
        public var dist_:Number;
        protected var moveVec_:Vector3D;
        public var color1_:uint;
        public var color2_:uint;

        public function HealParticle(_arg1:uint, _arg2:Number, _arg3:int, _arg4:int, _arg5:Number, _arg6:GameObject, _arg7:Number, _arg8:Number, _arg9:uint){
            this.moveVec_ = new Vector3D();
            super(_arg1, _arg2, _arg3);
            this.color1_ = _arg1;
            this.color2_ = _arg9;
            this.moveVec_.z = _arg5;
            this.duration_ = _arg4;
            this.go_ = _arg6;
            this.angle_ = _arg7;
            this.dist_ = _arg8;
        }

        override public function update(_arg1:int, _arg2:int):Boolean{
            this.percentDone = (this.currentLife / this.duration_);
            setColor(MoreColorUtil.lerpColor(this.color2_, this.color1_, this.percentDone));
            x_ = (this.go_.x_ + (this.dist_ * Math.cos(this.angle_)));
            y_ = (this.go_.y_ + (this.dist_ * Math.sin(this.angle_)));
            z_ = (z_ + ((this.moveVec_.z * _arg2) * 0.008));
            this.currentLife = (this.currentLife + _arg2);
            return ((this.percentDone < 1));
        }


    }
}//package com.company.assembleegameclient.objects.particles

