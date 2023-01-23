// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.windows.yard.feed.items.FeedItem

package io.decagames.rotmg.pets.windows.yard.feed.items{
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.text.view.BitmapTextFactory;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

    public class FeedItem extends UIGridElement {

        private var _item:InventoryTile;
        private var imageBitmap:Bitmap;
        private var _feedPower:int;
        private var _selected:Boolean;

        public function FeedItem(_arg1:InventoryTile){
            this._item = _arg1;
            this.renderBackground(0x454545, 0.25);
            this.renderItem();
        }

        private function renderBackground(_arg1:uint, _arg2:Number):void{
            graphics.clear();
            graphics.beginFill(_arg1, _arg2);
            graphics.drawRect(0, 0, 40, 40);
        }

        private function renderItem():void{
            var _local4:XML;
            var _local5:BitmapData;
            var _local6:Matrix;
            this.imageBitmap = new Bitmap();
            var _local1:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this._item.getItemId(), 40, true);
            _local1 = _local1.clone();
            var _local2:XML = ObjectLibrary.xmlLibrary_[this._item.getItemId()];
            this._feedPower = _local2.feedPower;
            if (ObjectLibrary.usePatchedData){
                _local4 = ObjectLibrary.xmlPatchLibrary_[this._item.getItemId()];
                if (_local4.hasOwnProperty("feedPower")){
                    this._feedPower = _local4.feedPower;
                };
            };
            var _local3:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
            if (((((_local2) && (_local2.hasOwnProperty("Quantity")))) && (_local3))){
                _local5 = _local3.make(new StaticStringBuilder(String(_local2.Quantity)), 12, 0xFFFFFF, false, new Matrix(), true);
                _local6 = new Matrix();
                _local6.translate(8, 7);
                _local1.draw(_local5, _local6);
            };
            this.imageBitmap.bitmapData = _local1;
            addChild(this.imageBitmap);
        }

        override public function dispose():void{
            super.dispose();
            this.imageBitmap.bitmapData.dispose();
        }

        public function get itemId():int{
            return (this._item.getItemId());
        }

        public function get feedPower():int{
            return (this._feedPower);
        }

        public function get selected():Boolean{
            return (this._selected);
        }

        public function set selected(_arg1:Boolean):void{
            this._selected = _arg1;
            if (_arg1){
                this.renderBackground(15306295, 1);
            }
            else {
                this.renderBackground(0x454545, 0.25);
            };
        }

        public function get item():InventoryTile{
            return (this._item);
        }


    }
}//package io.decagames.rotmg.pets.windows.yard.feed.items

