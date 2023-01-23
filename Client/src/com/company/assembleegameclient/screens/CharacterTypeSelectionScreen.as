// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.screens.CharacterTypeSelectionScreen

package com.company.assembleegameclient.screens{
    import flash.display.Sprite;
    import flash.filters.DropShadowFilter;
    import org.osflash.signals.Signal;
    import kabam.rotmg.core.signals.LeagueItemSignal;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import io.decagames.rotmg.ui.buttons.InfoButton;
    import kabam.rotmg.ui.view.ButtonFactory;
    import kabam.rotmg.ui.view.components.ScreenBase;
    import kabam.rotmg.ui.view.components.MenuOptionsBar;
    import flash.text.TextFieldAutoSize;
    import flash.geom.Rectangle;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.util.FilterUtil;

    public class CharacterTypeSelectionScreen extends Sprite {

        private const DROP_SHADOW:DropShadowFilter = new DropShadowFilter(0, 0, 0, 1, 8, 8);

        public var close:Signal;
        public var leagueItemSignal:LeagueItemSignal;
        private var nameText:TextFieldDisplayConcrete;
        private var backButton:TitleMenuOption;
        private var _leagueDatas:Vector.<LeagueData>;
        private var _leagueItems:Vector.<LeagueItem>;
        private var _leagueContainer:Sprite;
        private var _infoButton:InfoButton;
        private var _buttonFactory:ButtonFactory;

        public function CharacterTypeSelectionScreen(){
            this.leagueItemSignal = new LeagueItemSignal();
            super();
            this.init();
        }

        private function init():void{
            this._buttonFactory = new ButtonFactory();
            addChild(new ScreenBase());
            addChild(new AccountScreen());
            this.createDisplayAssets();
        }

        private function createDisplayAssets():void{
            this.createNameText();
            this.makeMenuOptionsBar();
            this._leagueContainer = new Sprite();
            addChild(this._leagueContainer);
        }

        private function makeMenuOptionsBar():void{
            this.backButton = this._buttonFactory.getBackButton();
            this.close = this.backButton.clicked;
            var _local1:MenuOptionsBar = new MenuOptionsBar();
            _local1.addButton(this.backButton, MenuOptionsBar.CENTER);
            addChild(_local1);
        }

        private function createNameText():void{
            this.nameText = new TextFieldDisplayConcrete().setSize(22).setColor(0xB3B3B3);
            this.nameText.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
            this.nameText.filters = [this.DROP_SHADOW];
            this.nameText.y = 24;
            this.nameText.x = ((this.getReferenceRectangle().width - this.nameText.width) / 2);
            addChild(this.nameText);
        }

        function getReferenceRectangle():Rectangle{
            var _local1:Rectangle = new Rectangle();
            if (stage){
                _local1 = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            };
            return (_local1);
        }

        public function setName(_arg1:String):void{
            this.nameText.setStringBuilder(new StaticStringBuilder(_arg1));
            this.nameText.x = ((this.getReferenceRectangle().width - this.nameText.width) * 0.5);
        }

        public function set leagueDatas(_arg1:Vector.<LeagueData>):void{
            this._leagueDatas = _arg1;
            this.createLeagues();
            this.createInfoButton();
        }

        private function createInfoButton():void{
            this._infoButton = new InfoButton(10);
            this._infoButton.x = ((this._leagueContainer.width - this._infoButton.width) - 18);
            this._infoButton.y = (this._infoButton.height + 16);
            this._leagueContainer.addChild(this._infoButton);
        }

        private function createLeagues():void{
            var _local3:LeagueItem;
            if (!this._leagueItems){
                this._leagueItems = new <LeagueItem>[];
            }
            else {
                this._leagueItems.length = 0;
            };
            var _local1:int = this._leagueDatas.length;
            var _local2:int;
            while (_local2 < _local1) {
                _local3 = new LeagueItem(this._leagueDatas[_local2]);
                _local3.x = (_local2 * (_local3.width + 20));
                _local3.buttonMode = true;
                _local3.addEventListener(MouseEvent.CLICK, this.onLeagueItemClick);
                _local3.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
                _local3.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
                this._leagueItems.push(_local3);
                this._leagueContainer.addChild(_local3);
                _local2++;
            };
            this._leagueContainer.x = ((this.width - this._leagueContainer.width) / 2);
            this._leagueContainer.y = ((this.height - this._leagueContainer.height) / 2);
        }

        private function onOut(_arg1:MouseEvent):void{
            var _local2:LeagueItem = (_arg1.currentTarget as LeagueItem);
            if (_local2){
                _local2.filters = [];
                _local2.characterDance(false);
            }
            else {
                _arg1.currentTarget.filters = [];
            };
        }

        private function onOver(_arg1:MouseEvent):void{
            var _local2:LeagueItem = (_arg1.currentTarget as LeagueItem);
            if (_local2){
                _local2.characterDance(true);
            }
            else {
                _arg1.currentTarget.filters = FilterUtil.getLargeGlowFilter();
            };
        }

        private function onLeagueItemClick(_arg1:MouseEvent):void{
            this.removeLeagueItemListeners();
            this.leagueItemSignal.dispatch((_arg1.currentTarget as LeagueItem).leagueType);
        }

        private function removeLeagueItemListeners():void{
            var _local1:int = this._leagueItems.length;
            var _local2:int;
            while (_local2 < _local1) {
                this._leagueItems[_local2].removeEventListener(MouseEvent.CLICK, this.onLeagueItemClick);
                this._leagueItems[_local2].removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
                this._leagueItems[_local2].removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
                _local2++;
            };
        }

        public function get infoButton():InfoButton{
            return (this._infoButton);
        }


    }
}//package com.company.assembleegameclient.screens

