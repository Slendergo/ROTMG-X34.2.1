// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.pets.view.components.DialogCloseButton

package kabam.rotmg.pets.view.components{
    import flash.display.Sprite;

import kabam.rotmg.assets.EmbeddedAssets;

import org.osflash.signals.Signal;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;

    public class DialogCloseButton extends Sprite {

        public const clicked:Signal = new Signal();
        public const closeClicked:Signal = new Signal();

        public var disabled:Boolean = false;

        public function DialogCloseButton(_arg1:Number=-1){
            var _local2:DisplayObject;
            super();
            if (_arg1 < 0){
                addChild(new EmbeddedAssets.CloseButtonAsset());
            }
            else {
                _local2 = new EmbeddedAssets.CloseButtonLargeAsset();
                addChild(new EmbeddedAssets.CloseButtonLargeAsset());
                scaleX = (scaleX * _arg1);
                scaleY = (scaleY * _arg1);
            };
            buttonMode = true;
            addEventListener(MouseEvent.CLICK, this.onClicked);
        }

        public function setDisabled(_arg1:Boolean):void{
            this.disabled = _arg1;
            if (_arg1){
                removeEventListener(MouseEvent.CLICK, this.onClicked);
            }
            else {
                addEventListener(MouseEvent.CLICK, this.onClicked);
            };
        }

        public function disableLegacyCloseBehavior():void{
            this.disabled = true;
            removeEventListener(MouseEvent.CLICK, this.onClicked);
        }

        private function onClicked(_arg1:MouseEvent):void{
            if (!this.disabled){
                removeEventListener(MouseEvent.CLICK, this.onClicked);
                this.closeClicked.dispatch();
                this.clicked.dispatch();
            };
        }


    }
}//package kabam.rotmg.pets.view.components

