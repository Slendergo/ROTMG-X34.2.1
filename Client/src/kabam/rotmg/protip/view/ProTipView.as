﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.protip.view.ProTipView

package kabam.rotmg.protip.view{
    import flash.display.Sprite;
    import flash.filters.GlowFilter;
    import com.gskinner.motion.GTween;

    public class ProTipView extends Sprite {

        private var text:ProTipText;

        public function ProTipView(){
            this.text = new ProTipText();
            this.text.x = 300;
            this.text.y = 125;
            addChild(this.text);
            filters = [new GlowFilter(0, 1, 3, 3, 2, 1)];
            mouseEnabled = false;
            mouseChildren = false;
        }

        public function setTip(_arg1:String):void{
            this.text.setTip(_arg1);
            var _local2:GTween = new GTween(this, 5, {alpha:0});
            _local2.delay = 5;
            _local2.onComplete = this.removeSelf;
        }

        private function removeSelf(_arg1:GTween):void{
            ((parent) && (parent.removeChild(this)));
        }


    }
}//package kabam.rotmg.protip.view

