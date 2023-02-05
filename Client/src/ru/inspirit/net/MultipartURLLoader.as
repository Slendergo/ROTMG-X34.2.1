// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//ru.inspirit.net.MultipartURLLoader

package ru.inspirit.net{
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import flash.errors.IllegalOperationError;
    import flash.utils.clearInterval;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLRequestHeader;
    import flash.utils.Endian;
    import ru.inspirit.net.events.MultipartURLLoaderEvent;
    import flash.events.ProgressEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.HTTPStatusEvent;
    import flash.utils.setTimeout;

    public class MultipartURLLoader extends EventDispatcher {

        public static var BLOCK_SIZE:uint = (64 * 0x0400);//65536

        private var _loader:URLLoader;
        private var _boundary:String;
        private var _variableNames:Array;
        private var _fileNames:Array;
        private var _variables:Dictionary;
        private var _files:Dictionary;
        private var _async:Boolean = false;
        private var _path:String;
        private var _data:ByteArray;
        private var _prepared:Boolean = false;
        private var asyncWriteTimeoutId:Number;
        private var asyncFilePointer:uint = 0;
        private var totalFilesSize:uint = 0;
        private var writtenBytes:uint = 0;
        public var requestHeaders:Array;

        public function MultipartURLLoader(){
            this._fileNames = new Array();
            this._files = new Dictionary();
            this._variableNames = new Array();
            this._variables = new Dictionary();
            this._loader = new URLLoader();
            this.requestHeaders = new Array();
        }

        public function load(_arg1:String, _arg2:Boolean=false):void{
            if ((((_arg1 == null)) || ((_arg1 == "")))){
                throw (new IllegalOperationError("You cant load without specifing PATH"));
            }
            this._path = _arg1;
            this._async = _arg2;
            if (this._async){
                if (!this._prepared){
                    this.constructPostDataAsync();
                }
                else {
                    this.doSend();
                }
            }
            else {
                this._data = this.constructPostData();
                this.doSend();
            }
        }

        public function startLoad():void{
            if ((((((this._path == null)) || ((this._path == "")))) || ((this._async == false)))){
                throw (new IllegalOperationError("You can use this method only if loading asynchronous."));
            }
            if (((!(this._prepared)) && (this._async))){
                throw (new IllegalOperationError("You should prepare data before sending when using asynchronous."));
            }
            this.doSend();
        }

        public function prepareData():void{
            this.constructPostDataAsync();
        }

        public function close():void{
            try {
                this._loader.close();
            }
            catch(e:Error) {
            }
        }

        public function addVariable(_arg1:String, _arg2:Object=""):void{
            if (this._variableNames.indexOf(_arg1) == -1){
                this._variableNames.push(_arg1);
            }
            this._variables[_arg1] = _arg2;
            this._prepared = false;
        }

        public function addFile(_arg1:ByteArray, _arg2:String, _arg3:String="Filedata", _arg4:String="application/octet-stream"):void{
            var _local5:FilePart;
            if (this._fileNames.indexOf(_arg2) == -1){
                this._fileNames.push(_arg2);
                this._files[_arg2] = new FilePart(_arg1, _arg2, _arg3, _arg4);
                this.totalFilesSize = (this.totalFilesSize + _arg1.length);
            }
            else {
                _local5 = (this._files[_arg2] as FilePart);
                this.totalFilesSize = (this.totalFilesSize - _local5.fileContent.length);
                _local5.fileContent = _arg1;
                _local5.fileName = _arg2;
                _local5.dataField = _arg3;
                _local5.contentType = _arg4;
                this.totalFilesSize = (this.totalFilesSize + _arg1.length);
            }
            this._prepared = false;
        }

        public function clearVariables():void{
            this._variableNames = new Array();
            this._variables = new Dictionary();
            this._prepared = false;
        }

        public function clearFiles():void{
            var _local1:String;
            for each (_local1 in this._fileNames) {
                (this._files[_local1] as FilePart).dispose();
            }
            this._fileNames = new Array();
            this._files = new Dictionary();
            this.totalFilesSize = 0;
            this._prepared = false;
        }

        public function dispose():void{
            clearInterval(this.asyncWriteTimeoutId);
            this.removeListener();
            this.close();
            this._loader = null;
            this._boundary = null;
            this._variableNames = null;
            this._variables = null;
            this._fileNames = null;
            this._files = null;
            this.requestHeaders = null;
            this._data = null;
        }

        public function getBoundary():String{
            var _local1:int;
            if (this._boundary == null){
                this._boundary = "";
                _local1 = 0;
                while (_local1 < 32) {
                    this._boundary = (this._boundary + String.fromCharCode(int((97 + (Math.random() * 25)))));
                    _local1++;
                }
            }
            return (this._boundary);
        }

        public function get ASYNC():Boolean{
            return (this._async);
        }

        public function get PREPARED():Boolean{
            return (this._prepared);
        }

        public function get dataFormat():String{
            return (this._loader.dataFormat);
        }

        public function set dataFormat(_arg1:String):void{
            if (((((!((_arg1 == URLLoaderDataFormat.BINARY))) && (!((_arg1 == URLLoaderDataFormat.TEXT))))) && (!((_arg1 == URLLoaderDataFormat.VARIABLES))))){
                throw (new IllegalOperationError("Illegal URLLoader Data Format"));
            }
            this._loader.dataFormat = _arg1;
        }

        public function get loader():URLLoader{
            return (this._loader);
        }

        private function doSend():void{
            var _local1:URLRequest = new URLRequest();
            _local1.url = this._path;
            _local1.method = URLRequestMethod.POST;
            _local1.data = this._data;
            _local1.requestHeaders.push(new URLRequestHeader("Content-type", ("multipart/form-data; boundary=" + this.getBoundary())));
            if (this.requestHeaders.length){
                _local1.requestHeaders = _local1.requestHeaders.concat(this.requestHeaders);
            }
            this.addListener();
            this._loader.load(_local1);
        }

        private function constructPostDataAsync():void{
            clearInterval(this.asyncWriteTimeoutId);
            this._data = new ByteArray();
            this._data.endian = Endian.BIG_ENDIAN;
            this._data = this.constructVariablesPart(this._data);
            this.asyncFilePointer = 0;
            this.writtenBytes = 0;
            this._prepared = false;
            if (this._fileNames.length){
                this.nextAsyncLoop();
            }
            else {
                this._data = this.closeDataObject(this._data);
                this._prepared = true;
                dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE));
            }
        }

        private function constructPostData():ByteArray{
            var _local1:ByteArray = new ByteArray();
            _local1.endian = Endian.BIG_ENDIAN;
            _local1 = this.constructVariablesPart(_local1);
            _local1 = this.constructFilesPart(_local1);
            _local1 = this.closeDataObject(_local1);
            return (_local1);
        }

        private function closeDataObject(_arg1:ByteArray):ByteArray{
            _arg1 = this.BOUNDARY(_arg1);
            _arg1 = this.DOUBLEDASH(_arg1);
            return (_arg1);
        }

        private function constructVariablesPart(_arg1:ByteArray):ByteArray{
            var _local2:uint;
            var _local3:String;
            var _local4:String;
            for each (_local4 in this._variableNames) {
                _arg1 = this.BOUNDARY(_arg1);
                _arg1 = this.LINEBREAK(_arg1);
                _local3 = (('Content-Disposition: form-data; name="' + _local4) + '"');
                _local2 = 0;
                while (_local2 < _local3.length) {
                    _arg1.writeByte(_local3.charCodeAt(_local2));
                    _local2++;
                }
                _arg1 = this.LINEBREAK(_arg1);
                _arg1 = this.LINEBREAK(_arg1);
                _arg1.writeUTFBytes(this._variables[_local4]);
                _arg1 = this.LINEBREAK(_arg1);
            }
            return (_arg1);
        }

        private function constructFilesPart(_arg1:ByteArray):ByteArray{
            var _local2:uint;
            var _local3:String;
            var _local4:String;
            if (this._fileNames.length){
                for each (_local4 in this._fileNames) {
                    _arg1 = this.getFilePartHeader(_arg1, (this._files[_local4] as FilePart));
                    _arg1 = this.getFilePartData(_arg1, (this._files[_local4] as FilePart));
                    if (_local2 != (this._fileNames.length - 1)){
                        _arg1 = this.LINEBREAK(_arg1);
                    }
                    _local2++;
                }
                _arg1 = this.closeFilePartsData(_arg1);
            }
            return (_arg1);
        }

        private function closeFilePartsData(_arg1:ByteArray):ByteArray{
            var _local2:uint;
            var _local3:String;
            _arg1 = this.LINEBREAK(_arg1);
            _arg1 = this.BOUNDARY(_arg1);
            _arg1 = this.LINEBREAK(_arg1);
            _local3 = 'Content-Disposition: form-data; name="Upload"';
            _local2 = 0;
            while (_local2 < _local3.length) {
                _arg1.writeByte(_local3.charCodeAt(_local2));
                _local2++;
            }
            _arg1 = this.LINEBREAK(_arg1);
            _arg1 = this.LINEBREAK(_arg1);
            _local3 = "Submit Query";
            _local2 = 0;
            while (_local2 < _local3.length) {
                _arg1.writeByte(_local3.charCodeAt(_local2));
                _local2++;
            }
            _arg1 = this.LINEBREAK(_arg1);
            return (_arg1);
        }

        private function getFilePartHeader(_arg1:ByteArray, _arg2:FilePart):ByteArray{
            var _local3:uint;
            var _local4:String;
            _arg1 = this.BOUNDARY(_arg1);
            _arg1 = this.LINEBREAK(_arg1);
            _local4 = 'Content-Disposition: form-data; name="Filename"';
            _local3 = 0;
            while (_local3 < _local4.length) {
                _arg1.writeByte(_local4.charCodeAt(_local3));
                _local3++;
            }
            _arg1 = this.LINEBREAK(_arg1);
            _arg1 = this.LINEBREAK(_arg1);
            _arg1.writeUTFBytes(_arg2.fileName);
            _arg1 = this.LINEBREAK(_arg1);
            _arg1 = this.BOUNDARY(_arg1);
            _arg1 = this.LINEBREAK(_arg1);
            _local4 = (('Content-Disposition: form-data; name="' + _arg2.dataField) + '"; filename="');
            _local3 = 0;
            while (_local3 < _local4.length) {
                _arg1.writeByte(_local4.charCodeAt(_local3));
                _local3++;
            }
            _arg1.writeUTFBytes(_arg2.fileName);
            _arg1 = this.QUOTATIONMARK(_arg1);
            _arg1 = this.LINEBREAK(_arg1);
            _local4 = ("Content-Type: " + _arg2.contentType);
            _local3 = 0;
            while (_local3 < _local4.length) {
                _arg1.writeByte(_local4.charCodeAt(_local3));
                _local3++;
            }
            _arg1 = this.LINEBREAK(_arg1);
            _arg1 = this.LINEBREAK(_arg1);
            return (_arg1);
        }

        private function getFilePartData(_arg1:ByteArray, _arg2:FilePart):ByteArray{
            _arg1.writeBytes(_arg2.fileContent, 0, _arg2.fileContent.length);
            return (_arg1);
        }

        private function onProgress(_arg1:ProgressEvent):void{
            dispatchEvent(_arg1);
        }

        private function onComplete(_arg1:Event):void{
            this.removeListener();
            dispatchEvent(_arg1);
        }

        private function onIOError(_arg1:IOErrorEvent):void{
            this.removeListener();
            dispatchEvent(_arg1);
        }

        private function onSecurityError(_arg1:SecurityErrorEvent):void{
            this.removeListener();
            dispatchEvent(_arg1);
        }

        private function onHTTPStatus(_arg1:HTTPStatusEvent):void{
            dispatchEvent(_arg1);
        }

        private function addListener():void{
            this._loader.addEventListener(Event.COMPLETE, this.onComplete, false, 0, false);
            this._loader.addEventListener(ProgressEvent.PROGRESS, this.onProgress, false, 0, false);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError, false, 0, false);
            this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.onHTTPStatus, false, 0, false);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError, false, 0, false);
        }

        private function removeListener():void{
            this._loader.removeEventListener(Event.COMPLETE, this.onComplete);
            this._loader.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this._loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.onHTTPStatus);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        }

        private function BOUNDARY(_arg1:ByteArray):ByteArray{
            var _local2:int = this.getBoundary().length;
            _arg1 = this.DOUBLEDASH(_arg1);
            var _local3:int;
            while (_local3 < _local2) {
                _arg1.writeByte(this._boundary.charCodeAt(_local3));
                _local3++;
            }
            return (_arg1);
        }

        private function LINEBREAK(_arg1:ByteArray):ByteArray{
            _arg1.writeShort(3338);
            return (_arg1);
        }

        private function QUOTATIONMARK(_arg1:ByteArray):ByteArray{
            _arg1.writeByte(34);
            return (_arg1);
        }

        private function DOUBLEDASH(_arg1:ByteArray):ByteArray{
            _arg1.writeShort(0x2D2D);
            return (_arg1);
        }

        private function nextAsyncLoop():void{
            var _local1:FilePart;
            if (this.asyncFilePointer < this._fileNames.length){
                _local1 = (this._files[this._fileNames[this.asyncFilePointer]] as FilePart);
                this._data = this.getFilePartHeader(this._data, _local1);
                this.asyncWriteTimeoutId = setTimeout(this.writeChunkLoop, 10, this._data, _local1.fileContent, 0);
                this.asyncFilePointer++;
            }
            else {
                this._data = this.closeFilePartsData(this._data);
                this._data = this.closeDataObject(this._data);
                this._prepared = true;
                dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS, this.totalFilesSize, this.totalFilesSize));
                dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE));
            }
        }

        private function writeChunkLoop(_arg1:ByteArray, _arg2:ByteArray, _arg3:uint=0):void{
            var _local4:uint = Math.min(BLOCK_SIZE, (_arg2.length - _arg3));
            _arg1.writeBytes(_arg2, _arg3, _local4);
            if ((((_local4 < BLOCK_SIZE)) || (((_arg3 + _local4) >= _arg2.length)))){
                _arg1 = this.LINEBREAK(_arg1);
                this.nextAsyncLoop();
                return;
            }
            _arg3 = (_arg3 + _local4);
            this.writtenBytes = (this.writtenBytes + _local4);
            if (((this.writtenBytes % BLOCK_SIZE) * 2) == 0){
                dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS, this.writtenBytes, this.totalFilesSize));
            }
            this.asyncWriteTimeoutId = setTimeout(this.writeChunkLoop, 10, _arg1, _arg2, _arg3);
        }


    }
}//package ru.inspirit.net

import flash.utils.ByteArray;

class FilePart {

    public var fileContent:ByteArray;
    public var fileName:String;
    public var dataField:String;
    public var contentType:String;

    public function FilePart(_arg1:ByteArray, _arg2:String, _arg3:String="Filedata", _arg4:String="application/octet-stream"){
        this.fileContent = _arg1;
        this.fileName = _arg2;
        this.dataField = _arg3;
        this.contentType = _arg4;
    }

    public function dispose():void{
        this.fileContent = null;
        this.fileName = null;
        this.dataField = null;
        this.contentType = null;
    }


}

