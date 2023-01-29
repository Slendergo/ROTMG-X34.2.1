// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.tooltip.ClassToolTip

package com.company.assembleegameclient.ui.tooltip{
    import flash.geom.ColorTransform;
    import flash.display.Bitmap;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.ui.LineBreakDesign;
    import kabam.rotmg.core.model.PlayerModel;
    import com.company.assembleegameclient.appengine.CharacterStats;
    import flash.display.Sprite;
    import kabam.rotmg.core.StaticInjectorContext;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import com.company.assembleegameclient.util.AnimatedChars;
    import com.company.assembleegameclient.util.AnimatedChar;
    import com.company.assembleegameclient.util.MaskedImage;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import flash.display.BitmapData;
    import com.company.util.CachingColorTransformer;
    import com.company.util.ConversionUtil;
    import com.company.assembleegameclient.util.EquipmentUtil;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.util.FilterUtil;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.filters.DropShadowFilter;
    import com.company.assembleegameclient.util.FameUtil;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Graphics;
    import com.company.rotmg.graphics.StarGraphic;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import com.company.util.AssetLibrary;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
    import com.company.assembleegameclient.appengine.SavedCharactersList;

    public class ClassToolTip extends ToolTip {

        public static const CLASS_TOOL_TIP_WIDTH:int = 210;
        public static const FULL_STAR:ColorTransform = new ColorTransform(0.8, 0.8, 0.8);
        public static const EMPTY_STAR:ColorTransform = new ColorTransform(0.1, 0.1, 0.1);

        private var portrait_:Bitmap;
        private var nameText_:TextFieldDisplayConcrete;
        private var classQuestText_:TextFieldDisplayConcrete;
        private var classUnlockText_:TextFieldDisplayConcrete;
        private var descriptionText_:TextFieldDisplayConcrete;
        private var lineBreakOne:LineBreakDesign;
        private var lineBreakTwo:LineBreakDesign;
        private var toUnlockText_:TextFieldDisplayConcrete;
        private var unlockText_:TextFieldDisplayConcrete;
        private var nextClassQuest_:TextFieldDisplayConcrete;
        private var showUnlockRequirements:Boolean;
        private var _playerXML:XML;
        private var _playerModel:PlayerModel;
        private var _charStats:CharacterStats;
        private var _equipmentContainer:Sprite;
        private var _progressContainer:Sprite;
        private var _bestContainer:Sprite;
        private var _classUnlockContainer:Sprite;
        private var _numberOfStars:int;
        private var _backgroundColor:Number;
        private var _borderColor:Number;
        private var _lineColor:Number;
        private var _nextStarFame:int;

        public function ClassToolTip(_arg1:XML, _arg2:PlayerModel, _arg3:CharacterStats){
            this._playerXML = _arg1;
            this._playerModel = _arg2;
            this._charStats = _arg3;
            this.showUnlockRequirements = this.shouldShowUnlockRequirements(this._playerModel, this._playerXML);
            this._backgroundColor = 0x363636;
            this._borderColor = 0xFFFFFF;
            this._lineColor = 0x1C1C1C;
//            if (this.showUnlockRequirements){
//                this._backgroundColor = 0x1C1C1C;
//                this._lineColor = (this._borderColor = 0x363636);
//            }
//            else {
//                this._backgroundColor = 0x363636;
//                this._borderColor = 0xFFFFFF;
//                this._lineColor = 0x1C1C1C;
//            };
            super(this._backgroundColor, 1, this._borderColor, 1);
            this.init();
        }

        public static function getDisplayId(_arg1:XML):String{
            return ((((_arg1.DisplayId == undefined)) ? _arg1.@id : _arg1.DisplayId));
        }


        private function init():void{
            var _local1:Boolean = Boolean(StaticInjectorContext.injector.getInstance(SeasonalEventModel).isChallenger);
            this._numberOfStars = (((this._charStats == null)) ? 0 : this._charStats.numStars());
            this.createCharacter();
            this.createEquipmentTypes();
            this.createCharacterName();
            this.lineBreakOne = new LineBreakDesign((CLASS_TOOL_TIP_WIDTH - 6), this._lineColor);
            addChild(this.lineBreakOne);
            if (((this.showUnlockRequirements) && (!(_local1)))){
                this.createUnlockRequirements();
            }
            else {
                this.createClassQuest();
                this.createQuestText();
                this.createStarProgress();
                this.createBestLevelAndFame();
                if (!_local1){
                    this.createClassUnlockTitle();
                    this.createClassUnlocks();
                    if (this._classUnlockContainer.numChildren > 0){
                        this.lineBreakTwo = new LineBreakDesign((CLASS_TOOL_TIP_WIDTH - 6), this._lineColor);
                        addChild(this.lineBreakTwo);
                    };
                };
            };
        }

        private function createCharacter():void{
            var _local1:AnimatedChar = AnimatedChars.getAnimatedChar(String(this._playerXML.AnimatedTexture.File), int(this._playerXML.AnimatedTexture.Index));
            var _local2:MaskedImage = _local1.imageFromDir(AnimatedChar.RIGHT, AnimatedChar.STAND, 0);
            var _local3:int = ((4 / _local2.width()) * 100);
            var _local4:BitmapData = TextureRedrawer.redraw(_local2.image_, _local3, true, 0);
            if (this.showUnlockRequirements){
                _local4 = CachingColorTransformer.transformBitmapData(_local4, new ColorTransform(0, 0, 0, 0.5, 0, 0, 0, 0));
            };
            this.portrait_ = new Bitmap();
            this.portrait_.bitmapData = _local4;
            this.portrait_.x = -4;
            this.portrait_.y = -4;
            addChild(this.portrait_);
        }

        private function createEquipmentTypes():void{
            var _local4:int;
            var _local5:BitmapData;
            var _local6:Bitmap;
            var _local7:Bitmap;
            this._equipmentContainer = new Sprite();
            addChild(this._equipmentContainer);
            var _local1:Vector.<int> = ConversionUtil.toIntVector(this._playerXML.SlotTypes);
            var _local2:Vector.<int> = ConversionUtil.toIntVector(this._playerXML.Equipment);
            var _local3:int;
            while (_local3 < EquipmentUtil.NUM_SLOTS) {
                _local4 = _local2[_local3];
                if (_local4 > -1){
                    _local5 = ObjectLibrary.getRedrawnTextureFromType(_local4, 40, true);
                    _local6 = new Bitmap(_local5);
                    _local6.x = (_local3 * 22);
                    _local6.y = -12;
                    this._equipmentContainer.addChild(_local6);
                }
                else {
                    _local7 = EquipmentUtil.getEquipmentBackground(_local1[_local3], 2);
                    if (_local7){
                        _local7.x = (12 + (_local3 * 22));
                        _local7.filters = FilterUtil.getDarkGreyColorFilter();
                        this._equipmentContainer.addChild(_local7);
                    }
                }
                _local3++;
            };
        }

        private function createCharacterName():void{
            this.nameText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xFFFFFF);
            this.nameText_.setBold(true);
            this.nameText_.setStringBuilder(new LineBuilder().setParams(getDisplayId(this._playerXML)));
            this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.nameText_.textChanged);
            addChild(this.nameText_);
            this.descriptionText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3).setWordWrap(true).setMultiLine(true).setTextWidth(174);
            this.descriptionText_.setStringBuilder(new LineBuilder().setParams(this._playerXML.Description));
            this.descriptionText_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.descriptionText_.textChanged);
            addChild(this.descriptionText_);
        }

        private function createClassQuest():void{
            this.classQuestText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xFFFFFF);
            this.classQuestText_.setBold(true);
            this.classQuestText_.setStringBuilder(new LineBuilder().setParams("Class Quest"));
            this.classQuestText_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.classQuestText_.textChanged);
            addChild(this.classQuestText_);
        }

        private function createQuestText():void{
            this._nextStarFame = FameUtil.nextStarFame((((this._charStats == null)) ? 0 : this._charStats.bestFame()), 0);
            if (this._nextStarFame > 0){
                this.nextClassQuest_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(160).setMultiLine(true).setWordWrap(true);
                if (this._numberOfStars > 0){
                    this.nextClassQuest_.setStringBuilder(new LineBuilder().setParams("Earn {nextStarFame} Fame with {typeToDisplay} to unlock the next Star", {
                        nextStarFame:this._nextStarFame,
                        typeToDisplay:getDisplayId(this._playerXML)
                    }));
                }
                else {
                    this.nextClassQuest_.setStringBuilder(new LineBuilder().setParams("Earn 20 Fame with {typeToDisplay} to unlock the first star", {typeToDisplay:getDisplayId(this._playerXML)}));
                };
                this.nextClassQuest_.filters = [new DropShadowFilter(0, 0, 0)];
                waiter.push(this.nextClassQuest_.textChanged);
                addChild(this.nextClassQuest_);
            };
        }

        private function createStarProgress():void{
            var _local6:int;
            var _local7:int;
            var _local8:Number;
            var _local9:Boolean;
            var _local10:int;
            var _local11:Sprite;
            var _local12:UILabel;
            var _local13:int;
            this._progressContainer = new Sprite();
            var _local1:Graphics = this._progressContainer.graphics;
            addChild(this._progressContainer);
            var _local2:int;
            var _local3:Vector.<int> = FameUtil.STARS;
            var _local4:int = _local3.length;
            var _local5:int;
            while (_local5 < _local4) {
                _local6 = _local3[_local5];
                _local7 = (((this._charStats)!=null) ? this._charStats.bestFame() : 0);
                _local8 = (((_local7 >= _local6)) ? 0xFF00 : 16549442);
                _local9 = (_local5 < this._numberOfStars);
                _local10 = (20 + (_local5 * 10));
                _local11 = new StarGraphic();
                _local11.x = (_local2 + ((_local10 - _local11.width) / 2));
                _local11.transform.colorTransform = ((_local9) ? FULL_STAR : EMPTY_STAR);
                this._progressContainer.addChild(_local11);
                _local12 = new UILabel();
                _local12.text = _local6.toString();
                DefaultLabelFormat.characterToolTipLabel(_local12, _local8);
                _local12.x = (_local2 + ((_local10 - _local12.width) / 2));
                _local12.y = 14;
                this._progressContainer.addChild(_local12);
                _local1.beginFill(0x1C1C1C);
                _local1.drawRect(_local2, 31, _local10, 4);
                if (_local7 > 0){
                    _local1.beginFill(_local8);
                    if (_local7 >= _local6){
                        _local1.drawRect(_local2, 31, _local10, 4);
                    }
                    else {
                        if (_local5 == 0){
                            _local13 = ((_local7 / _local6) * _local10);
                            _local1.drawRect(_local2, 31, _local13, 4);
                        }
                        else {
                            if (_local7 > _local3[(_local5 - 1)]){
                                _local13 = (((_local7 - _local3[(_local5 - 1)]) / (_local6 - _local3[(_local5 - 1)])) * _local10);
                                _local1.drawRect(_local2, 31, _local13, 4);
                            };
                        };
                    };
                };
                _local2 = (_local2 + (1 + _local10));
                _local5++;
            };
        }

        private function createBestLevelAndFame():void{
            this._bestContainer = new Sprite();
            addChild(this._bestContainer);
            var _local1:UILabel = new UILabel();
            _local1.text = "Best Level";
            DefaultLabelFormat.characterToolTipLabel(_local1, 0xFFFFFF);
            this._bestContainer.addChild(_local1);
            var _local2:UILabel = new UILabel();
            _local2.text = (((this._charStats)!=null) ? this._charStats.bestLevel() : 0).toString();
            DefaultLabelFormat.characterToolTipLabel(_local2, 0xFFFFFF);
            _local2.x = (CLASS_TOOL_TIP_WIDTH - 24);
            this._bestContainer.addChild(_local2);
            var _local3:UILabel = new UILabel();
            _local3.text = "Best Fame";
            DefaultLabelFormat.characterToolTipLabel(_local3, 0xFFFFFF);
            _local3.y = 18;
            this._bestContainer.addChild(_local3);
            var _local4:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 224);
            _local4 = TextureRedrawer.redraw(_local4, 40, true, 0);
            var _local5:Bitmap = new Bitmap(_local4);
            _local5.x = (CLASS_TOOL_TIP_WIDTH - 36);
            _local5.y = (_local3.y - 10);
            this._bestContainer.addChild(_local5);
            var _local6:UILabel = new UILabel();
            _local6.text = (((this._charStats)!=null) ? this._charStats.bestFame() : 0).toString();
            DefaultLabelFormat.characterToolTipLabel(_local6, 0xFFFFFF);
            _local6.x = (_local5.x - _local6.width);
            _local6.y = _local3.y;
            this._bestContainer.addChild(_local6);
        }

        private function createClassUnlockTitle():void{
            this.classUnlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xFFFFFF);
            this.classUnlockText_.setBold(true);
            this.classUnlockText_.setStringBuilder(new LineBuilder().setParams("Class Unlocks"));
            this.classUnlockText_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.classUnlockText_.textChanged);
            this.classUnlockText_.visible = false;
            addChild(this.classUnlockText_);
        }

        private function createClassUnlocks():void{
            var _local7:XML;
            var _local8:String;
            var _local9:XML;
            var _local10:int;
            var _local11:Number;
            var _local12:UILabel;
            this._classUnlockContainer = new Sprite();
            var _local1:int = ObjectLibrary.playerChars_.length;
            var _local2:Vector.<XML> = ObjectLibrary.playerChars_;
            var _local3:String = this._playerXML.@id;
            var _local4:int = (((this._charStats)!=null) ? this._charStats.bestLevel() : 0);
            var _local5:int;
            var _local6:int;
            while (_local6 < _local1) {
                _local7 = _local2[_local6];
                _local8 = _local7.@id;
                if (((!((_local3 == _local8))) && (_local7.UnlockLevel))){
                    for each (_local9 in _local7.UnlockLevel) {
                        if (_local3 == _local9.toString()){
                            _local10 = int(_local9.@level);
                            _local11 = (((_local4)>=_local10) ? 0xFF00 : 0xFF0000);
                            _local12 = new UILabel();
                            _local12.text = ((("Reach level " + _local10.toString()) + " to unlock ") + _local8);
                            DefaultLabelFormat.characterToolTipLabel(_local12, _local11);
                            _local12.y = _local5;
                            this._classUnlockContainer.addChild(_local12);
                            _local5 = (_local5 + 14);
                        };
                    };
                };
                _local6++;
            };
            addChild(this._classUnlockContainer);
        }

        private function createUnlockRequirements():void{
            var _local2:XML;
            var _local3:int;
            var _local4:int;
            this.toUnlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3).setTextWidth(174).setBold(true);
            this.toUnlockText_.setStringBuilder(new LineBuilder().setParams(TextKey.TO_UNLOCK));
            this.toUnlockText_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.toUnlockText_.textChanged);
            addChild(this.toUnlockText_);
            this.unlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(174).setWordWrap(false).setMultiLine(true);
            var _local1:AppendingLineBuilder = new AppendingLineBuilder();
            for each (_local2 in this._playerXML.UnlockLevel) {
                _local3 = ObjectLibrary.idToType_[_local2.toString()];
                _local4 = int(_local2.@level);
                if (this._playerModel.getBestLevel(_local3) < int(_local2.@level)){
                    _local1.pushParams(TextKey.TO_UNLOCK_REACH_LEVEL, {
                        unlockLevel:_local4,
                        typeToDisplay:ObjectLibrary.typeToDisplayId_[_local3]
                    });
                };
            };
            this.unlockText_.setStringBuilder(_local1);
            this.unlockText_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.unlockText_.textChanged);
            addChild(this.unlockText_);
        }

        override protected function alignUI():void{
            this.nameText_.x = 32;
            this.nameText_.y = 6;
            this.descriptionText_.x = 8;
            this.descriptionText_.y = 40;
            this.lineBreakOne.x = 6;
            this.lineBreakOne.y = height;
            if (this.showUnlockRequirements){
                this.toUnlockText_.x = 8;
                this.toUnlockText_.y = (height - 2);
                this.unlockText_.x = 12;
                this.unlockText_.y = (height - 4);
            }
            else {
                this.classQuestText_.x = 6;
                this.classQuestText_.y = (height - 2);
                if (this._nextStarFame > 0){
                    this.nextClassQuest_.x = 8;
                    this.nextClassQuest_.y = (height - 4);
                };
                this._progressContainer.x = 10;
                this._progressContainer.y = (height - 2);
                this._bestContainer.x = 6;
                this._bestContainer.y = height;
                if (this.lineBreakTwo){
                    this.lineBreakTwo.x = 6;
                    this.lineBreakTwo.y = (height - 10);
                    this.classUnlockText_.visible = true;
                    this.classUnlockText_.x = 6;
                    this.classUnlockText_.y = height;
                    this._classUnlockContainer.x = 6;
                    this._classUnlockContainer.y = (height - 6);
                };
            };
            this.draw();
            position();
        }

        private function shouldShowUnlockRequirements(_arg1:PlayerModel, _arg2:XML):Boolean{
            var _local3:Boolean = _arg1.isClassAvailability(String(_arg2.@id), SavedCharactersList.UNRESTRICTED);
            var _local4:Boolean = _arg1.isLevelRequirementsMet(int(_arg2.@type));
            return (((!(_local3)) && (!(_local4))));
        }

        override public function draw():void{
            this.lineBreakOne.setWidthColor(CLASS_TOOL_TIP_WIDTH, this._lineColor);
            ((this.lineBreakTwo) && (this.lineBreakTwo.setWidthColor(CLASS_TOOL_TIP_WIDTH, this._lineColor)));
            this._equipmentContainer.x = ((CLASS_TOOL_TIP_WIDTH - this._equipmentContainer.width) + 10);
            this._equipmentContainer.y = 6;
            super.draw();
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

