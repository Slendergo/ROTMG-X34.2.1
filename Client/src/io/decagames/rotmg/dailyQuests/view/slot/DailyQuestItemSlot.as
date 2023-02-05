// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot

package io.decagames.rotmg.dailyQuests.view.slot{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.BitmapTextFactory;
    import flash.display.Shape;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import io.decagames.rotmg.utils.colors.GreyScale;
    import flash.display.*;
    import flash.geom.*;
    import flash.filters.*;

    public class DailyQuestItemSlot extends Sprite {

        public static const SELECTED_BORDER_SIZE:int = 2;
        public static const SLOT_SIZE:int = 40;

        private var _itemID:int;
        private var _type:String;
        private var bitmapFactory:BitmapTextFactory;
        private var imageContainer:Sprite;
        private var _isSlotsSelectable:Boolean;
        private var _selected:Boolean;
        private var backgroundShape:Shape;
        private var hasItem:Boolean;
        private var imageBitmap:Bitmap;

        public function DailyQuestItemSlot(_arg1:int, _arg2:String, _arg3:Boolean=false, _arg4:Boolean=false){
            this._itemID = _arg1;
            this._type = _arg2;
            this._isSlotsSelectable = _arg4;
            this.hasItem = _arg3;
            this.imageBitmap = new Bitmap();
            this.imageContainer = new Sprite();
            addChild(this.imageContainer);
            this.imageContainer.x = Math.round((SLOT_SIZE / 2));
            this.imageContainer.y = Math.round((SLOT_SIZE / 2));
            this.createBackground();
            this.renderItem();
        }

        private function createBackground():void{
            if (!this.backgroundShape){
                this.backgroundShape = new Shape();
                this.imageContainer.addChild(this.backgroundShape);
            }
            this.backgroundShape.graphics.clear();
            if (this.isSlotsSelectable){
                if (this._selected){
                    this.backgroundShape.graphics.beginFill(14846006, 1);
                    this.backgroundShape.graphics.drawRect(-(SELECTED_BORDER_SIZE), -(SELECTED_BORDER_SIZE), (SLOT_SIZE + (SELECTED_BORDER_SIZE * 2)), (SLOT_SIZE + (SELECTED_BORDER_SIZE * 2)));
                    this.backgroundShape.graphics.beginFill(14846006, 1);
                }
                else {
                    this.backgroundShape.graphics.beginFill(0x454545, 1);
                }
            }
            else {
                this.backgroundShape.graphics.beginFill(((this.hasItem) ? 0x13A000 : 0x454545), 1);
            }
            this.backgroundShape.graphics.drawRect(0, 0, SLOT_SIZE, SLOT_SIZE);
            this.backgroundShape.x = -(Math.round(((SLOT_SIZE + (SELECTED_BORDER_SIZE * 2)) / 2)));
            this.backgroundShape.y = -(Math.round(((SLOT_SIZE + (SELECTED_BORDER_SIZE * 2)) / 2)));
        }

        private function renderItem():void{
            var _local3:BitmapData;
            var _local4:Matrix;
            if (this.imageBitmap.bitmapData){
                this.imageBitmap.bitmapData.dispose();
            }
            var _local1:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this._itemID, (SLOT_SIZE * 2), true);
            _local1 = _local1.clone();
            var _local2:XML = ObjectLibrary.xmlLibrary_[this._itemID];
            this.bitmapFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
            if (((((_local2) && (_local2.hasOwnProperty("Quantity")))) && (this.bitmapFactory))){
                _local3 = this.bitmapFactory.make(new StaticStringBuilder(String(_local2.Quantity)), 12, 0xFFFFFF, false, new Matrix(), true);
                _local4 = new Matrix();
                _local4.translate(8, 7);
                _local1.draw(_local3, _local4);
            }
            this.imageBitmap.bitmapData = _local1;
            if (((this.isSlotsSelectable) && (!(this._selected)))){
                GreyScale.setGreyScale(_local1);
            }
            if (!this.imageBitmap.parent){
                this.imageBitmap.x = -(Math.round((this.imageBitmap.width / 2)));
                this.imageBitmap.y = -(Math.round((this.imageBitmap.height / 2)));
                this.imageContainer.addChild(this.imageBitmap);
            }
        }

        public function set selected(_arg1:Boolean):void{
            this._selected = _arg1;
            this.createBackground();
            this.renderItem();
        }

        public function dispose():void{
            if (((this.imageBitmap) && (this.imageBitmap.bitmapData))){
                this.imageBitmap.bitmapData.dispose();
            }
        }

        public function get itemID():int{
            return (this._itemID);
        }

        public function get type():String{
            return (this._type);
        }

        public function get isSlotsSelectable():Boolean{
            return (this._isSlotsSelectable);
        }

        public function get selected():Boolean{
            return (this._selected);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.slot

