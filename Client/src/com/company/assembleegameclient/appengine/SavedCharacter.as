// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.appengine.SavedCharacter

package com.company.assembleegameclient.appengine{
    import io.decagames.rotmg.pets.data.vo.PetVO;
    import kabam.rotmg.core.StaticInjectorContext;
    import io.decagames.rotmg.pets.data.PetsModel;
    import com.company.assembleegameclient.util.AnimatedChars;
    import com.company.assembleegameclient.util.AnimatedChar;
    import com.company.assembleegameclient.util.MaskedImage;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
    import com.company.util.CachingColorTransformer;
    import flash.geom.ColorTransform;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.objects.Player;
    import kabam.rotmg.constants.GeneralConstants;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.assets.services.CharacterFactory;
    import kabam.rotmg.classes.model.CharacterClass;
    import kabam.rotmg.classes.model.CharacterSkin;

    public class SavedCharacter {

        public var charXML_:XML;
        public var name_:String = null;
        private var pet:PetVO;

        public function SavedCharacter(_arg1:XML, _arg2:String){
            var _local3:XML;
            var _local4:int;
            var _local5:PetVO;
            super();
            this.charXML_ = _arg1;
            this.name_ = _arg2;
            if (this.charXML_.hasOwnProperty("Pet")){
                _local3 = new XML(this.charXML_.Pet);
                _local4 = _local3.@instanceId;
                _local5 = StaticInjectorContext.getInjector().getInstance(PetsModel).getPetVO(_local4);
                _local5.apply(_local3);
                this.setPetVO(_local5);
            }
        }

        public static function getImage(_arg1:SavedCharacter, _arg2:XML, _arg3:int, _arg4:int, _arg5:Number, _arg6:Boolean, _arg7:Boolean):BitmapData{
            var _local8:AnimatedChar = AnimatedChars.getAnimatedChar(String(_arg2.AnimatedTexture.File), int(_arg2.AnimatedTexture.Index));
            var _local9:MaskedImage = _local8.imageFromDir(_arg3, _arg4, _arg5);
            var _local10:int = (((_arg1)!=null) ? _arg1.tex1() : null);
            var _local11:int = (((_arg1)!=null) ? _arg1.tex2() : null);
            var _local12:BitmapData = TextureRedrawer.resize(_local9.image_, _local9.mask_, 100, false, _local10, _local11);
            _local12 = GlowRedrawer.outlineGlow(_local12, 0);
            if (!_arg6){
                _local12 = CachingColorTransformer.transformBitmapData(_local12, new ColorTransform(0, 0, 0, 0.5, 0, 0, 0, 0));
            }
            else {
                if (!_arg7){
                    _local12 = CachingColorTransformer.transformBitmapData(_local12, new ColorTransform(0.75, 0.75, 0.75, 1, 0, 0, 0, 0));
                }
            }
            return (_local12);
        }

        public static function compare(_arg1:SavedCharacter, _arg2:SavedCharacter):Number{
            var _local3:Number = ((Parameters.data_.charIdUseMap.hasOwnProperty(_arg1.charId())) ? Parameters.data_.charIdUseMap[_arg1.charId()] : 0);
            var _local4:Number = ((Parameters.data_.charIdUseMap.hasOwnProperty(_arg2.charId())) ? Parameters.data_.charIdUseMap[_arg2.charId()] : 0);
            if (_local3 != _local4){
                return ((_local4 - _local3));
            }
            return ((_arg2.xp() - _arg1.xp()));
        }


        public function charId():int{
            return (int(this.charXML_.@id));
        }

        public function fameBonus():int{
            var _local4:int;
            var _local5:XML;
            var _local1:Player = Player.fromPlayerXML("", this.charXML_);
            var _local2:int;
            var _local3:uint;
            while (_local3 < GeneralConstants.NUM_EQUIPMENT_SLOTS) {
                if (((_local1.equipment_) && ((_local1.equipment_.length > _local3)))){
                    _local4 = _local1.equipment_[_local3];
                    if (_local4 != -1){
                        _local5 = ObjectLibrary.xmlLibrary_[_local4];
                        if (((!((_local5 == null))) && (_local5.hasOwnProperty("FameBonus")))){
                            _local2 = (_local2 + int(_local5.FameBonus));
                        }
                    }
                }
                _local3++;
            }
            return (_local2);
        }

        public function name():String{
            return (this.name_);
        }

        public function objectType():int{
            return (int(this.charXML_.ObjectType));
        }

        public function skinType():int{
            return (int(this.charXML_.Texture));
        }

        public function level():int{
            return (int(this.charXML_.Level));
        }

        public function tex1():int{
            return (int(this.charXML_.Tex1));
        }

        public function tex2():int{
            return (int(this.charXML_.Tex2));
        }

        public function xp():int{
            return (int(this.charXML_.Exp));
        }

        public function fame():int{
            return (int(this.charXML_.CurrentFame));
        }

        public function hp():int{
            return (int(this.charXML_.MaxHitPoints));
        }

        public function mp():int{
            return (int(this.charXML_.MaxMagicPoints));
        }

        public function att():int{
            return (int(this.charXML_.Attack));
        }

        public function def():int{
            return (int(this.charXML_.Defense));
        }

        public function spd():int{
            return (int(this.charXML_.Speed));
        }

        public function dex():int{
            return (int(this.charXML_.Dexterity));
        }

        public function vit():int{
            return (int(this.charXML_.HpRegen));
        }

        public function wis():int{
            return (int(this.charXML_.MpRegen));
        }

        public function displayId():String{
            return (ObjectLibrary.typeToDisplayId_[this.objectType()]);
        }

        public function getIcon(_arg1:int=100):BitmapData{
            var _local2:Injector = StaticInjectorContext.getInjector();
            var _local3:ClassesModel = _local2.getInstance(ClassesModel);
            var _local4:CharacterFactory = _local2.getInstance(CharacterFactory);
            var _local5:CharacterClass = _local3.getCharacterClass(this.objectType());
            var _local6:CharacterSkin = ((_local5.skins.getSkin(this.skinType())) || (_local5.skins.getDefaultSkin()));
            var _local7:BitmapData = _local4.makeIcon(_local6.template, _arg1, this.tex1(), this.tex2());
            return (_local7);
        }

        public function bornOn():String{
            if (!this.charXML_.hasOwnProperty("CreationDate")){
                return ("Unknown");
            }
            return (this.charXML_.CreationDate);
        }

        public function getPetVO():PetVO{
            return (this.pet);
        }

        public function setPetVO(_arg1:PetVO):void{
            this.pet = _arg1;
        }
    }
}//package com.company.assembleegameclient.appengine

