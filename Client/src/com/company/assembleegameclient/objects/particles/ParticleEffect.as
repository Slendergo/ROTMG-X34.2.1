﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.particles.ParticleEffect

package com.company.assembleegameclient.objects.particles{
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.display.IGraphicsData;
    import com.company.assembleegameclient.map.Camera;

    public class ParticleEffect extends GameObject {

        public var reducedDrawEnabled:Boolean;

        public function ParticleEffect(){
            super(null);
            objectId_ = getNextFakeObjectId();
            hasShadow_ = false;
            this.reducedDrawEnabled = false;
        }

        public static function fromProps(_arg1:EffectProperties, _arg2:GameObject):ParticleEffect{
            if (((Parameters.data_.noParticlesMaster) && (!((((_arg1.id == "Vortex")) || ((_arg1.id == "Vent"))))))){
                return (null);
            }
            switch (_arg1.id){
                case "Healing":
                    return (new HealingEffect(_arg2));
                case "Fountain":
                    return (new FountainEffect(_arg2, _arg1));
                case "FountainSnowy":
                    return (new FountainSnowyEffect(_arg2, _arg1));
                case "Snowflake":
                    return (new SnowflakeEffect(_arg2, _arg1));
                case "SkyBeam":
                    return (new SkyBeamEffect(_arg2, _arg1));
                case "Circle":
                    return (new CircleEffect(_arg2, _arg1));
                case "Heart":
                    return (new HeartEffect(_arg2, _arg1));
                case "ExplosionComplex":
                    return (new ExplosionComplexEffect(_arg2, _arg1));
                case "Gas":
                    return (new GasEffect(_arg2, _arg1));
                case "Vent":
                    return (new VentEffect(_arg2));
                case "Bubbles":
                    return (new BubbleEffect(_arg2, _arg1));
                case "Vortex":
                    return (new VortexEffect(_arg2, _arg1));
                case "XMLEffect":
                    return (new XMLEffect(_arg2, _arg1));
                case "CustomParticles":
                    return (ParticleGenerator.attachParticleGenerator(_arg1, _arg2));
            }
            return (null);
        }


        override public function update(_arg1:int, _arg2:int):Boolean{
            if (this.reducedDrawEnabled){
                return (this.runEasyRendering(_arg1, _arg2));
            }
            return (this.runNormalRendering(_arg1, _arg2));
        }

        public function runNormalRendering(_arg1:int, _arg2:int):Boolean{
            return false;
        }

        public function runEasyRendering(_arg1:int, _arg2:int):Boolean{
            return false;
        }

        override public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void{
        }


    }
}//package com.company.assembleegameclient.objects.particles

