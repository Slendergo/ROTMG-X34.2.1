// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.GroundElement

package com.company.assembleegameclient.mapeditor{
    import com.company.assembleegameclient.mapeditor.Element;
    import flash.display.Shape;
    import flash.display.BitmapData;
    import flash.display.IGraphicsData;
    import com.company.assembleegameclient.map.Camera;
    import flash.geom.Rectangle;
    import com.company.assembleegameclient.map.GroundLibrary;
    import com.company.assembleegameclient.map.SquareFace;
    import com.company.assembleegameclient.map.AnimateProperties;
    import com.company.assembleegameclient.mapeditor.GroundTypeToolTip;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import com.company.assembleegameclient.mapeditor.*;

    class GroundElement extends Element {

        private static const VIN:Vector.<Number> = new <Number>[0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0];
        private static const SCALE:Number = 0.6;

        public var groundXML_:XML;
        private var tileShape_:Shape;
        private var tileBD:BitmapData;

        public function GroundElement(_arg1:XML){
            super(int(_arg1.@type));
            this.groundXML_ = _arg1;
            var _local2:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
            var _local3:Camera = new Camera();
            _local3.configure(0.5, 0.5, 12, (Math.PI / 4), new Rectangle(-100, -100, 200, 200));
            this.tileBD = GroundLibrary.getBitmapData(type_);
            var _local4:SquareFace = new SquareFace(this.tileBD, VIN, 0, 0, AnimateProperties.NO_ANIMATE, 0, 0);
            _local4.draw(_local2, _local3, 0);
            this.tileShape_ = new Shape();
            this.tileShape_.graphics.drawGraphicsData(_local2);
            this.tileShape_.scaleX = (this.tileShape_.scaleY = SCALE);
            this.tileShape_.x = (WIDTH / 2);
            this.tileShape_.y = (HEIGHT / 2);
            addChild(this.tileShape_);
        }

        override protected function getToolTip():ToolTip{
            return (new GroundTypeToolTip(this.groundXML_));
        }

        override public function get objectBitmap():BitmapData{
            return (this.tileBD);
        }


    }
}//package com.company.assembleegameclient.mapeditor

