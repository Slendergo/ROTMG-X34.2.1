// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.fame.StatsLine

package io.decagames.rotmg.fame{
    import flash.display.Sprite;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsPath;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Bitmap;
    import flash.text.TextFormat;
    import kabam.rotmg.text.model.FontModel;
    import flash.text.TextFormatAlign;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.util.AssetLibrary;
    import io.decagames.rotmg.utils.colors.Tint;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;

    public class StatsLine extends Sprite {

        public static const TYPE_BONUS:int = 0;
        public static const TYPE_STAT:int = 1;
        public static const TYPE_TITLE:int = 2;

        private var backgroundFill_:GraphicsSolidFill;
        private var path_:GraphicsPath;
        private var lineWidth:int = 306;
        protected var lineHeight:int;
        private var _tooltipText:String;
        private var _lineType:int;
        private var isLocked:Boolean;
        protected var fameValue:UILabel;
        protected var label:UILabel;
        protected var lock:Bitmap;
        private var _labelText:String;

        public function StatsLine(_arg1:String, _arg2:String, _arg3:String, _arg4:int, _arg5:Boolean=false){
            var _local8:int;
            this.backgroundFill_ = new GraphicsSolidFill(0x1E1E1E);
            this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            this.fameValue = new UILabel();
            super();
            var _local6:TextFormat = new TextFormat();
            _local6.color = 0x8A8A8A;
            _local6.font = FontModel.DEFAULT_FONT_NAME;
            _local6.size = 13;
            _local6.bold = true;
            _local6.align = TextFormatAlign.LEFT;
            this.isLocked = _arg5;
            this._lineType = _arg4;
            this._labelText = _arg1;
            if (_arg4 == TYPE_TITLE){
                _local6.size = 15;
                _local6.color = 0xFFFFFF;
            };
            var _local7:TextFormat = new TextFormat();
            if (_arg4 == TYPE_BONUS){
                _local7.color = 0xFFC800;
            }
            else {
                _local7.color = 5544494;
            };
            _local7.font = FontModel.DEFAULT_FONT_NAME;
            _local7.size = 13;
            _local7.bold = true;
            _local7.align = TextFormatAlign.LEFT;
            this.label = new UILabel();
            this.label.defaultTextFormat = _local6;
            addChild(this.label);
            this.label.text = _arg1;
            if (!_arg5){
                this.fameValue = new UILabel();
                this.fameValue.defaultTextFormat = _local7;
                if ((((_arg2 == "0")) || ((_arg2 == "0.00%")))){
                    this.fameValue.defaultTextFormat = _local6;
                };
                if (_arg4 == TYPE_BONUS){
                    this.fameValue.text = ("+" + _arg2);
                }
                else {
                    this.fameValue.text = _arg2;
                };
                this.fameValue.x = ((this.lineWidth - 4) - this.fameValue.textWidth);
                addChild(this.fameValue);
                this.fameValue.y = 2;
            }
            else {
                _local8 = 36;
                this.lock = new Bitmap(TextureRedrawer.resize(AssetLibrary.getImageFromSet("lofiInterface2", 5), null, _local8, true, 0, 0));
                Tint.add(this.lock, 9971490, 1);
                addChild(this.lock);
                this.lock.x = ((this.lineWidth - _local8) + 5);
                this.lock.y = -8;
            };
            this.setLabelsPosition();
            this._tooltipText = _arg3;
        }

        protected function setLabelsPosition():void{
            this.label.y = 2;
            this.label.x = 2;
            this.lineHeight = 20;
        }

        public function clean():void{
            if (this.lock){
                removeChild(this.lock);
                this.lock.bitmapData.dispose();
            };
        }

        public function drawBrightBackground():void{
            var _local1:Vector.<IGraphicsData> = new <IGraphicsData>[this.backgroundFill_, this.path_, GraphicsUtil.END_FILL];
            GraphicsUtil.drawCutEdgeRect(0, 0, this.lineWidth, this.lineHeight, 5, [1, 1, 1, 1], this.path_);
            graphics.drawGraphicsData(_local1);
        }

        public function get tooltipText():String{
            return (this._tooltipText);
        }

        public function get lineType():int{
            return (this._lineType);
        }

        public function get labelText():String{
            return (this._labelText);
        }


    }
}//package io.decagames.rotmg.fame

