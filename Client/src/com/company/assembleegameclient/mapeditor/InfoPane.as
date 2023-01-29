﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.InfoPane

package com.company.assembleegameclient.mapeditor{
    import flash.display.Sprite;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import com.company.ui.BaseSimpleText;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsStroke;
    import flash.display.GraphicsPath;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.filters.DropShadowFilter;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import com.company.assembleegameclient.map.GroundLibrary;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.map.RegionLibrary;

    public class InfoPane extends Sprite {

        public static const WIDTH:int = 134;
        public static const HEIGHT:int = 120;
        private static const CSS_TEXT:String = ".in { margin-left:10px; text-indent: -10px; }";

        private var graphicsData_:Vector.<IGraphicsData>;
        private var meMap_:MEMap;
        private var rectText_:BaseSimpleText;
        private var typeText_:BaseSimpleText;
        private var outlineFill_:GraphicsSolidFill;
        private var lineStyle_:GraphicsStroke;
        private var backgroundFill_:GraphicsSolidFill;
        private var path_:GraphicsPath;

        public function InfoPane(_arg1:MEMap){
            this.outlineFill_ = new GraphicsSolidFill(0xFFFFFF, 1);
            this.lineStyle_ = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, this.outlineFill_);
            this.backgroundFill_ = new GraphicsSolidFill(0x363636, 1);
            this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            this.graphicsData_ = new <flash.display.IGraphicsData>[lineStyle_, backgroundFill_, path_, com.company.util.GraphicsUtil.END_FILL, com.company.util.GraphicsUtil.END_STROKE];
            super();
            this.meMap_ = _arg1;
            this.drawBackground();
            this.rectText_ = new BaseSimpleText(12, 0xFFFFFF, false, (WIDTH - 10), 0);
            this.rectText_.filters = [new DropShadowFilter(0, 0, 0)];
            this.rectText_.y = 4;
            this.rectText_.x = 4;
            addChild(this.rectText_);
            this.typeText_ = new BaseSimpleText(12, 0xFFFFFF, false, (WIDTH - 10), 0);
            this.typeText_.wordWrap = true;
            this.typeText_.filters = [new DropShadowFilter(0, 0, 0)];
            this.typeText_.x = 4;
            this.typeText_.y = 36;
            addChild(this.typeText_);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function onAddedToStage(_arg1:Event):void{
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onRemovedFromStage(_arg1:Event):void{
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onEnterFrame(_arg1:Event):void{
            var _local2:Rectangle = this.meMap_.mouseRectT();
            this.rectText_.text = ((("Position: " + _local2.x) + ", ") + _local2.y);
            if ((((_local2.width > 1)) || ((_local2.height > 1)))){
                this.rectText_.text = (this.rectText_.text + ((("\nRect: " + _local2.width) + ", ") + _local2.height));
            };
            this.rectText_.useTextDimensions();
            var _local3:METile = this.meMap_.getTile(_local2.x, _local2.y);
            var _local4:Vector.<int> = (((_local3 == null)) ? Layer.EMPTY_TILE : _local3.types_);
            var _local5:String = (((_local4[Layer.GROUND] == -1)) ? "None" : GroundLibrary.getIdFromType(_local4[Layer.GROUND]));
            var _local6:String = (((_local4[Layer.OBJECT] == -1)) ? "None" : ObjectLibrary.getIdFromType(_local4[Layer.OBJECT]));
            var _local7:String = (((_local4[Layer.REGION] == -1)) ? "None" : RegionLibrary.getIdFromType(_local4[Layer.REGION]));
            this.typeText_.htmlText = (((((((("<span class='in'>" + "Ground: ") + _local5) + "\nObject: ") + _local6) + (((((_local3 == null)) || ((_local3.objName_ == null)))) ? "" : ((" (" + _local3.objName_) + ")"))) + "\nRegion: ") + _local7) + "</span>");
            this.typeText_.useTextDimensions();
        }

        private function drawBackground():void{
            GraphicsUtil.clearPath(this.path_);
            GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, [1, 1, 1, 1], this.path_);
            graphics.drawGraphicsData(this.graphicsData_);
        }


    }
}//package com.company.assembleegameclient.mapeditor

