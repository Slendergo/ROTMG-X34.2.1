// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.mysterybox.model.MysteryBoxInfo

package kabam.rotmg.mysterybox.model{
    import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
    import flash.display.DisplayObject;
    import kabam.display.Loader.LoaderProxy;
    import kabam.display.Loader.LoaderProxyConcrete;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;

    public class MysteryBoxInfo extends GenericBoxInfo {

        public var _iconImageUrl:String;
        private var _iconImage:DisplayObject;
        public var _infoImageUrl:String;
        private var _infoImage:DisplayObject;
        private var _loader:LoaderProxy;
        private var _infoImageLoader:LoaderProxy;
        public var _rollsWithContents:Vector.<Vector.<int>>;
        public var _rollsWithContentsUnique:Vector.<int>;
        private var _rollsContents:Vector.<Vector.<int>>;
        private var _rolls:int;
        private var _jackpots:String = "";
        private var _displayedItems:String = "";

        public function MysteryBoxInfo(){
            this._loader = new LoaderProxyConcrete();
            this._infoImageLoader = new LoaderProxyConcrete();
            this._rollsWithContents = new Vector.<Vector.<int>>();
            this._rollsWithContentsUnique = new Vector.<int>();
            this._rollsContents = new Vector.<Vector.<int>>();
            super();
        }

        public function get iconImageUrl(){
            return (this._iconImageUrl);
        }

        public function set iconImageUrl(_arg1:String):void{
            this._iconImageUrl = _arg1;
            this.loadIconImageFromUrl(this._iconImageUrl);
        }

        private function loadIconImageFromUrl(_arg1:String):void{
            ((this._loader) && (this._loader.unload()));
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, this.onError);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, this.onError);
            this._loader.load(new URLRequest(_arg1));
        }

        private function onError(_arg1:IOErrorEvent):void{
        }

        private function onComplete(_arg1:Event):void{
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.DISK_ERROR, this.onError);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onError);
            this._iconImage = DisplayObject(this._loader);
        }

        public function get iconImage():DisplayObject{
            return (this._iconImage);
        }

        public function get infoImageUrl(){
            return (this._infoImageUrl);
        }

        public function set infoImageUrl(_arg1:String):void{
            this._infoImageUrl = _arg1;
            this.loadInfomageFromUrl(this._infoImageUrl);
        }

        private function loadInfomageFromUrl(_arg1:String):void{
            this.loadImageFromUrl(_arg1, this._infoImageLoader);
        }

        private function loadImageFromUrl(_arg1:String, _arg2:LoaderProxy):void{
            ((_arg2) && (_arg2.unload()));
            _arg2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onInfoComplete);
            _arg2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onInfoError);
            _arg2.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, this.onInfoError);
            _arg2.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, this.onInfoError);
            _arg2.load(new URLRequest(_arg1));
        }

        private function onInfoError(_arg1:IOErrorEvent):void{
        }

        private function onInfoComplete(_arg1:Event):void{
            this._infoImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onInfoComplete);
            this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onInfoError);
            this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.DISK_ERROR, this.onInfoError);
            this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onInfoError);
            this._infoImage = DisplayObject(this._infoImageLoader);
        }

        public function parseContents():void{
            var _local4:String;
            var _local5:Vector.<int>;
            var _local6:Array;
            var _local7:String;
            var _local1:Array = _contents.split(";");
            var _local2:Dictionary = new Dictionary();
            var _local3:int;
            for each (_local4 in _local1) {
                _local5 = new Vector.<int>();
                _local6 = _local4.split(",");
                for each (_local7 in _local6) {
                    if (_local2[int(_local7)] == null){
                        _local2[int(_local7)] = true;
                        this._rollsWithContentsUnique.push(int(_local7));
                    };
                    _local5.push(int(_local7));
                };
                this._rollsWithContents.push(_local5);
                this._rollsContents[_local3] = _local5;
                _local3++;
            };
        }

        public function get currencyName():String{
            switch (_priceCurrency){
                case "0":
                    return (LineBuilder.getLocalizedStringFromKey("Currency.gold").toLowerCase());
                case "1":
                    return (LineBuilder.getLocalizedStringFromKey("Currency.fame").toLowerCase());
            };
            return ("");
        }

        public function get infoImage():DisplayObject{
            return (this._infoImage);
        }

        public function set infoImage(_arg1:DisplayObject):void{
            this._infoImage = _arg1;
        }

        public function get loader():LoaderProxy{
            return (this._loader);
        }

        public function set loader(_arg1:LoaderProxy):void{
            this._loader = _arg1;
        }

        public function get infoImageLoader():LoaderProxy{
            return (this._infoImageLoader);
        }

        public function set infoImageLoader(_arg1:LoaderProxy):void{
            this._infoImageLoader = _arg1;
        }

        public function get jackpots():String{
            return (this._jackpots);
        }

        public function set jackpots(_arg1:String):void{
            this._jackpots = _arg1;
        }

        public function get rolls():int{
            return (this._rolls);
        }

        public function set rolls(_arg1:int):void{
            this._rolls = _arg1;
        }

        public function get rollsContents():Vector.<Vector.<int>>{
            return (this._rollsContents);
        }

        public function get displayedItems():String{
            return (this._displayedItems);
        }

        public function set displayedItems(_arg1:String):void{
            this._displayedItems = _arg1;
        }


    }
}//package kabam.rotmg.mysterybox.model

