﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.sound.SFX

package com.company.assembleegameclient.sound{
    import flash.media.SoundTransform;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.core.service.GoogleAnalytics;

    public class SFX {

        private static var sfxTrans_:SoundTransform;


        public static function load():void{
            sfxTrans_ = new SoundTransform(((Parameters.data_.playSFX) ? 1 : 0));
        }

        public static function setPlaySFX(_arg1:Boolean):void{
            var _local2:GoogleAnalytics = StaticInjectorContext.getInjector().getInstance(GoogleAnalytics);
            if (_local2){
            };
            Parameters.data_.playSFX = _arg1;
            Parameters.save();
            SoundEffectLibrary.updateTransform();
        }

        public static function setSFXVolume(_arg1:Number):void{
            Parameters.data_.SFXVolume = _arg1;
            Parameters.save();
            SoundEffectLibrary.updateVolume(_arg1);
        }


    }
}//package com.company.assembleegameclient.sound

