﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.ParticleLibrary

package com.company.assembleegameclient.objects.particles{
    public class ParticleLibrary {

        public static const propsLibrary_:Object = {};


        public static function parseFromXML(_arg1:XML):void{
            var _local2:XML;
            for each (_local2 in _arg1.Particle) {
                propsLibrary_[_local2.@id] = new ParticleProperties(_local2);
            };
        }


    }
}//package com.company.assembleegameclient.objects.particles

