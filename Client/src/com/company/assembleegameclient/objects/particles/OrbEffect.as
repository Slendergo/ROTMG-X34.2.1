// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.OrbEffect

package com.company.assembleegameclient.objects.particles{
    import flash.display.BitmapData;
    import com.company.assembleegameclient.objects.GameObject;
    import flash.geom.Point;
    import com.company.util.MoreColorUtil;
    import flash.geom.ColorTransform;
    import com.company.util.AssetLibrary;
    import com.company.util.ImageSet;
    import com.company.assembleegameclient.util.TextureRedrawer;

    public class OrbEffect extends ParticleEffect {

        public static var images:Vector.<BitmapData>;

        public var go_:GameObject;
        public var color1_:uint;
        public var color2_:uint;
        public var color3_:uint;
        public var duration_:int;
        public var rad_:Number;
        public var target_:Point;

        public function OrbEffect(_arg1:GameObject, _arg2:uint, _arg3:uint, _arg4:uint, _arg5:Number, _arg6:int, _arg7:Point){
            this.go_ = _arg1;
            this.color1_ = _arg2;
            this.color2_ = _arg3;
            this.color3_ = _arg4;
            this.rad_ = _arg5;
            this.duration_ = _arg6;
            this.target_ = _arg7;
        }

        public static function initialize():void{
            images = parseBitmapDataFromImageSet("lofiParticlesSkull");
        }

        private static function apply(_arg1:BitmapData, _arg2:uint):BitmapData{
            var _local3:ColorTransform = MoreColorUtil.veryGreenCT;
            _local3.color = _arg2;
            var _local4:BitmapData = _arg1.clone();
            _local4.colorTransform(_local4.rect, _local3);
            return (_local4);
        }

        private static function parseBitmapDataFromImageSet(_arg1:String):Vector.<BitmapData>{
            var _local4:uint;
            var _local6:BitmapData;
            var _local2:Vector.<BitmapData> = new Vector.<BitmapData>();
            var _local3:ImageSet = AssetLibrary.getImageSet(_arg1);
            var _local5:uint = _local3.images_.length;
            _local4 = 0;
            while (_local4 < _local5) {
                _local6 = TextureRedrawer.redraw(_local3.images_[_local4], 120, true, 11673446, true, 5, 11673446, 1.4);
                if (_local4 == 8){
                    _local6 = apply(_local6, 11673446);
                }
                else {
                    _local6 = apply(_local6, 3675232);
                };
                _local2.push(_local6);
                _local4++;
            };
            return (_local2);
        }


        override public function update(_arg1:int, _arg2:int):Boolean{
            x_ = this.target_.x;
            y_ = this.target_.y;
            map_.addObj(new SkullEffect(this.target_, images), this.target_.x, this.target_.y);
            return (false);
        }


    }
}//package com.company.assembleegameclient.objects.particles

