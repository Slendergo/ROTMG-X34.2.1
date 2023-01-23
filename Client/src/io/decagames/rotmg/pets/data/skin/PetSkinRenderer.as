// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.data.skin.PetSkinRenderer

package io.decagames.rotmg.pets.data.skin{
    import com.company.assembleegameclient.util.AnimatedChar;
    import com.company.assembleegameclient.util.MaskedImage;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.util.AnimatedChars;

    public class PetSkinRenderer {

        protected var _skinType:int;
        protected var skin:AnimatedChar;


        public function getSkinBitmap():Bitmap{
            this.makeSkin();
            if (this.skin == null){
                return (null);
            };
            var _local1:MaskedImage = this.skin.imageFromAngle(0, AnimatedChar.STAND, 0);
            var _local2:int = (((this.skin.getHeight() == 16)) ? 40 : 80);
            var _local3:BitmapData = TextureRedrawer.resize(_local1.image_, _local1.mask_, _local2, true, 0, 0);
            _local3 = GlowRedrawer.outlineGlow(_local3, 0);
            return (new Bitmap(_local3));
        }

        protected function makeSkin():void{
            var _local1:XML = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(this._skinType));
            if (_local1 == null){
                return;
            };
            var _local2:String = _local1.AnimatedTexture.File;
            var _local3:int = _local1.AnimatedTexture.Index;
            this.skin = AnimatedChars.getAnimatedChar(_local2, _local3);
        }

        public function getSkinMaskedImage():MaskedImage{
            this.makeSkin();
            return (((this.skin) ? this.skin.imageFromAngle(0, AnimatedChar.STAND, 0) : null));
        }


    }
}//package io.decagames.rotmg.pets.data.skin

