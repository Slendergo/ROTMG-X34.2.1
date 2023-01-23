// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.caretaker.CaretakerQueryDialogCaretaker

package io.decagames.rotmg.pets.components.caretaker{
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;

    public class CaretakerQueryDialogCaretaker extends Sprite {

        private const speechBubble:CaretakerQuerySpeechBubble = makeSpeechBubble();
        private const detailBubble:CaretakerQueryDetailBubble = makeDetailBubble();
        private const icon:Bitmap = makeCaretakerIcon();

        private function makeSpeechBubble():CaretakerQuerySpeechBubble{
            var _local1:CaretakerQuerySpeechBubble;
            _local1 = new CaretakerQuerySpeechBubble(CaretakerQueryDialog.QUERY);
            _local1.x = 60;
            addChild(_local1);
            return (_local1);
        }

        private function makeDetailBubble():CaretakerQueryDetailBubble{
            var _local1:CaretakerQueryDetailBubble = new CaretakerQueryDetailBubble();
            _local1.y = 60;
            return (_local1);
        }

        private function makeCaretakerIcon():Bitmap{
            var _local1:Bitmap = new Bitmap(this.makeDebugBitmapData());
            _local1.x = -16;
            _local1.y = -32;
            addChild(_local1);
            return (_local1);
        }

        private function makeDebugBitmapData():BitmapData{
            return (new BitmapDataSpy(42, 42, true, 0xFF00FF00));
        }

        public function showDetail(_arg1:String):void{
            this.detailBubble.setText(_arg1);
            removeChild(this.speechBubble);
            addChild(this.detailBubble);
        }

        public function showSpeech():void{
            removeChild(this.detailBubble);
            addChild(this.speechBubble);
        }

        public function setCaretakerIcon(_arg1:BitmapData):void{
            this.icon.bitmapData = _arg1;
        }


    }
}//package io.decagames.rotmg.pets.components.caretaker

