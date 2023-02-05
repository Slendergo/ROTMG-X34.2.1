// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.Slot

package com.company.assembleegameclient.ui{
    import flash.display.Sprite;
    import flash.geom.Matrix;
    import flash.filters.ColorMatrixFilter;
    import com.company.util.MoreColorUtil;
    import flash.display.Bitmap;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsPath;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import flash.geom.Point;
    import kabam.rotmg.constants.ItemConstants;
    import kabam.rotmg.text.view.BitmapTextFactory;
    import flash.display.BitmapData;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class Slot extends Sprite {

        public static const IDENTITY_MATRIX:Matrix = new Matrix();
        public static const WIDTH:int = 40;
        public static const HEIGHT:int = 40;
        public static const BORDER:int = 4;
        private static const greyColorFilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(0x363636));

        public var type_:int;
        public var hotkey_:int;
        public var cuts_:Array;
        public var backgroundImage_:Bitmap;
        protected var fill_:GraphicsSolidFill;
        protected var path_:GraphicsPath;
        private var graphicsData_:Vector.<IGraphicsData>;

        public function Slot(_arg1:int, _arg2:int, _arg3:Array){
            this.fill_ = new GraphicsSolidFill(0x545454, 1);
            this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            this.graphicsData_ = new <IGraphicsData>[this.fill_, this.path_, GraphicsUtil.END_FILL];
            super();
            this.type_ = _arg1;
            this.hotkey_ = _arg2;
            this.cuts_ = _arg3;
            this.drawBackground();
        }

        protected function offsets(_arg1:int, _arg2:int, _arg3:Boolean):Point{
            var _local4:Point = new Point();
            switch (_arg2){
                case ItemConstants.RING_TYPE:
                    _local4.x = (((_arg1)==2878) ? 0 : -2);
                    _local4.y = ((_arg3) ? -2 : 0);
                    break;
                case ItemConstants.SPELL_TYPE:
                    _local4.y = -2;
                    break;
            }
            return (_local4);
        }

        protected function drawBackground():void{
            var _local2:Point;
            var _local3:BitmapTextFactory;
            GraphicsUtil.clearPath(this.path_);
            GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, this.cuts_, this.path_);
            graphics.clear();
            graphics.drawGraphicsData(this.graphicsData_);
            var _local1:BitmapData = ItemConstants.itemTypeToBaseSprite(this.type_);
            if (this.backgroundImage_ == null){
                if (_local1 != null){
                    _local2 = this.offsets(-1, this.type_, true);
                    this.backgroundImage_ = new Bitmap(_local1);
                    this.backgroundImage_.x = (BORDER + _local2.x);
                    this.backgroundImage_.y = (BORDER + _local2.y);
                    this.backgroundImage_.scaleX = 4;
                    this.backgroundImage_.scaleY = 4;
                    this.backgroundImage_.filters = [greyColorFilter];
                    addChild(this.backgroundImage_);
                }
                else {
                    if (this.hotkey_ > 0){
                        _local3 = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
                        _local1 = _local3.make(new StaticStringBuilder(String(this.hotkey_)), 26, 0x363636, true, IDENTITY_MATRIX, false);
                        this.backgroundImage_ = new Bitmap(_local1);
                        this.backgroundImage_.x = ((WIDTH / 2) - (_local1.width / 2));
                        this.backgroundImage_.y = ((HEIGHT / 2) - 18);
                        addChild(this.backgroundImage_);
                    }
                }
            }
        }


    }
}//package com.company.assembleegameclient.ui

