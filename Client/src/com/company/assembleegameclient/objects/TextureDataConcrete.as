// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.TextureDataConcrete

package com.company.assembleegameclient.objects{
    import flash.display.BitmapData;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.application.api.ApplicationSetup;
    import com.company.assembleegameclient.util.MaskedImage;
    import com.company.assembleegameclient.appengine.RemoteTexture;
    import com.company.util.AssetLibrary;
    import com.company.assembleegameclient.objects.particles.EffectProperties;
    import com.company.assembleegameclient.util.AnimatedChars;
    import com.company.assembleegameclient.util.AnimatedChar;
    import com.company.assembleegameclient.util.AssetLoader;
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.appengine.*;

    public class TextureDataConcrete extends TextureData {

        public static var remoteTexturesUsed:Boolean = false;

        private var isUsingLocalTextures:Boolean;

        public function TextureDataConcrete(_arg1:XML){
            var _local2:XML;
            super();
            this.isUsingLocalTextures = this.getWhetherToUseLocalTextures();
            if (_arg1.hasOwnProperty("Texture")){
                this.parse(XML(_arg1.Texture), String(_arg1.@id));
            }
            else {
                if (_arg1.hasOwnProperty("AnimatedTexture")){
                    this.parse(XML(_arg1.AnimatedTexture), String(_arg1.@id));
                }
                else {
                    if (_arg1.hasOwnProperty("RemoteTexture")){
                        this.parse(XML(_arg1.RemoteTexture));
                    }
                    else {
                        if (_arg1.hasOwnProperty("RandomTexture")){
                            this.parse(XML(_arg1.RandomTexture), String(_arg1.@id));
                        }
                        else {
                            this.parse(_arg1);
                        }
                    }
                }
            }
            for each (_local2 in _arg1.AltTexture) {
                this.parse(_local2);
            }
            if (_arg1.hasOwnProperty("Mask")){
                this.parse(XML(_arg1.Mask));
            }
            if (_arg1.hasOwnProperty("Effect")){
                this.parse(XML(_arg1.Effect));
            }
        }

        override public function getTexture(_arg1:int=0):BitmapData{
            if (randomTextureData_ == null){
                return (texture_);
            }
            var _local2:TextureData = randomTextureData_[(_arg1 % randomTextureData_.length)];
            return (_local2.getTexture(_arg1));
        }

        override public function getAltTextureData(_arg1:int):TextureData{
            if (altTextures_ == null){
                return (null);
            }
            return (altTextures_[_arg1]);
        }

        private function getWhetherToUseLocalTextures():Boolean{
            var _local1:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
            return (_local1.useLocalTextures());
        }

        private function parse(_arg1:XML, _arg2:String=""):void{
            var image:MaskedImage;
            var remoteTexture:RemoteTexture;
            var childXML:XML;
            var xml:XML = _arg1;
            var id:String = _arg2;
            switch (xml.name().toString()){
                case "Texture":
                    try {
                        texture_ = AssetLibrary.getImageFromSet(String(xml.File), int(xml.Index));
                    }
                    catch(error:Error) {
                        throw (new Error(((((("Error loading Texture for " + id) + " - name: ") + String(xml.File)) + " - idx: ") + int(xml.Index))));
                    }
                    return;
                case "Mask":
                    mask_ = AssetLibrary.getImageFromSet(String(xml.File), int(xml.Index));
                    return;
                case "Effect":
                    effectProps_ = new EffectProperties(xml);
                    return;
                case "AnimatedTexture":
                    animatedChar_ = AnimatedChars.getAnimatedChar(String(xml.File), int(xml.Index));
                    try {
                        image = animatedChar_.imageFromAngle(0, AnimatedChar.STAND, 0);
                        texture_ = image.image_;
                        mask_ = image.mask_;
                    }
                    catch(error:Error) {
                        throw (new Error(((((("Error loading AnimatedTexture for " + id) + " - name: ") + String(xml.File)) + " - idx: ") + int(xml.Index))));
                    }
                    return;
                case "RemoteTexture":
                    texture_ = AssetLibrary.getImageFromSet("lofiObj3", 0xFF);
                    if (this.isUsingLocalTextures){
                        remoteTexture = new RemoteTexture(xml.Id, xml.Instance, this.onRemoteTexture);
                        remoteTexture.run();
                        if (!AssetLoader.currentXmlIsTesting){
                            remoteTexturesUsed = true;
                        }
                    }
                    remoteTextureDir_ = ((xml.hasOwnProperty("Right")) ? AnimatedChar.RIGHT : AnimatedChar.DOWN);
                    return;
                case "RandomTexture":
                    try {
                        randomTextureData_ = new Vector.<TextureData>();
                        for each (childXML in xml.children()) {
                            randomTextureData_.push(new TextureDataConcrete(childXML));
                        }
                    }
                    catch(error:Error) {
                        throw (new Error(("Error loading RandomTexture for " + id)));
                    }
                    return;
                case "AltTexture":
                    if (altTextures_ == null){
                        altTextures_ = new Dictionary();
                    }
                    altTextures_[int(xml.@id)] = new TextureDataConcrete(xml);
                    return;
            }
        }

        private function onRemoteTexture(_arg1:BitmapData):void{
            if (_arg1){
                if (_arg1.width > 16){
                    AnimatedChars.add("remoteTexture", _arg1, null, (_arg1.width / 7), _arg1.height, _arg1.width, _arg1.height, remoteTextureDir_);
                    animatedChar_ = AnimatedChars.getAnimatedChar("remoteTexture", 0);
                    texture_ = animatedChar_.imageFromAngle(0, AnimatedChar.STAND, 0).image_;
                }
                else {
                    texture_ = _arg1;
                }
            }
        }


    }
}//package com.company.assembleegameclient.objects

