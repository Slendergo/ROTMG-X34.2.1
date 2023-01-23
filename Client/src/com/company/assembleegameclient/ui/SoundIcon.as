﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.SoundIcon

package com.company.assembleegameclient.ui{
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.util.AssetLibrary;
    import com.company.assembleegameclient.sound.Music;
    import com.company.assembleegameclient.sound.SFX;

    public class SoundIcon extends Sprite {

        private var bitmap_:Bitmap;

        public function SoundIcon(){
            this.bitmap_ = new Bitmap();
            super();
            addChild(this.bitmap_);
            this.bitmap_.scaleX = 2;
            this.bitmap_.scaleY = 2;
            this.setBitmap();
            addEventListener(MouseEvent.CLICK, this.onIconClick);
            filters = [new GlowFilter(0, 1, 4, 4, 2, 1)];
        }

        private function setBitmap():void{
            this.bitmap_.bitmapData = ((((Parameters.data_.playMusic) || (Parameters.data_.playSFX))) ? AssetLibrary.getImageFromSet("lofiInterfaceBig", 3) : AssetLibrary.getImageFromSet("lofiInterfaceBig", 4));
        }

        private function onIconClick(_arg1:MouseEvent):void{
            var _local2 = !(((Parameters.data_.playMusic) || (Parameters.data_.playSFX)));
            Music.setPlayMusic(_local2);
            SFX.setPlaySFX(_local2);
            Parameters.data_.playPewPew = _local2;
            Parameters.save();
            this.setBitmap();
        }


    }
}//package com.company.assembleegameclient.ui

