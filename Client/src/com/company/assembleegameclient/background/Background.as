﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.background.Background

package com.company.assembleegameclient.background{
    import flash.display.Sprite;
    import com.company.assembleegameclient.map.Camera;

    public class Background extends Sprite {

        public static const NO_BACKGROUND:int = 0;
        public static const STAR_BACKGROUND:int = 1;
        public static const NEXUS_BACKGROUND:int = 2;
        public static const NUM_BACKGROUND:int = 3;

        public function Background(){
            visible = false;
        }

        public static function getBackground(_arg1:int):Background{
            switch (_arg1){
                case NO_BACKGROUND:
                    return (null);
                case STAR_BACKGROUND:
                    return (new StarBackground());
                case NEXUS_BACKGROUND:
                    return (new NexusBackground());
            };
            return (null);
        }


        public function draw(_arg1:Camera, _arg2:int):void{
        }


    }
}//package com.company.assembleegameclient.background

