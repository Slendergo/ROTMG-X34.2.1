﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.stage3D.graphic3D.IndexBufferFactory

package kabam.rotmg.stage3D.graphic3D{
    import kabam.rotmg.stage3D.proxies.IndexBuffer3DProxy;
    import kabam.rotmg.stage3D.proxies.Context3DProxy;
    import org.swiftsuspenders.Injector;
    import flash.utils.Dictionary;
    import org.swiftsuspenders.dependencyproviders.*;

    public class IndexBufferFactory implements DependencyProvider {

        private static const numVertices:int = 6;

        private var indexBuffer:IndexBuffer3DProxy;

        public function IndexBufferFactory(_arg1:Context3DProxy):void{
            var _local2:Vector.<uint> = Vector.<uint>([0, 1, 2, 2, 1, 3]);
            if (_arg1 != null){
                this.indexBuffer = _arg1.createIndexBuffer(numVertices);
                this.indexBuffer.uploadFromVector(_local2, 0, numVertices);
            }
        }

        public function apply(_arg1:Class, _arg2:Injector, _arg3:Dictionary):Object{
            return (this.indexBuffer);
        }

        public function destroy():void{
        }


    }
}//package kabam.rotmg.stage3D.graphic3D

