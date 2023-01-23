﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.sound.Music

package com.company.assembleegameclient.sound{
import flash.events.IOErrorEvent;
import flash.media.Sound;
    import flash.media.SoundTransform;
    import flash.media.SoundChannel;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.application.api.ApplicationSetup;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.net.URLRequest;

    public class Music {

        private static var music_:Sound = null;
        private static var musicVolumeTransform:SoundTransform;
        private static var musicChannel_:SoundChannel = null;
        private static var volume:Number = 0.3;

        public static function load():void{
            var _local1:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
            var _local2:String = (_local1.getAppEngineUrl(true) + "/music/sorc.mp3");
            volume = Parameters.data_.musicVolume;
            musicVolumeTransform = new SoundTransform(((Parameters.data_.playMusic) ? volume : 0));
            music_ = new Sound();
            music_.load(new URLRequest(_local2));
            musicChannel_ = music_.play(0, int.MAX_VALUE, musicVolumeTransform);
        }

        public static function setPlayMusic(_arg1:Boolean):void{
            Parameters.data_.playMusic = _arg1;
            Parameters.save();
            musicVolumeTransform.volume = ((Parameters.data_.playMusic) ? volume : 0);
            musicChannel_.soundTransform = musicVolumeTransform;
        }

        public static function setMusicVolume(_arg1:Number):void{
            Parameters.data_.musicVolume = _arg1;
            Parameters.save();
            if (!Parameters.data_.playMusic){
                return;
            }

            if (musicVolumeTransform != null){
                musicVolumeTransform.volume = _arg1;
            }
            else {
                musicVolumeTransform = new SoundTransform(_arg1);
            }

            musicChannel_.soundTransform = musicVolumeTransform;
        }


    }
}//package com.company.assembleegameclient.sound

