﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.util.components.LegacyBuyButton

package kabam.rotmg.util.components{
    import kabam.rotmg.util.components.api.BuyButton;
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
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.util.Currency;
    import flash.display.GraphicsStroke;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.Graphics;

    public class LegacyBuyButton extends BuyButton {

        private static const BEVEL:int = 4;
        private static const PADDING:int = 2;
        public static const coin:BitmapData = IconFactory.makeCoin();
        public static const fortune:BitmapData = IconFactory.makeFortune();
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
        private var withOutLine:Boolean = false;
        private var outLineColor:int = 0x545454;
        private var fixedWidth:int = -1;
        private var fixedHeight:int = -1;
        private var textVertMargin:int = 4;

        public function LegacyBuyButton(_arg1:String, _arg2:int, _arg3:int, _arg4:int, _arg5:Boolean=false, _arg6:Boolean=false){
            this.staticStringBuilder = new StaticStringBuilder("");
            this.lineBuilder = new LineBuilder();
            super();
            this.prefix = _arg1;
            this.text = new TextFieldDisplayConcrete().setSize(_arg2).setColor(((_arg6) ? 15544368 : 0x363636)).setBold(true);
            this.waiter.push(this.text.textChanged);
            var _local7:StringBuilder = (((_arg1)!="") ? this.lineBuilder.setParams(_arg1, {cost:_arg3.toString()}) : this.staticStringBuilder.setString(_arg3.toString()));
            this.text.setStringBuilder(_local7);
            this.waiter.complete.add(this.updateUI);
            this.waiter.complete.addOnce(this.readyForPlacementDispatch);
            addChild(this.text);
            this.icon = new Bitmap();
            addChild(this.icon);
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            this.setPrice(_arg3, _arg4);
            this.withOutLine = _arg5;
        }

        override public function setPrice(_arg1:int, _arg2:int):void{
            var _local3:StringBuilder;
            if (((!((this.price == _arg1))) || (!((this.currency == _arg2))))){
                this.price = _arg1;
                this.currency = _arg2;
                _local3 = (((this.prefix)!="") ? this.lineBuilder.setParams(this.prefix, {cost:_arg1.toString()}) : this.staticStringBuilder.setString(_arg1.toString()));
                this.text.setStringBuilder(_local3);
                this.updateUI();
            }
        }

        public function setStringBuilder(_arg1:StringBuilder):void{
            this.text.setStringBuilder(_arg1);
            this.updateUI();
        }

        public function getPrice():int{
            return (this.price);
        }

        public function setText(_arg1:String):void{
            this.text.setStringBuilder(new StaticStringBuilder(_arg1));
            this.updateUI();
        }

        override public function setEnabled(_arg1:Boolean):void{
            if (_arg1 != mouseEnabled){
                mouseEnabled = _arg1;
                filters = ((_arg1) ? [] : [grayfilter]);
                this.draw();
            }
        }

        override public function setWidth(_arg1:int):void{
            this._width = _arg1;
            this.updateUI();
        }

        private function updateUI():void{
            this.updateText();
            this.updateIcon();
            this.updateBackground();
            this.draw();
        }

        private function readyForPlacementDispatch():void{
            this.updateUI();
            readyForPlacement.dispatch();
        }

        private function updateIcon():void{
            switch (this.currency){
                case Currency.GOLD:
                    this.icon.bitmapData = coin;
                    break;
                case Currency.FAME:
                    this.icon.bitmapData = fame;
                    break;
                case Currency.GUILD_FAME:
                    this.icon.bitmapData = guildFame;
                    break;
                case Currency.FORTUNE:
                    this.icon.bitmapData = fortune;
                    break;
                default:
                    this.icon.bitmapData = null;
            }
            this.updateIconPosition();
        }

        private function updateBackground():void{
            GraphicsUtil.clearPath(this.graphicsPath);
            GraphicsUtil.drawCutEdgeRect(0, 0, this.getWidth(), this.getHeight(), BEVEL, [1, 1, 1, 1], this.graphicsPath);
        }

        private function updateText():void{
            this.text.x = ((((this.getWidth() - this.icon.width) - this.text.width) - PADDING) * 0.5);
            this.text.y = this.textVertMargin;
        }

        private function updateIconPosition():void{
            this.icon.x = (this.text.x + this.text.width);
            this.icon.y = (((this.getHeight() - this.icon.height) - 1) * 0.5);
        }

        private function onMouseOver(_arg1:MouseEvent):void{
            this.enabledFill.color = 16768133;
            this.draw();
        }

        private function onRollOut(_arg1:MouseEvent):void{
            this.enabledFill.color = 0xFFFFFF;
            this.draw();
        }

        public function draw():void{
            this.graphicsData[0] = ((mouseEnabled) ? this.enabledFill : this.disabledFill);
            graphics.clear();
            graphics.drawGraphicsData(this.graphicsData);
            if (this.withOutLine){
                this.drawOutline(graphics);
            }
        }

        private function getWidth():int{
            return ((((this.fixedWidth)!=-1) ? this.fixedWidth : Math.max(this._width, ((this.text.width + this.icon.width) + (4 * PADDING)))));
        }

        private function getHeight():int{
            return ((((this.fixedHeight)!=-1) ? this.fixedHeight : (this.text.height + (this.textVertMargin * 2))));
        }

        public function freezeSize():void{
            this.fixedHeight = this.getHeight();
            this.fixedWidth = this.getWidth();
        }

        public function unfreezeSize():void{
            this.fixedHeight = -1;
            this.fixedWidth = -1;
        }

        public function scaleButtonWidth(_arg1:Number):void{
            this.fixedWidth = (this.getWidth() * _arg1);
            this.updateUI();
        }

        public function scaleButtonHeight(_arg1:Number):void{
            this.textVertMargin = (this.textVertMargin * _arg1);
            this.updateUI();
        }

        public function setOutLineColor(_arg1:int):void{
            this.outLineColor = _arg1;
        }

        private function drawOutline(_arg1:Graphics):void{
            var _local2:GraphicsSolidFill = new GraphicsSolidFill(0, 0.01);
            var _local3:GraphicsSolidFill = new GraphicsSolidFill(this.outLineColor, 0.6);
            var _local4:GraphicsStroke = new GraphicsStroke(4, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, _local3);
            var _local5:GraphicsPath = new GraphicsPath();
            GraphicsUtil.drawCutEdgeRect(0, 0, this.getWidth(), this.getHeight(), 4, GraphicsUtil.ALL_CUTS, _local5);
            var _local6:Vector.<IGraphicsData> = new <IGraphicsData>[_local4, _local2, _local5, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
            _arg1.drawGraphicsData(_local6);
        }


    }
}//package kabam.rotmg.util.components

