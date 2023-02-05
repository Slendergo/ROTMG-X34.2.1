// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.VortexEffect

package com.company.assembleegameclient.objects.particles{
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.assembleegameclient.util.FreeList;

    public class VortexEffect extends ParticleEffect {

        public var go_:GameObject;
        public var color_:uint;
        public var rad_:Number;
        public var lastUpdate_:int = -1;

        public function VortexEffect(_arg1:GameObject, _arg2:EffectProperties){
            this.go_ = _arg1;
            this.color_ = _arg2.color;
            this.color_ = _arg2.color;
            this.rad_ = _arg2.minRadius;
        }

        override public function update(_arg1:int, _arg2:int):Boolean{
            var _local4:int;
            var _local5:VortexParticle;
            var _local6:Number;
            var _local7:Number;
            var _local8:Number;
            if (this.go_.map_ == null){
                return false;
            }
            if (this.lastUpdate_ < 0){
                this.lastUpdate_ = Math.max(0, (_arg1 - 400));
            }
            x_ = this.go_.x_;
            y_ = this.go_.y_;
            var _local3:int = (this.lastUpdate_ / 50);
            while (_local3 < (_arg1 / 50)) {
                _local4 = (_local3 * 50);
                _local5 = (FreeList.newObject(VortexParticle) as VortexParticle);
                _local5.setColor(this.color_);
                _local6 = ((2 * Math.PI) * Math.random());
                _local7 = (Math.cos(_local6) * 6);
                _local8 = (Math.sin(_local6) * 6);
                map_.addObj(_local5, (x_ + _local7), (y_ + _local8));
                _local5.restart(_local4, _arg1, x_, y_);
                _local3++;
            }
            this.lastUpdate_ = _arg1;
            return true;
        }


    }
}//package com.company.assembleegameclient.objects.particles

import com.company.assembleegameclient.objects.particles.Particle;
import flash.geom.Vector3D;
import com.company.assembleegameclient.util.FreeList;

class VortexParticle extends Particle {

    private static const G:Number = 4;

    public var startTime_:int;
    protected var moveVec_:Vector3D;
    private var A:Number;
    private var mSize:Number;
    private var centerX_:Number;
    private var centerY_:Number;
    private var initAccelX:Number;
    private var initAccelY:Number;
    private var fSize:Number = 0;

    public function VortexParticle(_arg1:uint=0x270068){
        this.moveVec_ = new Vector3D();
        this.A = (2.5 + (0.5 * Math.random()));
        this.mSize = (3.5 + (2 * Math.random()));
        super(_arg1, 1, 0);
    }

    public function restart(_arg1:int, _arg2:int, _arg3:Number, _arg4:Number):void{
        this.centerX_ = _arg3;
        this.centerY_ = _arg4;
        var _local5:Number = ((Math.atan2((this.centerX_ - x_), (this.centerY_ - y_)) + (Math.PI / 2)) - (Math.PI / 6));
        this.initAccelX = (Math.sin(_local5) * this.A);
        this.initAccelY = (Math.cos(_local5) * this.A);
        z_ = 1;
        this.fSize = 0;
        size_ = this.fSize;
    }

    override public function removeFromMap():void{
        super.removeFromMap();
        FreeList.deleteObject(this);
    }

    override public function update(_arg1:int, _arg2:int):Boolean{
        var _local3:Number = Math.atan2((this.centerX_ - x_), (this.centerY_ - y_));
        var _local4:Number = 1;
        var _local5:Number = ((Math.sin(_local3) / _local4) * G);
        var _local6:Number = ((Math.cos(_local3) / _local4) * G);
        if (this.mSize > size_){
            this.fSize = (this.fSize + (_arg2 * 0.01));
        }
        size_ = this.fSize;
        moveTo((x_ + (((_local5 + this.initAccelX) * _arg2) * 0.0006)), (y_ + (((_local6 + this.initAccelY) * _arg2) * 0.0006)));
        z_ = (z_ + ((-0.5 * _arg2) * 0.0006));
        return ((z_ > 0));
    }


}

