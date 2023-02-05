﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.sound.SoundEffectLibrary

package com.company.assembleegameclient.sound{
    import flash.utils.Dictionary;
    import flash.media.Sound;
    import flash.events.IOErrorEvent;
    import kabam.rotmg.application.api.ApplicationSetup;
    import kabam.rotmg.core.StaticInjectorContext;
    import flash.net.URLRequest;
    import flash.media.SoundTransform;
    import flash.media.SoundChannel;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.events.Event;

    public class SoundEffectLibrary {

        private static const URL_PATTERN:String = "{URLBASE}/sfx/{NAME}.mp3";

        private static var urlBase:String;
        public static var nameMap_:Dictionary = new Dictionary();
        private static var activeSfxList_:Dictionary = new Dictionary(true);


        public static function load(_arg1:String):Sound{
            return ((nameMap_[_arg1] = ((nameMap_[_arg1]) || (makeSound(_arg1)))));
        }

        public static function makeSound(_arg1:String):Sound{
            var _local2:Sound = new Sound();
            _local2.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _local2.load(makeSoundRequest(_arg1));
            return (_local2);
        }

        private static function getUrlBase():String{
            var setup:ApplicationSetup;
            var base:String = "";
            try {
                setup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
                base = setup.getAppEngineUrl(true);
            }
            catch(error:Error) {
                base = "localhost";
            }
            return (base);
        }

        private static function makeSoundRequest(_arg1:String):URLRequest{
            urlBase = ((urlBase) || (getUrlBase()));
            var _local2:String = URL_PATTERN.replace("{URLBASE}", urlBase).replace("{NAME}", _arg1);
            return (new URLRequest(_local2));
        }

        public static function play(_arg1:String, _arg2:Number=1, _arg3:Boolean=true):void{
            var actualVolume:Number;
            var trans:SoundTransform;
            var channel:SoundChannel;
            var name:String = _arg1;
            var volumeMultiplier:Number = _arg2;
            var isFX:Boolean = _arg3;
            var sound:Sound = load(name);
            var volume:Number = (Parameters.data_.SFXVolume * volumeMultiplier);
            try {
                actualVolume = ((((((Parameters.data_.playSFX) && (isFX))) || (((!(isFX)) && (Parameters.data_.playPewPew))))) ? volume : 0);
                trans = new SoundTransform(actualVolume);
                channel = sound.play(0, 0, trans);
                channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true);
                activeSfxList_[channel] = volume;
            }
            catch(error:Error) {
            }
        }

        private static function onSoundComplete(_arg1:Event):void{
            var _local2:SoundChannel = (_arg1.target as SoundChannel);
            delete activeSfxList_[_local2];
        }

        public static function updateVolume(_arg1:Number):void{
            var _local2:SoundChannel;
            var _local3:SoundTransform;
            for each (_local2 in activeSfxList_) {
                activeSfxList_[_local2] = _arg1;
                _local3 = _local2.soundTransform;
                _local3.volume = ((Parameters.data_.playSFX) ? activeSfxList_[_local2] : 0);
                _local2.soundTransform = _local3;
            }
        }

        public static function updateTransform():void{
            var _local1:SoundChannel;
            var _local2:SoundTransform;
            for each (_local1 in activeSfxList_) {
                _local2 = _local1.soundTransform;
                _local2.volume = ((Parameters.data_.playSFX) ? activeSfxList_[_local1] : 0);
                _local1.soundTransform = _local2;
            }
        }

        public static function onIOError(_arg1:IOErrorEvent):void{
        }


    }
}//package com.company.assembleegameclient.sound

