// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.BackgroundFilledText

package com.company.assembleegameclient.ui{
    import flash.display.Sprite;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsPath;
    import flash.text.TextFieldAutoSize;

    public class BackgroundFilledText extends Sprite {

        protected static const MARGIN:int = 4;

        public var bWidth:int = 0;
        protected var text_:TextFieldDisplayConcrete;
        protected var w_:int;
        protected var enabledFill_:GraphicsSolidFill;
        protected var disabledFill_:GraphicsSolidFill;
        protected var path_:GraphicsPath;
        protected var graphicsData_:Vector.<IGraphicsData>;

        public function BackgroundFilledText(_arg1:int):void{
            this.enabledFill_ = new GraphicsSolidFill(0xFFFFFF, 1);
            this.disabledFill_ = new GraphicsSolidFill(0x7F7F7F, 1);
            this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            this.graphicsData_ = new <flash.display.IGraphicsData>[enabledFill_, path_, com.company.util.GraphicsUtil.END_FILL];
            super();
            this.bWidth = _arg1;
        }

        protected function centerTextAndDrawButton():void{
            this.w_ = (((this.bWidth)!=0) ? this.bWidth : (this.text_.width + 12));
            this.text_.x = (this.w_ / 2);
            GraphicsUtil.clearPath(this.path_);
            GraphicsUtil.drawCutEdgeRect(0, 0, this.w_, (this.text_.height + (MARGIN * 2)), 4, [1, 1, 1, 1], this.path_);
        }

        public function addText(_arg1:int):void{
            this.text_ = this.makeText().setSize(_arg1).setColor(0x363636);
            this.text_.setBold(true);
            this.text_.setAutoSize(TextFieldAutoSize.CENTER);
            this.text_.y = MARGIN;
            addChild(this.text_);
        }

        protected function makeText():TextFieldDisplayConcrete{
            return (new TextFieldDisplayConcrete());
        }


    }
}//package com.company.assembleegameclient.ui

