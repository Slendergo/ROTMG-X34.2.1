// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.mysteryBox.contentPopup.ItemsSetBox

package io.decagames.rotmg.shop.mysteryBox.contentPopup{
    import io.decagames.rotmg.ui.gird.UIGridElement;

    public class ItemsSetBox extends UIGridElement {

        private var items:Vector.<ItemBox>;

        public function ItemsSetBox(_arg1:Vector.<ItemBox>){
            var _local3:ItemBox;
            super();
            this.items = _arg1;
            var _local2:int;
            for each (_local3 in _arg1) {
                _local3.y = _local2;
                addChild(_local3);
                _local2 = (_local2 + _local3.height);
            }
            this.drawBackground(260);
        }

        private function drawBackground(_arg1:int):void{
            this.graphics.clear();
            this.graphics.lineStyle(1, 10915138);
            this.graphics.beginFill(0x2D2D2D);
            this.graphics.drawRect(0, 0, _arg1, (this.items.length * 48));
            this.graphics.endFill();
        }

        override public function get height():Number{
            return ((this.items.length * 48));
        }

        override public function resize(_arg1:int, _arg2:int=-1):void{
            this.drawBackground(_arg1);
        }

        override public function dispose():void{
            var _local1:ItemBox;
            for each (_local1 in this.items) {
                _local1.dispose();
            }
            this.items = null;
            super.dispose();
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

