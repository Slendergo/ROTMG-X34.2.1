﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.stage3D.Stage3DConfig

package kabam.rotmg.stage3D{
    import com.company.assembleegameclient.util.StageProxy;
    import org.swiftsuspenders.Injector;
    import com.company.assembleegameclient.util.Stage3DProxy;
    import flash.events.ErrorEvent;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.events.Event;
    import kabam.rotmg.stage3D.graphic3D.TextureFactory;
    import kabam.rotmg.stage3D.graphic3D.IndexBufferFactory;
    import kabam.rotmg.stage3D.graphic3D.VertexBufferFactory;
    import kabam.rotmg.stage3D.proxies.Context3DProxy;
    import flash.display3D.Context3DBlendFactor;
    import flash.display3D.Context3DCompareMode;
    import kabam.rotmg.stage3D.graphic3D.Graphic3DHelper;
    import com.company.assembleegameclient.engine3d.Model3D;
    import robotlegs.bender.framework.api.*;

    public class Stage3DConfig implements IConfig {

        public static const WIDTH:int = 600;
        public static const HALF_WIDTH:int = (WIDTH / 2);//300
        public static const HEIGHT:int = 600;
        public static const HALF_HEIGHT:int = (HEIGHT / 2);//300

        [Inject]
        public var stageProxy:StageProxy;
        [Inject]
        public var injector:Injector;
        public var renderer:Renderer;
        private var stage3D:Stage3DProxy;


        public function configure():void{
            this.mapSingletons();
            this.stage3D = this.stageProxy.getStage3Ds(0);
            this.stage3D.addEventListener(ErrorEvent.ERROR, Parameters.clearGpuRenderEvent);
            this.stage3D.addEventListener(Event.CONTEXT3D_CREATE, this.onContextCreate);
            this.stage3D.requestContext3D();
        }

        private function mapSingletons():void{
            this.injector.map(Render3D).asSingleton();
            this.injector.map(TextureFactory).asSingleton();
            this.injector.map(IndexBufferFactory).asSingleton();
            this.injector.map(VertexBufferFactory).asSingleton();
        }

        private function onContextCreate(_arg1:Event):void{
            this.stage3D.removeEventListener(Event.CONTEXT3D_CREATE, this.onContextCreate);
            var _local2:Context3DProxy = this.stage3D.getContext3D();
            if (_local2.GetContext3D().driverInfo.toLowerCase().indexOf("software") != -1){
                Parameters.clearGpuRender();
            };
            _local2.configureBackBuffer(WIDTH, HEIGHT, 2, true);
            _local2.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            _local2.setDepthTest(false, Context3DCompareMode.LESS_EQUAL);
            this.injector.map(Context3DProxy).toValue(_local2);
            Graphic3DHelper.map(this.injector);
            this.renderer = this.injector.getInstance(Renderer);
            this.renderer.init(_local2.GetContext3D());
            Model3D.Create3dBuffer(_local2.GetContext3D());
        }


    }
}//package kabam.rotmg.stage3D

