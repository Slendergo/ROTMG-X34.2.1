// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.net.impl.SocketServer

package kabam.lib.net.impl{
import avmplus.parameterXml;

import flash.utils.Endian;

import kabam.rotmg.messaging.impl.GameServerConnection;

import org.osflash.signals.Signal;
    import flash.utils.ByteArray;
    import kabam.lib.net.api.MessageProvider;
    import flash.net.Socket;
    import flash.utils.Timer;
    import com.hurlant.crypto.symmetric.ICipher;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import com.company.assembleegameclient.parameters.Parameters;

    public class SocketServer {

        public static const MESSAGE_LENGTH_SIZE_IN_BYTES:int = 4;

        public const connected:Signal = new Signal();
        public const closed:Signal = new Signal();
        public const error:Signal = new Signal(String);
        private const unsentPlaceholder:Message = new Message(0);
        private const data:ByteArray = new ByteArray();

        [Inject]
        public var messages:MessageProvider;
        [Inject]
        public var socket:Socket;
        [Inject]
        public var socketServerModel:SocketServerModel;
        public var delayTimer:Timer;
        private var head:Message;
        private var tail:Message;
        private var server:String;
        private var port:int;
        private var gsc_:GameServerConnection;

        public function SocketServer(){
            this.head = this.unsentPlaceholder;
            this.tail = this.unsentPlaceholder;
            super();
        }

        public function connect(_arg1:String, _arg2:int, gsc:GameServerConnection):void{
            server = _arg1;
            port = _arg2;
            gsc_ = gsc;

            addListeners();

            data.length = 0;

            if (socketServerModel.connectDelayMS){
                connectWithDelay();
            }
            else {
                socket.connect(_arg1, _arg2);
            }

            if(Parameters.LITTLE_ENDIAN) {
                socket.endian = Endian.LITTLE_ENDIAN;
                data.endian = Endian.LITTLE_ENDIAN;
            }
        }

        private function addListeners(): void {
            this.socket.addEventListener(Event.CONNECT, this.onConnect);
            this.socket.addEventListener(Event.CLOSE, this.onClose);
            this.socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
            this.socket.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        }

        private function connectWithDelay():void{
            this.delayTimer = new Timer(this.socketServerModel.connectDelayMS, 1);
            this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this.delayTimer.start();
        }

        private function onTimerComplete(_arg1:TimerEvent):void{
            this.delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this.socket.connect(this.server, this.port);
        }

        public function disconnect():void{
            if (this.socket.connected){
                this.socket.close();
            }
            this.removeListeners();
            this.closed.dispatch();
        }

        private function removeListeners():void{
            this.socket.removeEventListener(Event.CONNECT, this.onConnect);
            this.socket.removeEventListener(Event.CLOSE, this.onClose);
            this.socket.removeEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
            this.socket.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        }

        public function sendMessage(_arg1:Message):void{
            this.tail.next = _arg1;
            this.tail = _arg1;
            ((this.socket.connected) && (this.sendPendingMessages()));
        }

        private function sendPendingMessages():void{
            var _local1:Message = this.head.next;
            var _local2:Message = _local1;
            while (_local2) {
                data.clear();
                _local2.writeToOutput(data);
                data.position = 0;
//                socket.writeInt((data.bytesAvailable + 5));
                socket.writeByte(_local2.id);
                socket.writeBytes(data);
                _local2.consume();
                _local2 = _local2.next;
            }
            socket.flush();
            unsentPlaceholder.next = null;
            unsentPlaceholder.prev = null;
            head = (this.tail = this.unsentPlaceholder);
        }

        private function onConnect(_arg1:Event):void{
            this.sendPendingMessages();
            this.connected.dispatch();
        }

        private function onClose(_arg1:Event):void{
            this.closed.dispatch();
        }

        private function onIOError(_arg1:IOErrorEvent):void{
            var _local2:String = this.parseString("Socket-Server IO Error: {0}", [_arg1.text]);
            this.error.dispatch(_local2);
            this.closed.dispatch();
        }

        private function onSecurityError(_arg1:SecurityErrorEvent):void{
            var _local2:String = this.parseString((("Socket-Server Security: {0}. Please open port " + Parameters.PORT) + " in your firewall and/or router settings and try again"), [_arg1.text]);
            this.error.dispatch(_local2);
            this.closed.dispatch();
        }

        private function onSocketData(_arg1:ProgressEvent=null):void {

            // todo remove the message pool system
            while (true) {
                if (socket == null || !socket.connected || socket.bytesAvailable == 0) {
                    break;
                }

                try {
                    var messageId:uint = socket.readUnsignedByte();
                    if (gsc_.handleMessage(messageId, socket)) {
                        continue;
                    }

                    var message:Message = messages.require(messageId);
                    message.parseFromInput(socket);
                    message.consume();
                }
                catch(e:Error) {
                    logErrorAndClose("Socket-Server Error: ID: {0} | {1}: {2}", [messageId, e.name, e.message]);
                }
            }
        }

        private function logErrorAndClose(_arg1:String, _arg2:Array=null):void{
            var string:String = parseString(_arg1, _arg2);
            trace(string);
            error.dispatch(string);
            this.disconnect();
        }

        private function parseString(_arg1:String, _arg2:Array):String{
            var _local3:int = _arg2.length;
            var _local4:int;
            while (_local4 < _local3) {
                _arg1 = _arg1.replace((("{" + _local4) + "}"), _arg2[_local4]);
                _local4++;
            }
            return (_arg1);
        }

        public function isConnected():Boolean{
            return (this.socket.connected);
        }


    }
}//package kabam.lib.net.impl

