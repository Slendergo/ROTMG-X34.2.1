// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.popups.UIPopup

package io.decagames.rotmg.ui.popups{
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class UIPopup extends BasePopup {

        private var _header:PopupHeader;
        private var footer:SliceScalingBitmap;
        private var _background:SliceScalingBitmap;
        private var popupType:String;

        public function UIPopup(_arg1:int, _arg2:int){
            super(_arg1, _arg2);
            this.popupType = this.popupType;
            this._header = new PopupHeader(_arg1, PopupHeader.TYPE_FULL);
            addChild(this._header);
            this.footer = TextureParser.instance.getSliceScalingBitmap("UI", "popup_footer", _arg1);
            this.footer.y = (_arg2 - this.footer.height);
            addChild(this.footer);
        }

        public function get header():PopupHeader{
            return (this._header);
        }

        public function dispose():void{
            this._header.dispose();
            if (this.footer){
                this.footer.dispose();
            };
            if (this._background){
                this._background.dispose();
            };
        }


    }
}//package io.decagames.rotmg.ui.popups

