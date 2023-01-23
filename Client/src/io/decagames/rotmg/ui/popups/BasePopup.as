// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.popups.BasePopup

package io.decagames.rotmg.ui.popups{
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    public class BasePopup extends Sprite {

        protected var _showOnFullScreen:Boolean;
        protected var _popupWidth:int;
        protected var _popupHeight:int;
        protected var _popupFadeColor:uint = 0x151515;
        protected var _popupFadeAlpha:Number = 0.6;
        protected var _contentHeight:int;
        protected var _contentWidth:int;
        private var _overrideSizePosition:Rectangle;

        public function BasePopup(_arg1:int, _arg2:int, _arg3:Rectangle=null){
            this._popupWidth = _arg1;
            this._popupHeight = _arg2;
            this._overrideSizePosition = _arg3;
        }

        public function get showOnFullScreen():Boolean{
            return (this._showOnFullScreen);
        }

        public function set showOnFullScreen(_arg1:Boolean):void{
            this._showOnFullScreen = _arg1;
        }

        public function get popupWidth():int{
            return (this._popupWidth);
        }

        public function set popupWidth(_arg1:int):void{
            this._popupWidth = _arg1;
        }

        public function get popupHeight():int{
            return (this._popupHeight);
        }

        public function set popupHeight(_arg1:int):void{
            this._popupHeight = _arg1;
        }

        public function get popupFadeColor():Number{
            return (this._popupFadeColor);
        }

        public function get popupFadeAlpha():Number{
            return (this._popupFadeAlpha);
        }

        public function get overrideSizePosition():Rectangle{
            return (this._overrideSizePosition);
        }

        public function get contentHeight():int{
            return (this._contentHeight);
        }

        public function get contentWidth():int{
            return (this._contentWidth);
        }


    }
}//package io.decagames.rotmg.ui.popups

