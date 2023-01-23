// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.widgets.GuildInfoItem

package io.decagames.rotmg.social.widgets{
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import com.company.util.AssetLibrary;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.util.TextureRedrawer;

    public class GuildInfoItem extends BaseInfoItem {

        private var _gName:String;
        private var _gFame:int;

        public function GuildInfoItem(_arg1:String, _arg2:int){
            super(332, 70);
            this._gName = _arg1;
            this._gFame = _arg2;
            this.init();
        }

        private function init():void{
            this.createGuildName();
            this.createGuildFame();
        }

        private function createGuildName():void{
            var _local1:UILabel;
            _local1 = new UILabel();
            _local1.text = this._gName;
            DefaultLabelFormat.guildInfoLabel(_local1, 24);
            _local1.x = ((_width - _local1.width) / 2);
            _local1.y = 12;
            addChild(_local1);
        }

        private function createGuildFame():void{
            var _local1:Sprite;
            var _local3:Bitmap;
            var _local4:UILabel;
            _local1 = new Sprite();
            addChild(_local1);
            var _local2:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 226);
            _local2 = TextureRedrawer.redraw(_local2, 40, true, 0);
            _local3 = new Bitmap(_local2);
            _local3.y = -6;
            _local1.addChild(_local3);
            _local4 = new UILabel();
            _local4.text = this._gFame.toString();
            DefaultLabelFormat.guildInfoLabel(_local4);
            _local4.x = _local3.width;
            _local4.y = 5;
            _local1.addChild(_local4);
            _local1.x = ((_width - _local1.width) / 2);
            _local1.y = 36;
        }


    }
}//package io.decagames.rotmg.social.widgets

