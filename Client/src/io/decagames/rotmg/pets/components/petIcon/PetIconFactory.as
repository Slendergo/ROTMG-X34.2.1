// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petIcon.PetIconFactory

package io.decagames.rotmg.pets.components.petIcon{
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import io.decagames.rotmg.pets.data.vo.PetVO;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
    import io.decagames.rotmg.pets.data.vo.IPetVO;

    public class PetIconFactory {

        public var outlineSize:Number = 1.4;


        public function create(_arg1:PetVO, _arg2:int):PetIcon{
            var _local3:BitmapData = this.getPetSkinTexture(_arg1, _arg2);
            var _local4:Bitmap = new Bitmap(_local3);
            var _local5:PetIcon = new PetIcon(_arg1);
            _local5.setBitmap(_local4);
            return (_local5);
        }

        public function getPetSkinTexture(_arg1:IPetVO, _arg2:int, _arg3:uint=0):BitmapData{
            var _local5:Number;
            var _local6:BitmapData;
            var _local4:BitmapData = ((_arg1.getSkinMaskedImage()) ? _arg1.getSkinMaskedImage().image_ : null);
            if (_local4){
                _local5 = (5 * (16 / _local4.width));
                _local6 = TextureRedrawer.resize(_local4, _arg1.getSkinMaskedImage().mask_, _arg2, true, 0, 0, _local5);
                _local6 = GlowRedrawer.outlineGlow(_local6, _arg3, this.outlineSize);
                return (_local6);
            }
            return (new BitmapDataSpy(_arg2, _arg2));
        }


    }
}//package io.decagames.rotmg.pets.components.petIcon

