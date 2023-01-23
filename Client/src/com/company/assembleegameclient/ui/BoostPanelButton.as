﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.BoostPanelButton

package com.company.assembleegameclient.ui{
    import flash.display.Sprite;
    import com.company.assembleegameclient.objects.Player;
    import com.company.util.AssetLibrary;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import flash.display.Bitmap;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class BoostPanelButton extends Sprite {

        public static const IMAGE_SET_NAME:String = "lofiInterfaceBig";
        public static const IMAGE_ID:int = 22;

        private var boostPanel:BoostPanel;
        private var player:Player;

        public function BoostPanelButton(_arg1:Player){
            this.player = _arg1;
            var _local2:BitmapData = AssetLibrary.getImageFromSet(IMAGE_SET_NAME, IMAGE_ID);
            var _local3:BitmapData = TextureRedrawer.redraw(_local2, 20, true, 0);
            var _local4:Bitmap = new Bitmap(_local3);
            _local4.x = -7;
            _local4.y = -10;
            addChild(_local4);
            addEventListener(MouseEvent.MOUSE_OVER, this.onButtonOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onButtonOut);
        }

        private function onButtonOver(_arg1:Event):void{
            addChild((this.boostPanel = new BoostPanel(this.player)));
            this.boostPanel.resized.add(this.positionBoostPanel);
            this.positionBoostPanel();
        }

        private function positionBoostPanel():void{
            this.boostPanel.x = -(this.boostPanel.width);
            this.boostPanel.y = -(this.boostPanel.height);
        }

        private function onButtonOut(_arg1:Event):void{
            if (this.boostPanel){
                removeChild(this.boostPanel);
            };
        }


    }
}//package com.company.assembleegameclient.ui

