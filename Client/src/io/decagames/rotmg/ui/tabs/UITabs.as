// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.tabs.UITabs

package io.decagames.rotmg.ui.tabs{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import io.decagames.rotmg.social.signals.TabSelectedSignal;
    import flash.events.Event;
    import flash.geom.Point;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

    public class UITabs extends Sprite {

        public var buttonsRenderedSignal:Signal;
        public var tabSelectedSignal:TabSelectedSignal;
        private var tabsXSpace:int = 3;
        private var tabsButtonMargin:int = 14;
        private var content:Vector.<UITab>;
        private var buttons:Vector.<TabButton>;
        private var tabsWidth:int;
        private var background:TabContentBackground;
        private var currentContent:UITab;
        private var defaultSelectedIndex:int = 0;
        private var borderlessMode:Boolean;
        private var _currentTabLabel:String;

        public function UITabs(_arg1:int, _arg2:Boolean=false){
            this.buttonsRenderedSignal = new Signal();
            this.tabSelectedSignal = new TabSelectedSignal();
            super();
            this.tabsWidth = _arg1;
            this.borderlessMode = _arg2;
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
            this.content = new <UITab>[];
            this.buttons = new <TabButton>[];
            if (!_arg2){
                this.background = new TabContentBackground();
                this.background.addMargin(0, 3);
                this.background.width = _arg1;
                this.background.height = 405;
                this.background.x = 0;
                this.background.y = 41;
                addChild(this.background);
            }
            else {
                this.tabsButtonMargin = 3;
            };
        }

        public function addTab(_arg1:UITab, _arg2:Boolean=false):void{
            this.content.push(_arg1);
            _arg1.y = ((this.borderlessMode) ? 34 : 56);
            if (_arg2){
                this.defaultSelectedIndex = (this.content.length - 1);
                this.currentContent = _arg1;
                this._currentTabLabel = _arg1.tabName;
                addChild(_arg1);
            };
            if (this._currentTabLabel == ""){
                this._currentTabLabel = _arg1.tabName;
            };
        }

        private function createTabButtons():void{
            var _local1:int;
            var _local2:int;
            var _local3:String;
            var _local4:TabButton;
            var _local5:UITab;
            var _local6:TabButton;
            _local1 = 1;
            _local2 = (((this.tabsWidth - ((this.content.length - 1) * this.tabsXSpace)) - (this.tabsButtonMargin * 2)) / this.content.length);
            for each (_local5 in this.content) {
                if (_local1 == 1){
                    _local3 = TabButton.LEFT;
                }
                else {
                    if (_local1 == this.content.length){
                        _local3 = TabButton.RIGHT;
                    }
                    else {
                        _local3 = TabButton.CENTER;
                    };
                };
                _local6 = this.createTabButton(_local5.tabName, _local3);
                _local6.width = _local2;
                _local6.selected = (this.defaultSelectedIndex == (_local1 - 1));
                if (_local6.selected){
                    _local4 = _local6;
                };
                _local6.y = 3;
                _local6.x = ((this.tabsButtonMargin + (_local2 * (_local1 - 1))) + (this.tabsXSpace * (_local1 - 1)));
                addChild(_local6);
                _local6.clickSignal.add(this.onButtonSelected);
                this.buttons.push(_local6);
                _local1++;
            };
            if (this.background){
                this.background.addDecor((_local4.x - 4), ((_local4.x + _local4.width) - 12), this.defaultSelectedIndex, this.buttons.length);
            };
            this.onButtonSelected(_local4);
            this.buttonsRenderedSignal.dispatch();
        }

        private function onButtonSelected(_arg1:TabButton):void{
            var _local3:TabButton;
            var _local2:int = this.buttons.indexOf(_arg1);
            _arg1.y = 0;
            this._currentTabLabel = _arg1.label.text;
            this.tabSelectedSignal.dispatch(_arg1.label.text);
            for each (_local3 in this.buttons) {
                if (_local3 != _arg1){
                    _local3.selected = false;
                    _local3.y = 3;
                    this.updateTabButtonGraphicState(_local3, _local2);
                }
                else {
                    _local3.selected = true;
                };
            };
            if (this.currentContent){
                this.currentContent.displaySignal.dispatch(false);
                this.currentContent.alpha = 0;
                this.currentContent.mouseChildren = false;
                this.currentContent.mouseEnabled = false;
            };
            this.currentContent = this.content[_local2];
            if (this.background){
                this.background.addDecor((_arg1.x - 5), ((_arg1.x + _arg1.width) - 12), _local2, this.buttons.length);
            };
            addChild(this.currentContent);
            this.currentContent.displaySignal.dispatch(true);
            this.currentContent.alpha = 1;
            this.currentContent.mouseChildren = true;
            this.currentContent.mouseEnabled = true;
        }

        private function updateTabButtonGraphicState(_arg1:TabButton, _arg2:int):void{
            var _local3:int = this.buttons.indexOf(_arg1);
            if (this.borderlessMode){
                _arg1.changeBitmap("tab_button_borderless_idle", new Point(0, ((this.borderlessMode) ? 0 : TabButton.SELECTED_MARGIN)));
                _arg1.bitmap.alpha = 0;
            }
            else {
                if (_local3 > _arg2){
                    _arg1.changeBitmap("tab_button_right_idle", new Point(0, ((this.borderlessMode) ? 0 : TabButton.SELECTED_MARGIN)));
                }
                else {
                    _arg1.changeBitmap("tab_button_left_idle", new Point(0, ((this.borderlessMode) ? 0 : TabButton.SELECTED_MARGIN)));
                };
            };
        }

        public function getTabButtonByLabel(_arg1:String):TabButton{
            var _local2:TabButton;
            for each (_local2 in this.buttons) {
                if (_local2.label.text == _arg1){
                    return (_local2);
                };
            };
            return (null);
        }

        private function createTabButton(_arg1:String, _arg2:String):TabButton{
            var _local3:TabButton = new TabButton(((this.borderlessMode) ? TabButton.BORDERLESS : _arg2));
            _local3.setLabel(_arg1, DefaultLabelFormat.defaultInactiveTab);
            return (_local3);
        }

        private function onAddedHandler(_arg1:Event):void{
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
            this.createTabButtons();
        }

        public function dispose():void{
            var _local1:TabButton;
            var _local2:UITab;
            if (this.background){
                this.background.dispose();
            };
            for each (_local1 in this.buttons) {
                _local1.dispose();
            };
            for each (_local2 in this.content) {
                _local2.dispose();
            };
            this.currentContent.dispose();
            this.content = null;
            this.buttons = null;
        }

        public function get currentTabLabel():String{
            return (this._currentTabLabel);
        }


    }
}//package io.decagames.rotmg.ui.tabs

