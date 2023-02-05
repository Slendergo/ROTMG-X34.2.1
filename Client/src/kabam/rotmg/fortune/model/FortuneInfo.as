﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.fortune.model.FortuneInfo

package kabam.rotmg.fortune.model{
    import flash.display.DisplayObject;
    import kabam.display.Loader.LoaderProxy;
    import kabam.display.Loader.LoaderProxyConcrete;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;

    public class FortuneInfo {

        public static var chestImageEmbed:Class = FortuneInfo_chestImageEmbed;

        public var _id:String;
        public var _title:String;
        private var _description:String;
        public var _weight:String;
        public var _contents:String;
        private var _priceFirstInGold:String;
        private var _priceFirstInToken:String;
        private var _priceSecondInGold:String;
        public var _iconImageUrl:String;
        private var _iconImage:DisplayObject;
        public var _infoImageUrl:String;
        private var _infoImage:DisplayObject;
        public var _startTime:Date;
        public var _endTime:Date;
        private var _loader:LoaderProxy;
        private var _infoImageLoader:LoaderProxy;
        public var _rollsWithContents:Vector.<Vector.<int>>;
        public var _rollsWithContentsUnique:Vector.<int>;

        public function FortuneInfo(){
            this._loader = new LoaderProxyConcrete();
            this._infoImageLoader = new LoaderProxyConcrete();
            this._rollsWithContents = new Vector.<Vector.<int>>();
            this._rollsWithContentsUnique = new Vector.<int>();
            super();
        }

        public function get id(){
            return (this._id);
        }

        public function set id(_arg1:String):void{
            this._id = _arg1;
        }

        public function get title(){
            return (this._title);
        }

        public function set title(_arg1:String):void{
            this._title = _arg1;
        }

        public function get description(){
            return (this._description);
        }

        public function set description(_arg1:String):void{
            this._description = _arg1;
        }

        public function get weight(){
            return (this._weight);
        }

        public function set weight(_arg1:String):void{
            this._weight = _arg1;
        }

        public function get contents(){
            return (this._contents);
        }

        public function set contents(_arg1:String):void{
            this._contents = _arg1;
        }

        public function get priceFirstInGold():String{
            return (this._priceFirstInGold);
        }

        public function set priceFirstInGold(_arg1:String):void{
            this._priceFirstInGold = _arg1;
        }

        public function get priceFirstInToken():String{
            return (this._priceFirstInToken);
        }

        public function set priceFirstInToken(_arg1:String):void{
            this._priceFirstInToken = _arg1;
        }

        public function get priceSecondInGold():String{
            return (this._priceSecondInGold);
        }

        public function set priceSecondInGold(_arg1:String):void{
            this._priceSecondInGold = _arg1;
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
            this._iconImage = new chestImageEmbed();
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

        public function get startTime(){
            return (this._startTime);
        }

        public function set startTime(_arg1:Date):void{
            this._startTime = _arg1;
        }

        public function get endTime(){
            return (this._endTime);
        }

        public function set endTime(_arg1:Date):void{
            this._endTime = _arg1;
        }

        public function parseContents():void{
            var _local3:String;
            var _local4:Vector.<int>;
            var _local5:Array;
            var _local6:String;
            var _local1:Array = this._contents.split(";");
            var _local2:Dictionary = new Dictionary();
            for each (_local3 in _local1) {
                _local4 = new Vector.<int>();
                _local5 = _local3.split(",");
                for each (_local6 in _local5) {
                    if (_local2[int(_local6)] == null){
                        _local2[int(_local6)] = true;
                        this._rollsWithContentsUnique.push(int(_local6));
                    }
                    _local4.push(int(_local6));
                }
                this._rollsWithContents.push(_local4);
            }
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


    }
}//package kabam.rotmg.fortune.model

