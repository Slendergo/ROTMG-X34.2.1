﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.fame.view.FameView

package kabam.rotmg.fame.view{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import flash.display.DisplayObjectContainer;
    import flash.display.Bitmap;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.screens.ScoringBox;
    import com.company.assembleegameclient.screens.ScoreTextLine;
    import com.company.assembleegameclient.screens.TitleMenuOption;
    import io.decagames.rotmg.ui.labels.UILabel;
    import kabam.rotmg.ui.view.components.ScreenBase;
    import kabam.rotmg.text.model.TextKey;
    import flash.text.TextFieldAutoSize;
    import org.osflash.signals.natives.NativeMappedSignal;
    import flash.events.MouseEvent;
    import com.gskinner.motion.GTween;
    import com.company.assembleegameclient.sound.SoundEffectLibrary;
    import flash.display.BitmapData;
    import flash.filters.DropShadowFilter;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import com.company.assembleegameclient.map.GroundLibrary;
    import com.company.rotmg.graphics.FameIconBackgroundDesign;
    import flash.geom.Rectangle;
    import com.company.assembleegameclient.util.FameUtil;
    import com.company.util.BitmapUtil;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import com.company.rotmg.graphics.ScreenGraphic;

    public class FameView extends Sprite {

        public var closed:Signal;
        private var infoContainer:DisplayObjectContainer;
        private var overlayContainer:Bitmap;
        private var title:TextFieldDisplayConcrete;
        private var date:TextFieldDisplayConcrete;
        private var scoringBox:ScoringBox;
        private var finalLine:ScoreTextLine;
        private var continueBtn:TitleMenuOption;
        private var _remainingChallengerCharacters:UILabel;
        private var isAnimation:Boolean;
        private var isFadeComplete:Boolean;
        private var isDataPopulated:Boolean;

        public function FameView(){
            this.init();
        }

        private function init():void{
            addChild(new ScreenBase());
            addChild((this.infoContainer = new Sprite()));
            addChild((this.overlayContainer = new Bitmap()));
            this.continueBtn = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
            this.continueBtn.setAutoSize(TextFieldAutoSize.CENTER);
            this.continueBtn.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.closed = new NativeMappedSignal(this.continueBtn, MouseEvent.CLICK);
        }

        public function setIsAnimation(_arg1:Boolean):void{
            this.isAnimation = _arg1;
        }

        public function setBackground(_arg1:BitmapData):void{
            this.overlayContainer.bitmapData = _arg1;
            var _local2:GTween = new GTween(this.overlayContainer, 2, {alpha:0});
            _local2.onComplete = this.onFadeComplete;
            SoundEffectLibrary.play("death_screen");
        }

        public function clearBackground():void{
            this.overlayContainer.bitmapData = null;
        }

        private function onFadeComplete(_arg1:GTween):void{
            removeChild(this.overlayContainer);
            this.isFadeComplete = true;
            if (this.isDataPopulated){
                this.makeContinueButton();
            };
        }

        public function setCharacterInfo(_arg1:String, _arg2:int, _arg3:int):void{
            this.title = new TextFieldDisplayConcrete().setSize(38).setColor(0xCCCCCC);
            this.title.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
            this.title.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            var _local4:String = ObjectLibrary.typeToDisplayId_[_arg3];
            this.title.setStringBuilder(new LineBuilder().setParams(TextKey.CHARACTER_INFO, {
                name:_arg1,
                level:_arg2,
                type:_local4
            }));
            this.title.x = (stage.stageWidth / 2);
            this.title.y = 225;
            this.infoContainer.addChild(this.title);
        }

        public function setDeathInfo(_arg1:String, _arg2:String):void{
            this.date = new TextFieldDisplayConcrete().setSize(24).setColor(0xCCCCCC);
            this.date.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
            this.date.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            var _local3:LineBuilder = new LineBuilder();
            if (_arg2){
                _local3.setParams(TextKey.DEATH_INFO_LONG, {
                    date:_arg1,
                    killer:this.convertKillerString(_arg2)
                });
            }
            else {
                _local3.setParams(TextKey.DEATH_INFO_SHORT, {date:_arg1});
            };
            this.date.setStringBuilder(_local3);
            this.date.x = (stage.stageWidth / 2);
            this.date.y = 272;
            this.infoContainer.addChild(this.date);
        }

        private function convertKillerString(_arg1:String):String{
            var _local2:Array = _arg1.split(".");
            var _local3:String = _local2[0];
            var _local4:String = _local2[1];
            if (_local4 == null){
                _local4 = _local3;
                switch (_local4){
                    case "lava":
                        _local4 = "Lava";
                        break;
                    case "lava blend":
                        _local4 = "Lava Blend";
                        break;
                    case "liquid evil":
                        _local4 = "Liquid Evil";
                        break;
                    case "evil water":
                        _local4 = "Evil Water";
                        break;
                    case "puke water":
                        _local4 = "Puke Water";
                        break;
                    case "hot lava":
                        _local4 = "Hot Lava";
                        break;
                    case "pure evil":
                        _local4 = "Pure Evil";
                        break;
                    case "lod red tile":
                        _local4 = "lod Red Tile";
                        break;
                    case "lod purple tile":
                        _local4 = "lod Purple Tile";
                        break;
                    case "lod blue tile":
                        _local4 = "lod Blue Tile";
                        break;
                    case "lod green tile":
                        _local4 = "lod Green Tile";
                        break;
                    case "lod cream tile":
                        _local4 = "lod Cream Tile";
                        break;
                };
            }
            else {
                _local4 = _local4.substr(0, (_local4.length - 1));
                _local4 = _local4.replace(/_/g, " ");
                _local4 = _local4.replace(/APOS/g, "'");
                _local4 = _local4.replace(/BANG/g, "!");
            };
            if (ObjectLibrary.getPropsFromId(_local4) != null){
                _local4 = ObjectLibrary.getPropsFromId(_local4).displayId_;
            }
            else {
                if (GroundLibrary.getPropsFromId(_local4) != null){
                    _local4 = GroundLibrary.getPropsFromId(_local4).displayId_;
                };
            };
            return (_local4);
        }

        public function setIcon(_arg1:BitmapData):void{
            var _local2:Sprite;
            _local2 = new Sprite();
            var _local3:Sprite = new FameIconBackgroundDesign();
            _local3.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
            _local2.addChild(_local3);
            var _local4:Bitmap = new Bitmap(_arg1);
            _local4.x = ((_local2.width / 2) - (_local4.width / 2));
            _local4.y = ((_local2.height / 2) - (_local4.height / 2));
            _local2.addChild(_local4);
            _local2.y = 20;
            _local2.x = ((stage.stageWidth / 2) - (_local2.width / 2));
            this.infoContainer.addChild(_local2);
        }

        public function setScore(_arg1:int, _arg2:XML):void{
            this.scoringBox = new ScoringBox(new Rectangle(0, 0, 784, 150), _arg2);
            this.scoringBox.x = 8;
            this.scoringBox.y = 316;
            addChild(this.scoringBox);
            this.infoContainer.addChild(this.scoringBox);
            var _local3:BitmapData = FameUtil.getFameIcon();
            _local3 = BitmapUtil.cropToBitmapData(_local3, 6, 6, (_local3.width - 12), (_local3.height - 12));
            this.finalLine = new ScoreTextLine(24, 0xCCCCCC, 0xFFC800, TextKey.FAMEVIEW_TOTAL_FAME_EARNED, null, 0, _arg1, "", "", new Bitmap(_local3));
            this.finalLine.x = 10;
            this.finalLine.y = 470;
            this.infoContainer.addChild(this.finalLine);
            this.isDataPopulated = true;
            if (((!(this.isAnimation)) || (this.isFadeComplete))){
                this.makeContinueButton();
            };
        }

        public function addRemainingChallengerCharacters(_arg1:int):void{
            this._remainingChallengerCharacters = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._remainingChallengerCharacters, 18, 0xFF0000, TextFormatAlign.LEFT, true);
            this._remainingChallengerCharacters.autoSize = TextFieldAutoSize.LEFT;
            this._remainingChallengerCharacters.text = (("You can create " + _arg1) + " more characters");
            this._remainingChallengerCharacters.x = ((this.width - this._remainingChallengerCharacters.width) / 2);
            this._remainingChallengerCharacters.y = ((this.finalLine.y + this.finalLine.height) - 10);
            this.infoContainer.addChild(this._remainingChallengerCharacters);
        }

        private function makeContinueButton():void{
            this.infoContainer.addChild(new ScreenGraphic());
            this.continueBtn.x = (stage.stageWidth / 2);
            this.continueBtn.y = 550;
            this.infoContainer.addChild(this.continueBtn);
            if (this.isAnimation){
                this.scoringBox.animateScore();
            }
            else {
                this.scoringBox.showScore();
            };
        }

        public function get remainingChallengerCharacters():UILabel{
            return (this._remainingChallengerCharacters);
        }

        public function set remainingChallengerCharacters(_arg1:UILabel):void{
            this._remainingChallengerCharacters = _arg1;
        }


    }
}//package kabam.rotmg.fame.view

