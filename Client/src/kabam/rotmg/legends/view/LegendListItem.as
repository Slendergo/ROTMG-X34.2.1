﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.legends.view.LegendListItem

package kabam.rotmg.legends.view{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import kabam.rotmg.legends.model.Legend;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import flash.filters.DropShadowFilter;
    import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
    import com.company.util.IIterator;
    import com.company.assembleegameclient.ui.Slot;
    import com.company.util.AssetLibrary;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import flash.events.MouseEvent;

    public class LegendListItem extends Sprite {

        private static const FONT_SIZE:int = 22;
        public static const WIDTH:int = 756;
        public static const HEIGHT:int = 56;

        public const selected:Signal = new Signal(Legend);

        private var legend:Legend;
        private var placeText:TextFieldDisplayConcrete;
        private var characterBitmap:Bitmap;
        private var nameText:TextFieldDisplayConcrete;
        private var inventoryGrid:EquippedGrid;
        private var totalFameText:TextFieldDisplayConcrete;
        private var fameIcon:Bitmap;
        private var isOver:Boolean;

        public function LegendListItem(_arg1:Legend){
            this.legend = _arg1;
            this.makePlaceText();
            this.makeCharacterBitmap();
            this.makeNameText();
            this.makeInventory();
            this.makeTotalFame();
            this.makeFameIcon();
            this.addMouseListeners();
            this.draw();
        }

        private function makePlaceText():void{
            this.placeText = new TextFieldDisplayConcrete().setSize(FONT_SIZE).setColor(this.getTextColor());
            var _local1:String = (((this.legend.place)==-1) ? "---" : (this.legend.place.toString() + "."));
            this.placeText.setBold(!((this.legend.place == -1)));
            this.placeText.setStringBuilder(new StaticStringBuilder(_local1));
            this.placeText.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            this.placeText.x = (82 - this.placeText.width);
            this.placeText.y = ((HEIGHT - FONT_SIZE) * 0.5);
            addChild(this.placeText);
        }

        private function makeCharacterBitmap():void{
            this.characterBitmap = new Bitmap(this.legend.character);
            this.characterBitmap.x = (104 + 12);
            this.characterBitmap.y = (((HEIGHT / 2) - (this.characterBitmap.height / 2)) - 2);
            addChild(this.characterBitmap);
        }

        private function makeNameText():void{
            this.nameText = new TextFieldDisplayConcrete().setSize(FONT_SIZE).setColor(this.getTextColor());
            this.nameText.setBold(true);
            this.nameText.setStringBuilder(new StaticStringBuilder(this.legend.name));
            this.nameText.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            this.nameText.x = 170;
            this.nameText.y = ((HEIGHT - FONT_SIZE) * 0.5);
            addChild(this.nameText);
        }

        private function makeInventory():void{
            var _local2:InteractiveItemTile;
            this.inventoryGrid = new EquippedGrid(null, this.legend.equipmentSlots, null);
            var _local1:IIterator = this.inventoryGrid.createInteractiveItemTileIterator();
            while (_local1.hasNext()) {
                _local2 = InteractiveItemTile(_local1.next());
                _local2.setInteractive(false);
            };
            this.inventoryGrid.setItems(this.legend.equipment);
            this.inventoryGrid.x = 400;
            this.inventoryGrid.y = ((HEIGHT / 2) - (Slot.HEIGHT / 2));
            addChild(this.inventoryGrid);
        }

        private function makeTotalFame():void{
            this.totalFameText = new TextFieldDisplayConcrete().setSize(FONT_SIZE).setColor(this.getTextColor());
            this.totalFameText.setBold(true);
            this.totalFameText.setStringBuilder(new StaticStringBuilder(this.legend.totalFame.toString()));
            this.totalFameText.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
            this.totalFameText.x = (660 - this.totalFameText.width);
            this.totalFameText.y = ((HEIGHT - FONT_SIZE) * 0.5);
            addChild(this.totalFameText);
        }

        private function makeFameIcon():void{
            var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 224);
            this.fameIcon = new Bitmap(TextureRedrawer.redraw(_local1, 40, true, 0));
            this.fameIcon.x = 630;
            this.fameIcon.y = ((HEIGHT / 2) - (this.fameIcon.height / 2));
            addChild(this.fameIcon);
        }

        private function getTextColor():uint{
            var _local1:uint;
            if (this.legend.isOwnLegend){
                _local1 = 16564761;
            }
            else {
                if (this.legend.place == 1){
                    _local1 = 16646031;
                }
                else {
                    _local1 = 0xFFFFFF;
                };
            };
            return (_local1);
        }

        private function addMouseListeners():void{
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            addEventListener(MouseEvent.CLICK, this.onClick);
        }

        private function onMouseOver(_arg1:MouseEvent):void{
            this.isOver = true;
            this.draw();
        }

        private function onRollOut(_arg1:MouseEvent):void{
            this.isOver = false;
            this.draw();
        }

        private function onClick(_arg1:MouseEvent):void{
            this.selected.dispatch(this.legend);
        }

        private function draw():void{
            graphics.clear();
            graphics.beginFill(0, ((this.isOver) ? 0.4 : 0.001));
            graphics.drawRect(0, 0, WIDTH, HEIGHT);
            graphics.endFill();
        }


    }
}//package kabam.rotmg.legends.view

