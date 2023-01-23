﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.util.components.SpriteBackground

package kabam.rotmg.util.components{
    import flash.display.Sprite;
    import flash.display.BitmapData;
    import kabam.rotmg.assets.services.IconFactory;
    import flash.filters.ColorMatrixFilter;
    import com.company.util.MoreColorUtil;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsPath;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;
    import kabam.rotmg.ui.view.SignalWaiter;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.util.Currency;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;

    public class SpriteBackground extends Sprite {

        private static const BEVEL:int = 4;
        private static const PADDING:int = 2;
        public static const coin:BitmapData = IconFactory.makeCoin();
        public static const fame:BitmapData = IconFactory.makeFame();
        public static const guildFame:BitmapData = IconFactory.makeGuildFame();
        private static const grayfilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);

        private const enabledFill:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
        private const disabledFill:GraphicsSolidFill = new GraphicsSolidFill(0x7F7F7F, 1);
        private const graphicsPath:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        private const graphicsData:Vector.<IGraphicsData> = new <flash.display.IGraphicsData>[enabledFill, graphicsPath, com.company.util.GraphicsUtil.END_FILL];
        private const waiter:SignalWaiter = new SignalWaiter();

        public var prefix:String;
        public var text:TextFieldDisplayConcrete;
        private var staticStringBuilder:StaticStringBuilder;
        private var lineBuilder:LineBuilder;
        public var icon:Bitmap;
        public var price:int = -1;
        public var currency:int = -1;
        public var _width:int = -1;
        private var sizeX:Number = 100;
        private var sizeY:Number = 100;

        public function SpriteBackground(_arg1:Number, _arg2:Number){
            this.staticStringBuilder = new StaticStringBuilder("");
            this.lineBuilder = new LineBuilder();
            super();
            this.prefix = "   ";
            this.sizeX = _arg1;
            this.sizeY = _arg2;
            this.price = 1;
            this.currency = Currency.GOLD;
            this.text = new TextFieldDisplayConcrete().setSize(_arg1).setColor(0x363636).setBold(true);
            this.waiter.push(this.text.textChanged);
            var _local3:StringBuilder = (((this.prefix)!="") ? this.lineBuilder.setParams(this.prefix, {cost:this.price.toString()}) : this.staticStringBuilder.setString(this.price.toString()));
            this.text.setStringBuilder(_local3);
            this.waiter.complete.add(this.updateUI);
            addChild(this.text);
        }

        public function setEnabled(_arg1:Boolean):void{
            if (_arg1 != mouseEnabled){
                mouseEnabled = _arg1;
                filters = ((_arg1) ? [] : [grayfilter]);
                this.draw();
            };
        }

        private function updateUI():void{
            this.updateBackground();
            this.draw();
        }

        private function updateBackground():void{
            GraphicsUtil.clearPath(this.graphicsPath);
            GraphicsUtil.drawCutEdgeRect(0, 0, this.getWidth(), this.getHeight(), BEVEL, [1, 1, 1, 1], this.graphicsPath);
        }

        private function draw():void{
            this.graphicsData[0] = ((mouseEnabled) ? this.enabledFill : this.disabledFill);
            graphics.clear();
            graphics.drawGraphicsData(this.graphicsData);
        }

        private function getWidth():int{
            return (this.sizeX);
        }

        private function getHeight():int{
            return (this.sizeY);
        }


    }
}//package kabam.rotmg.util.components

