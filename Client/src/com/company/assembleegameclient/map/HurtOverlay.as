// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.map.HurtOverlay

package com.company.assembleegameclient.map{
    import flash.display.Shape;
    import flash.display.GraphicsGradientFill;
    import flash.display.GradientType;
    import com.company.util.GraphicsUtil;
    import flash.display.GraphicsPath;
    import flash.display.IGraphicsData;

    public class HurtOverlay extends Shape {

        private const s:Number = (600 / Math.sin((Math.PI / 4)));
        private const gradientFill_:GraphicsGradientFill = new flash.display.GraphicsGradientFill(flash.display.GradientType.RADIAL, [0xFFFFFF, 0xFFFFFF, 0xFFFFFF], [0, 0, 0.92], [0, 155, 0xFF], com.company.util.GraphicsUtil.getGradientMatrix(s, s, 0, ((600 - s) / 2), ((600 - s) / 2)));
        private const gradientPath_:GraphicsPath = GraphicsUtil.getRectPath(0, 0, 600, 600);
        private const gradientGraphicsData_:Vector.<IGraphicsData> = new <flash.display.IGraphicsData>[gradientFill_, gradientPath_, com.company.util.GraphicsUtil.END_FILL];

        public function HurtOverlay(){
            graphics.drawGraphicsData(this.gradientGraphicsData_);
            visible = false;
        }

    }
}//package com.company.assembleegameclient.map

