// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.view.RealmQuestsDisplay

package kabam.rotmg.game.view{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Graphics;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.map.AbstractMap;
    import com.company.assembleegameclient.parameters.Parameters;
    import flash.utils.getTimer;
    import com.company.assembleegameclient.objects.GameObject;
    import flash.events.MouseEvent;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import flash.filters.DropShadowFilter;
    import com.greensock.TweenMax;
    import kabam.rotmg.game.model.QuestModel;

    public class RealmQuestsDisplay extends Sprite {

        public static const NUMBER_OF_QUESTS:int = 3;

        private const CONTENT_ALPHA:Number = 0.7;
        private const QUEST_DESCRIPTION:String = "Free %s from Oryx's Minions!";
        private const REQUIREMENT_TEXT_01:String = "Reach <font color='#00FF00'><b>Level 20</b></font> and become stronger.";
        private const REQUIREMENT_TEXT_02:String = "Defeat <font color='#00FF00'><b>%d remaining</b></font> Heroes of Oryx.";
        private const REQUIREMENT_TEXT_03:String = "Defeat <font color='#00FF00'><b>Oryx the Mad God</b></font> in his Castle.";
        private const REQUIREMENTS_TEXTS:Vector.<String> = new <String>[REQUIREMENT_TEXT_01, REQUIREMENT_TEXT_02, REQUIREMENT_TEXT_03];

        private var _realmLabel:UILabel;
        private var _realmName:String;
        private var _isOpen:Boolean;
        private var _content:Sprite;
        private var _buttonContainer:Sprite;
        private var _buttonContainerGraphics:Graphics;
        private var _buttonDiamondContainer:Sprite;
        private var _buttonNameContainer:Sprite;
        private var _buttonContent:Sprite;
        private var _arrow:Bitmap;
        private var _realmQuestDiamonds:Vector.<Bitmap>;
        private var _realmQuestItems:Vector.<RealmQuestItem>;
        private var _map:AbstractMap;
        private var _requirementsStates:Vector.<Boolean>;
        private var _currentQuestHero:String;

        public function RealmQuestsDisplay(_arg1:AbstractMap){
            this.tabChildren = false;
            this._map = _arg1;
        }

        public function toggleOpenState():void{
            this._isOpen = !(this._isOpen);
            this.alphaTweenContent(this.CONTENT_ALPHA);
            this._arrow.scaleY = ((this._isOpen) ? 1 : -1);
            this._arrow.y = ((this._isOpen) ? 3 : (this._arrow.height + 2));
            this._buttonDiamondContainer.visible = !(this._isOpen);
            this._buttonNameContainer.visible = this._isOpen;
            this._buttonContent.visible = this._isOpen;
            Parameters.data_.expandRealmQuestsDisplay = this._isOpen;
        }

        public function init():void{
            var _local1:GameObject = this._map.quest_.getObject(int(getTimer()));
            if (_local1){
                this._currentQuestHero = this._map.quest_.getObject(int(getTimer())).name_;
            }
            this.createContainers();
            this.createArrow();
            this.createRealmLabel();
            this.createDiamonds();
            this.createRealmQuestItems();
            if (Parameters.data_.expandRealmQuestsDisplay){
                this.toggleOpenState();
            }
        }

        private function createContainers():void{
            this._content = new Sprite();
            this._content.alpha = this.CONTENT_ALPHA;
            this._content.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this._content.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addChild(this._content);
            this._buttonContainer = new Sprite();
            this._buttonContainerGraphics = this._buttonContainer.graphics;
            this._buttonContainer.buttonMode = true;
            this._buttonContainer.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this._content.addChild(this._buttonContainer);
            this._buttonDiamondContainer = new Sprite();
            this._buttonDiamondContainer.mouseEnabled = false;
            this._buttonContainer.addChild(this._buttonDiamondContainer);
            this._buttonNameContainer = new Sprite();
            this._buttonNameContainer.mouseEnabled = false;
            this._buttonNameContainer.visible = this._isOpen;
            this._buttonContainer.addChild(this._buttonNameContainer);
            this._buttonContent = new Sprite();
            this._buttonContent.mouseEnabled = false;
            this._buttonContent.mouseChildren = false;
            this._buttonContent.visible = this._isOpen;
            this._content.addChild(this._buttonContent);
            this._realmQuestDiamonds = new <Bitmap>[];
        }

        private function createArrow():void{
            this._arrow = TextureParser.instance.getTexture("UI", "spinner_up_arrow");
            this._buttonContainer.addChild(this._arrow);
        }

        private function createRealmLabel():void{
            this._realmLabel = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._realmLabel, 16, 0xFFFFFF, TextFormatAlign.LEFT, true);
            this._realmLabel.x = 20;
            this._realmLabel.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            this._buttonNameContainer.addChild(this._realmLabel);
        }

        private function createDiamonds():void{
            var _local2:String;
            var _local3:Bitmap;
            var _local1:int;
            while (_local1 < NUMBER_OF_QUESTS) {
                _local2 = ((this._requirementsStates[_local1]) ? "checkbox_filled" : "checkbox_empty");
                _local3 = TextureParser.instance.getTexture("UI", _local2);
                _local3.x = (((_local1 * (_local3.width + 5)) + this._arrow.width) + 5);
                this._buttonDiamondContainer.addChild(_local3);
                this.setHitArea(this._buttonContainer);
                this._realmQuestDiamonds.push(_local3);
                _local1++;
            }
        }

        private function disposeDiamonds():void{
            var _local2:Bitmap;
            var _local1:int = (NUMBER_OF_QUESTS - 1);
            while (_local1 >= 0) {
                _local2 = this._realmQuestDiamonds.pop();
                _local2.bitmapData.dispose();
                this._buttonDiamondContainer.removeChild(_local2);
                _local2 = null;
                _local1--;
            }
        }

        private function createRealmQuestItems():void{
            var _local3:RealmQuestItem;
            var _local1:int = 28;
            this._realmQuestItems = new <RealmQuestItem>[];
            var _local2:int;
            while (_local2 < NUMBER_OF_QUESTS) {
                _local3 = new RealmQuestItem(this.REQUIREMENTS_TEXTS[_local2], this._requirementsStates[_local2]);
                _local3.updateItemState(false);
                _local3.x = 20;
                _local3.y = (_local1 + 5);
                _local1 = (_local3.y + _local3.height);
                this._buttonContent.addChild(_local3);
                this._realmQuestItems.push(_local3);
                _local2++;
            }
        }

        private function createQuestDescription():void{
            var _local1:UILabel = new UILabel();
            _local1.x = 20;
            _local1.y = 15;
            _local1.text = this.QUEST_DESCRIPTION.replace("%s", this._realmName);
            DefaultLabelFormat.createLabelFormat(_local1, 12, 0xFFCC00);
            _local1.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
            this._buttonContent.addChild(_local1);
        }

        private function alphaTweenContent(_arg1:Number):void{
            if (TweenMax.isTweening(this._content)){
                TweenMax.killTweensOf(this._content);
            }
            TweenMax.to(this._content, 0.3, {alpha:_arg1});
        }

        private function setHitArea(_arg1:Sprite):void{
            var _local2:Sprite = new Sprite();
            _local2.graphics.clear();
            _local2.graphics.beginFill(0xFFCC00, 0);
            _local2.graphics.drawRect(0, 0, _arg1.width, _arg1.height);
            _arg1.addChild(_local2);
        }

        private function updateDiamonds():void{
            this.disposeDiamonds();
            this.createDiamonds();
        }

        private function completeRealmQuestItem(_arg1:RealmQuestItem):void{
            _arg1.updateItemState(true);
            _arg1.updateItemText((("<font color='#a8a8a8'>" + _arg1.label.text) + "</font>"));
        }

        private function onMouseClick(_arg1:MouseEvent):void{
            this.toggleOpenState();
        }

        private function onRollOver(_arg1:MouseEvent):void{
            if (TweenMax.isTweening(this._content)){
                TweenMax.killTweensOf(this._content);
            }
            TweenMax.to(this._content, 0.3, {alpha:1});
        }

        private function onRollOut(_arg1:MouseEvent):void{
            this.alphaTweenContent(this.CONTENT_ALPHA);
        }

        private function onMouseUp(_arg1:MouseEvent):void{
            if (Parameters.isGpuRender()){
                this._map.mapHitArea.dispatchEvent(_arg1);
            }
            else {
                this._map.dispatchEvent(_arg1);
            }
        }

        private function onMouseDown(_arg1:MouseEvent):void{
            if (Parameters.isGpuRender()){
                this._map.mapHitArea.dispatchEvent(_arg1);
            }
            else {
                this._map.dispatchEvent(_arg1);
            }
        }

        public function set realmName(_arg1:String):void{
            this._realmName = _arg1;
            this._realmLabel.text = this._realmName;
            this.setHitArea(this._buttonNameContainer);
            this.createQuestDescription();
        }

        public function set level(_arg1:int):void{
            var _local2:RealmQuestItem = this._realmQuestItems[QuestModel.LEVEL_REQUIREMENT];
            var _local3 = (_arg1 == 20);
            this._requirementsStates[QuestModel.LEVEL_REQUIREMENT] = _local3;
            if (_local3){
                this.completeRealmQuestItem(_local2);
            }
            else {
                _local2.updateItemState(false);
            }
            this.updateDiamonds();
        }

        public function set remainingHeroes(_arg1:int):void{
            var _local2:RealmQuestItem = this._realmQuestItems[QuestModel.REMAINING_HEROES_REQUIREMENT];
            _local2.updateItemText(this.REQUIREMENT_TEXT_02.replace("%d", _arg1));
            var _local3 = (_arg1 == 0);
            this._requirementsStates[QuestModel.REMAINING_HEROES_REQUIREMENT] = _local3;
            if (_local3){
                this.completeRealmQuestItem(_local2);
            }
            else {
                _local2.updateItemState(false);
            }
            this.updateDiamonds();
        }

        public function setOryxCompleted():void{
            this._requirementsStates[QuestModel.ORYX_KILLED] = true;
            var _local1:RealmQuestItem = this._realmQuestItems[QuestModel.ORYX_KILLED];
            this.completeRealmQuestItem(_local1);
            this.updateDiamonds();
        }

        public function set requirementsStates(_arg1:Vector.<Boolean>):void{
            this._requirementsStates = _arg1;
        }

        public function get requirementsStates():Vector.<Boolean>{
            return (this._requirementsStates);
        }


    }
}//package kabam.rotmg.game.view

