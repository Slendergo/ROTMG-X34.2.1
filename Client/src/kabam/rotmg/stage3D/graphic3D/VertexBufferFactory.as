﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.stage3D.graphic3D.VertexBufferFactory

package kabam.rotmg.stage3D.graphic3D{
    import kabam.rotmg.stage3D.proxies.VertexBuffer3DProxy;
    import kabam.rotmg.stage3D.proxies.Context3DProxy;
    import org.swiftsuspenders.Injector;
    import flash.utils.Dictionary;
    import org.swiftsuspenders.dependencyproviders.*;

    public class VertexBufferFactory implements DependencyProvider {

        private var vertexBuffer:VertexBuffer3DProxy;

        public function VertexBufferFactory(_arg1:Context3DProxy){
            var _local2:Vector.<Number> = Vector.<Number>([-0.5, 0.5, 0, 0, 0, 0.5, 0.5, 0, 1, 0, -0.5, -0.5, 0, 0, 1, 0.5, -0.5, 0, 1, 1]);
            this.vertexBuffer = _arg1.createVertexBuffer(4, 5);
            this.vertexBuffer.uploadFromVector(_local2, 0, 4);
        }

        public function apply(_arg1:Class, _arg2:Injector, _arg3:Dictionary):Object{
            return (this.vertexBuffer);
        }

        public function destroy():void{
        }


    }
}//package kabam.rotmg.stage3D.graphic3D

