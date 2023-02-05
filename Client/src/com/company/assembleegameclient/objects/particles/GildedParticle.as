// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.GildedParticle

package com.company.assembleegameclient.objects.particles{
    import com.company.assembleegameclient.objects.GameObject;
    import kabam.lib.math.easing.Quad;
    import com.company.util.MoreColorUtil;

    public class GildedParticle extends Particle {

        private var mSize:Number;
        private var fSize:Number = 0;
        private var go:GameObject;
        private var currentLife:int;
        private var lifetimeMS:int = 2500;
        private var radius:Number;
        private var armOffset:Number = 0;
        public var color1_:uint;
        public var color2_:uint;
        public var color3_:uint;

        public function GildedParticle(_arg1:GameObject, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:int, _arg7:uint=0x270068, _arg8:uint=0x270068, _arg9:uint=0x270068){
            this.mSize = (3.5 + (2 * Math.random()));
            super(_arg7, 1, 0);
            this.lifetimeMS = _arg6;
            this.radius = _arg5;
            this.color1_ = _arg7;
            this.color2_ = _arg8;
            this.color3_ = _arg9;
            z_ = 0;
            this.fSize = 0;
            size_ = this.fSize;
            this.currentLife = 0;
            this.armOffset = _arg4;
            this.go = _arg1;
        }

        override public function update(_arg1:int, _arg2:int):Boolean{
            var _local3:Number = (this.currentLife / this.lifetimeMS);
            if (this.mSize > size_){
                this.fSize = (this.fSize + (_arg2 * 0.01));
            }
            size_ = this.fSize;
            var _local4:Number = Quad.easeOut(_local3);
            var _local5:Number = ((2 * Math.PI) * (_local4 + this.armOffset));
            var _local6:Number = (this.radius * (1 - _local4));
            var _local7:Number = (_local6 * Math.cos(_local5));
            var _local8:Number = (_local6 * Math.sin(_local5));
            moveTo((this.go.x_ + _local7), (this.go.y_ + _local8));
            if (_local3 < 0.33){
                setColor(MoreColorUtil.lerpColor(this.color3_, this.color2_, this.normalizedRange(_local3, 0, 0.33)));
            }
            else {
                if (_local3 > 0.5){
                    setColor(MoreColorUtil.lerpColor(this.color2_, this.color1_, this.normalizedRange(_local3, 0.5, 1)));
                }
            }
            this.currentLife = (this.currentLife + _arg2);
            return ((_local3 < 1));
        }

        public function normalizedRange(_arg1:Number, _arg2:Number, _arg3:Number):Number{
            var _local4:Number = ((_arg1 - _arg2) / (_arg3 - _arg2));
            if (_local4 < 0){
                _local4 = 0;
            }
            else {
                if (_local4 > 1){
                    _local4 = 1;
                }
            }
            return (_local4);
        }


    }
}//package com.company.assembleegameclient.objects.particles

