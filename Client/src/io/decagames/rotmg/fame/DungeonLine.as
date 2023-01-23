// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.fame.DungeonLine

package io.decagames.rotmg.fame{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.objects.TextureDataConcrete;
    import com.company.assembleegameclient.util.TextureRedrawer;

    public class DungeonLine extends StatsLine {

        private var dungeonTextureName:String;
        private var dungeonBitmap:Bitmap;

        public function DungeonLine(_arg1:String, _arg2:String, _arg3:String){
            this.dungeonTextureName = _arg2;
            super(_arg1, _arg3, "", StatsLine.TYPE_STAT);
        }

        override protected function setLabelsPosition():void{
            var _local2:BitmapData;
            var _local1:TextureDataConcrete = ObjectLibrary.dungeonToPortalTextureData_[this.dungeonTextureName];
            if (_local1){
                _local2 = _local1.getTexture();
                _local2 = TextureRedrawer.redraw(_local2, 40, true, 0, false);
                this.dungeonBitmap = new Bitmap(_local2);
                this.dungeonBitmap.x = (-(Math.round((_local2.width / 2))) + 13);
                this.dungeonBitmap.y = (-(Math.round((_local2.height / 2))) + 11);
                addChild(this.dungeonBitmap);
            };
            label.y = 4;
            label.x = 24;
            lineHeight = 25;
            if (fameValue){
                fameValue.y = 4;
            };
            if (lock){
                lock.y = -6;
            };
        }

        override public function clean():void{
            super.clean();
            if (this.dungeonBitmap){
                this.dungeonBitmap.bitmapData.dispose();
            };
        }


    }
}//package io.decagames.rotmg.fame

