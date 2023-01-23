// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.classes.NewClassUnlockNotification

package io.decagames.rotmg.classes{
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.display.Bitmap;
    import com.greensock.TimelineMax;
    import io.decagames.rotmg.ui.labels.UILabel;
    import com.greensock.TweenMax;
    import com.greensock.easing.Bounce;
    import com.greensock.easing.Expo;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flashx.textLayout.formats.TextAlign;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import com.company.assembleegameclient.util.AnimatedChar;
    import flash.display.BitmapData;
    import flash.display.Graphics;

    public class NewClassUnlockNotification extends Sprite {

        private const WIDTH:int = 192;
        private const HEIGHT:int = 192;
        private const NEW_CLASS_UNLOCKED:String = "New Class Unlocked!";

        private var _contentContainer:Sprite;
        private var _whiteSplash:Shape;
        private var _newClass:Bitmap;
        private var _objectTypes:Array;
        private var _timeLineMax:TimelineMax;
        private var _characterName:UILabel;

        public function NewClassUnlockNotification(){
            this.init();
        }

        public function playNotification(_arg1:Array=null):void{
            this._objectTypes = _arg1;
            this.createCharacter();
            this.playAnimation();
        }

        private function playAnimation():void{
            if (!this._timeLineMax){
                this._timeLineMax = new TimelineMax();
                this._timeLineMax.add(TweenMax.to(this._whiteSplash, 0.1, {
                    autoAlpha:1,
                    transformAroundCenter:{
                        scaleX:1,
                        scaleY:1
                    },
                    ease:Bounce.easeOut
                }));
                this._timeLineMax.add(TweenMax.to(this._whiteSplash, 0.1, {
                    alpha:0.4,
                    tint:0,
                    ease:Expo.easeOut
                }));
                this._timeLineMax.add(TweenMax.to(this._contentContainer, 0.2, {
                    autoAlpha:1,
                    transformAroundCenter:{
                        scaleX:1,
                        scaleY:1
                    },
                    ease:Bounce.easeOut
                }));
                this._timeLineMax.add(TweenMax.to(this._contentContainer, 2, {onComplete:this.resetAnimation}));
            }
            else {
                this._timeLineMax.play(0);
            };
        }

        private function resetAnimation():void{
            if (this._objectTypes.length > 0){
                this.createCharacter();
                this.playAnimation();
            }
            else {
                this._timeLineMax.reverse();
            };
        }

        private function createCharacter():void{
            var _local3:XML;
            var _local5:int;
            if (this._newClass){
                this._contentContainer.removeChild(this._newClass);
                this._newClass.bitmapData.dispose();
                this._newClass = null;
            };
            var _local1:int = ObjectLibrary.playerChars_.length;
            var _local2:int = this._objectTypes.shift();
            var _local4:int;
            while (_local4 < _local1) {
                _local3 = ObjectLibrary.playerChars_[_local4];
                _local5 = int(_local3.@type);
                if (_local2 == _local5){
                    this._newClass = new Bitmap(this.getImageBitmapData(_local3));
                    break;
                };
                _local4++;
            };
            if (this._newClass){
                this._newClass.x = ((this.WIDTH - this._newClass.width) / 2);
                this._newClass.y = (((this.HEIGHT - this._newClass.height) / 2) - 20);
                this._contentContainer.addChild(this._newClass);
                if (!this._characterName){
                    this.createCharacterName();
                };
                this._characterName.text = _local3.@id;
                this._characterName.x = ((this.WIDTH - this._characterName.width) / 2);
                this._characterName.y = (((this.HEIGHT - this._characterName.height) / 2) + 20);
            };
        }

        private function createCharacterName():void{
            this._characterName = new UILabel();
            DefaultLabelFormat.notificationLabel(this._characterName, 14, 0xFFFFFF, TextAlign.CENTER, true);
            this._contentContainer.addChild(this._characterName);
        }

        private function createCharacterBackground():void{
            var _local1:Shape;
            var _local2:SliceScalingBitmap;
            _local1 = new Shape();
            _local1.graphics.beginFill(0x545454);
            _local1.graphics.drawRect(0, 0, 105, 105);
            _local1.x = ((this.WIDTH - _local1.width) / 2);
            _local1.y = (((this.HEIGHT - _local1.height) / 2) - 6);
            this._contentContainer.addChild(_local1);
            _local2 = TextureParser.instance.getSliceScalingBitmap("UI", "popup_background_decoration");
            _local2.width = 105;
            _local2.height = 105;
            _local2.x = _local1.x;
            _local2.y = _local1.y;
            this._contentContainer.addChild(_local2);
        }

        private function getImageBitmapData(_arg1:XML):BitmapData{
            var _local2:BitmapData = SavedCharacter.getImage(null, _arg1, AnimatedChar.DOWN, AnimatedChar.STAND, 0, true, false);
            return (_local2);
        }

        private function init():void{
            this.createWhiteSplash();
            this.createContainers();
            this.createCharacterBackground();
            this.createClassUnlockLabel();
        }

        private function createClassUnlockLabel():void{
            var _local1:UILabel;
            _local1 = new UILabel();
            _local1.text = this.NEW_CLASS_UNLOCKED;
            DefaultLabelFormat.notificationLabel(_local1, 18, 0xFF00, TextAlign.CENTER, true);
            _local1.width = this.WIDTH;
            _local1.x = ((this.WIDTH - _local1.width) / 2);
            _local1.y = ((this.HEIGHT - _local1.height) - 12);
            this._contentContainer.addChild(_local1);
        }

        private function createWhiteSplash():void{
            this._whiteSplash = new Shape();
            var _local1:Graphics = this._whiteSplash.graphics;
            _local1.beginFill(0xFFFFFF);
            _local1.drawRect(0, 0, this.WIDTH, this.HEIGHT);
            this._whiteSplash.x = (this._whiteSplash.width / 2);
            this._whiteSplash.y = (this._whiteSplash.height / 2);
            this._whiteSplash.alpha = 0;
            this._whiteSplash.visible = false;
            this._whiteSplash.scaleX = (this._whiteSplash.scaleY = 0);
            addChild(this._whiteSplash);
        }

        private function createContainers():void{
            this._contentContainer = new Sprite();
            this._contentContainer.alpha = 0;
            this._contentContainer.visible = false;
            addChild(this._contentContainer);
        }


    }
}//package io.decagames.rotmg.classes

