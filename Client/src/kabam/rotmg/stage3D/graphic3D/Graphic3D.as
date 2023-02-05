﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.stage3D.graphic3D.Graphic3D

package kabam.rotmg.stage3D.graphic3D{
    import kabam.rotmg.stage3D.proxies.TextureProxy;
    import flash.geom.Matrix3D;
    import kabam.rotmg.stage3D.proxies.Context3DProxy;
    import kabam.rotmg.stage3D.proxies.VertexBuffer3DProxy;
    import kabam.rotmg.stage3D.proxies.IndexBuffer3DProxy;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.display3D.VertexBuffer3D;
    import flash.display3D.IndexBuffer3D;
    import kabam.rotmg.stage3D.GraphicsFillExtra;
    import flash.geom.ColorTransform;
    import flash.display3D.Context3DProgramType;
    import flash.display.GraphicsBitmapFill;
    import flash.display.GraphicsGradientFill;
    import flash.display3D.Context3DVertexBufferFormat;

    public class Graphic3D {

        private static const gradientVertex:Vector.<Number> = Vector.<Number>([-0.5, 0.5, 0, 0, 0, 0, 0.01, 0, 1, 0.5, 0.5, 0, 0, 0, 0, 0.3, 1, 1, -0.5, -0.5, 0, 0, 0, 0, 0.1, 0, 0, 0.5, -0.5, 0, 0, 0, 0, 0.2, 1, 0]);
        private static const indices:Vector.<uint> = Vector.<uint>([0, 1, 2, 2, 1, 3]);

        public var texture:TextureProxy;
        public var matrix3D:Matrix3D;
        public var context3D:Context3DProxy;
        [Inject]
        public var textureFactory:TextureFactory;
        [Inject]
        public var vertexBuffer:VertexBuffer3DProxy;
        [Inject]
        public var indexBuffer:IndexBuffer3DProxy;
        private var bitmapData:BitmapData;
        private var matrix2D:Matrix;
        private var shadowMatrix2D:Matrix;
        private var sinkLevel:Number = 0;
        private var offsetMatrix:Vector.<Number>;
        private var vertexBufferCustom:VertexBuffer3D;
        private var gradientVB:VertexBuffer3D;
        private var gradientIB:IndexBuffer3D;
        private var repeat:Boolean;

        public function Graphic3D(){
            this.matrix3D = new Matrix3D();
            super();
        }

        public function setGraphic(_arg1:GraphicsBitmapFill, _arg2:Context3DProxy):void{
            this.bitmapData = _arg1.bitmapData;
            this.repeat = _arg1.repeat;
            this.matrix2D = _arg1.matrix;
            this.texture = this.textureFactory.make(_arg1.bitmapData);
            this.offsetMatrix = GraphicsFillExtra.getOffsetUV(_arg1);
            this.vertexBufferCustom = GraphicsFillExtra.getVertexBuffer(_arg1);
            this.sinkLevel = GraphicsFillExtra.getSinkLevel(_arg1);
            if (this.sinkLevel != 0){
                this.offsetMatrix = Vector.<Number>([0, -(this.sinkLevel), 0, 0]);
            }
            this.transform();
            var _local3:ColorTransform = GraphicsFillExtra.getColorTransform(this.bitmapData);
            _arg2.GetContext3D().setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, Vector.<Number>([_local3.redMultiplier, _local3.greenMultiplier, _local3.blueMultiplier, _local3.alphaMultiplier]));
            _arg2.GetContext3D().setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 3, Vector.<Number>([(_local3.redOffset / 0xFF), (_local3.greenOffset / 0xFF), (_local3.blueOffset / 0xFF), (_local3.alphaOffset / 0xFF)]));
        }

        public function setGradientFill(_arg1:GraphicsGradientFill, _arg2:Context3DProxy, _arg3:Number, _arg4:Number):void{
            this.shadowMatrix2D = _arg1.matrix;
            if ((((this.gradientVB == null)) || ((this.gradientIB == null)))){
                this.gradientVB = _arg2.GetContext3D().createVertexBuffer(4, 9);
                this.gradientVB.uploadFromVector(gradientVertex, 0, 4);
                this.gradientIB = _arg2.GetContext3D().createIndexBuffer(6);
                this.gradientIB.uploadFromVector(indices, 0, 6);
            }
            this.shadowTransform(_arg3, _arg4);
        }

        private function shadowTransform(_arg1:Number, _arg2:Number):void{
            this.matrix3D.identity();
            var _local3:Vector.<Number> = this.matrix3D.rawData;
            _local3[4] = -(this.shadowMatrix2D.c);
            _local3[1] = -(this.shadowMatrix2D.b);
            _local3[0] = (this.shadowMatrix2D.a * 4);
            _local3[5] = (this.shadowMatrix2D.d * 4);
            _local3[12] = (this.shadowMatrix2D.tx / _arg1);
            _local3[13] = (-(this.shadowMatrix2D.ty) / _arg2);
            this.matrix3D.rawData = _local3;
        }

        private function transform():void{
            this.matrix3D.identity();
            var _local1:Vector.<Number> = this.matrix3D.rawData;
            _local1[4] = -(this.matrix2D.c);
            _local1[1] = -(this.matrix2D.b);
            _local1[0] = this.matrix2D.a;
            _local1[5] = this.matrix2D.d;
            _local1[12] = this.matrix2D.tx;
            _local1[13] = -(this.matrix2D.ty);
            this.matrix3D.rawData = _local1;
            this.matrix3D.prependScale(Math.ceil(this.texture.getWidth()), Math.ceil(this.texture.getHeight()), 1);
            this.matrix3D.prependTranslation(0.5, -0.5, 0);
        }

        public function render(_arg1:Context3DProxy):void{
            var _local2:Program3DFactory = Program3DFactory.getInstance();
            _arg1.setProgram(_local2.getProgram(_arg1, this.repeat));
            _arg1.setTextureAt(0, this.texture);
            if (this.vertexBufferCustom != null){
                _arg1.GetContext3D().setVertexBufferAt(0, this.vertexBufferCustom, 0, Context3DVertexBufferFormat.FLOAT_3);
                _arg1.GetContext3D().setVertexBufferAt(1, this.vertexBufferCustom, 3, Context3DVertexBufferFormat.FLOAT_2);
                _arg1.GetContext3D().setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, this.offsetMatrix);
                _arg1.GetContext3D().setVertexBufferAt(2, null, 6, Context3DVertexBufferFormat.FLOAT_2);
                _arg1.drawTriangles(this.indexBuffer);
            }
            else {
                _arg1.setVertexBufferAt(0, this.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
                _arg1.setVertexBufferAt(1, this.vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2);
                _arg1.GetContext3D().setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, this.offsetMatrix);
                _arg1.GetContext3D().setVertexBufferAt(2, null, 6, Context3DVertexBufferFormat.FLOAT_2);
                _arg1.drawTriangles(this.indexBuffer);
            }
        }

        public function renderShadow(_arg1:Context3DProxy):void{
            _arg1.GetContext3D().setVertexBufferAt(0, this.gradientVB, 0, Context3DVertexBufferFormat.FLOAT_3);
            _arg1.GetContext3D().setVertexBufferAt(1, this.gradientVB, 3, Context3DVertexBufferFormat.FLOAT_4);
            _arg1.GetContext3D().setVertexBufferAt(2, this.gradientVB, 7, Context3DVertexBufferFormat.FLOAT_2);
            _arg1.GetContext3D().setTextureAt(0, null);
            _arg1.GetContext3D().drawTriangles(this.gradientIB);
        }

        public function getMatrix3D():Matrix3D{
            return (this.matrix3D);
        }


    }
}//package kabam.rotmg.stage3D.graphic3D

