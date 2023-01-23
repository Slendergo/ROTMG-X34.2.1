// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.ThunderEffect

package com.company.assembleegameclient.objects.particles{
    import flash.display.BitmapData;
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.util.MoreColorUtil;
    import flash.geom.ColorTransform;
    import com.company.util.AssetLibrary;
    import com.company.util.ImageSet;
    import com.company.assembleegameclient.util.TextureRedrawer;

    public class ThunderEffect extends ParticleEffect {

        private static var impactImages:Vector.<BitmapData>;
        private static var beamImages:Vector.<BitmapData>;

        public var go_:GameObject;

        public function ThunderEffect(_arg1:GameObject){
            this.go_ = _arg1;
            x_ = this.go_.x_;
            y_ = this.go_.y_;
        }

        public static function initialize():void{
            beamImages = parseBitmapDataFromImageSet(6, "lofiParticlesBeam", 16768115);
            impactImages = prepareThunderImpactImages(parseBitmapDataFromImageSet(13, "lofiParticlesElectric"));
        }

        private static function prepareThunderImpactImages(_arg1:Vector.<BitmapData>):Vector.<BitmapData>{
            var _local2:int = _arg1.length;
            var _local3:int;
            while (_local3 < _local2) {
                if (_local3 == 8){
                    _arg1[_local3] = applyColorTransform(_arg1[_local3], 16768115);
                }
                else {
                    if (_local3 == 7){
                        _arg1[_local3] = applyColorTransform(_arg1[_local3], 0xFFFFFF);
                    }
                    else {
                        _arg1[_local3] = applyColorTransform(_arg1[_local3], 0xFF9A00);
                    };
                };
                _local3++;
            };
            return (_arg1);
        }

        private static function applyColorTransform(_arg1:BitmapData, _arg2:uint):BitmapData{
            var _local3:ColorTransform = MoreColorUtil.veryGreenCT;
            _local3.color = _arg2;
            var _local4:BitmapData = _arg1.clone();
            _local4.colorTransform(_local4.rect, _local3);
            return (_local4);
        }

        private static function parseBitmapDataFromImageSet(_arg1:uint, _arg2:String, _arg3:uint=0):Vector.<BitmapData>{
            var _local6:uint;
            var _local8:BitmapData;
            var _local4:Vector.<BitmapData> = new Vector.<BitmapData>();
            var _local5:ImageSet = AssetLibrary.getImageSet(_arg2);
            var _local7:uint = _arg1;
            _local6 = 0;
            while (_local6 < _local7) {
                _local8 = TextureRedrawer.redraw(_local5.images_[_local6], 120, true, 16768115, true, 5, 16768115, 1.4);
                if (_arg3 != 0){
                    _local8 = applyColorTransform(_local8, _arg3);
                };
                _local4.push(_local8);
                _local6++;
            };
            return (_local4);
        }


        override public function update(_arg1:int, _arg2:int):Boolean{
            x_ = this.go_.x_;
            y_ = this.go_.y_;
            this.runEffect();
            return (false);
        }

        private function runEffect():void{
            map_.addObj(new AnimatedEffect(beamImages, 2, 0, 240), x_, y_);
            map_.addObj(new AnimatedEffect(impactImages, 0, 80, 360), x_, y_);
        }


    }
}//package com.company.assembleegameclient.objects.particles

