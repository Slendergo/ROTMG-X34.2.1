// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.packages.model.PackageInfo

package kabam.rotmg.packages.model{
    import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
    import org.osflash.signals.Signal;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;

    public class PackageInfo extends GenericBoxInfo {

        public static const PURCHASE_TYPE_MIXED:String = "PURCHASE_TYPE_MIXED";
        public static const PURCHASE_TYPE_SLOTS_ONLY:String = "PURCHASE_TYPE_SLOTS_ONLY";
        public static const PURCHASE_TYPE_CONTENTS_ONLY:String = "PURCHASE_TYPE_CONTENTS_ONLY";

        protected var _image:String;
        protected var _popupImage:String = "";
        private var _showOnLogin:Boolean;
        private var _charSlot:int;
        private var _vaultSlot:int;
        private var _gold:int;
        public var imageLoadedSignal:Signal;
        public var popupImageLoadedSignal:Signal;
        private var _loader:Loader;
        private var _popupLoader:Loader;

        public function PackageInfo(){
            this.imageLoadedSignal = new Signal();
            this.popupImageLoadedSignal = new Signal();
            super();
        }

        public function get image():String{
            return (this._image);
        }

        public function get purchaseType():String{
            if (contents != ""){
                if ((((this._charSlot > 0)) || ((this._vaultSlot > 0)))){
                    return (PURCHASE_TYPE_MIXED);
                };
                return (PURCHASE_TYPE_CONTENTS_ONLY);
            };
            return (PURCHASE_TYPE_SLOTS_ONLY);
        }

        public function set image(_arg1:String):void{
            this._image = _arg1;
            this._loader = new Loader();
            this.loadImage(this._image, this._loader, this.onComplete);
        }

        private function loadImage(_arg1:String, _arg2:Loader, _arg3:Function):void{
            _arg2.contentLoaderInfo.addEventListener(Event.COMPLETE, _arg3);
            _arg2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            _arg2.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityEventError);
            try {
                _arg2.load(new URLRequest(_arg1));
            }
            catch(error:SecurityError) {
            };
        }

        private function unbindLoaderEvents(_arg1:Loader, _arg2:Function):void{
            if (((_arg1) && (_arg1.contentLoaderInfo))){
                _arg1.contentLoaderInfo.removeEventListener(Event.COMPLETE, _arg2);
                _arg1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                _arg1.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityEventError);
            };
        }

        private function onIOError(_arg1:IOErrorEvent):void{
        }

        private function onSecurityEventError(_arg1:SecurityErrorEvent):void{
        }

        private function onComplete(_arg1:Event):void{
            this.imageLoadedSignal.dispatch();
            this.unbindLoaderEvents(this._loader, this.onComplete);
        }

        private function onCompletePopup(_arg1:Event):void{
            this.popupImageLoadedSignal.dispatch();
            this.unbindLoaderEvents(this._popupLoader, this.onCompletePopup);
        }

        public function dispose():void{
        }

        public function get loader():Loader{
            return (this._loader);
        }

        public function get popupImage():String{
            return (this._popupImage);
        }

        public function set popupImage(_arg1:String):void{
            this._popupImage = _arg1;
            this._popupLoader = new Loader();
            this.loadImage(this._popupImage, this._popupLoader, this.onCompletePopup);
        }

        public function get popupLoader():Loader{
            return (this._popupLoader);
        }

        public function get showOnLogin():Boolean{
            return (this._showOnLogin);
        }

        public function set showOnLogin(_arg1:Boolean):void{
            this._showOnLogin = _arg1;
        }

        public function get charSlot():int{
            return (this._charSlot);
        }

        public function set charSlot(_arg1:int):void{
            this._charSlot = _arg1;
        }

        public function get vaultSlot():int{
            return (this._vaultSlot);
        }

        public function set vaultSlot(_arg1:int):void{
            this._vaultSlot = _arg1;
        }

        public function get gold():int{
            return (this._gold);
        }

        public function set gold(_arg1:int):void{
            this._gold = _arg1;
        }


    }
}//package kabam.rotmg.packages.model

