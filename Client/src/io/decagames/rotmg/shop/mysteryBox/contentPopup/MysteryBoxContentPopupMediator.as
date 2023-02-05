// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.shop.mysteryBox.contentPopup.MysteryBoxContentPopupMediator

package io.decagames.rotmg.shop.mysteryBox.contentPopup{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import flash.utils.Dictionary;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class MysteryBoxContentPopupMediator extends Mediator {

        [Inject]
        public var view:MysteryBoxContentPopup;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        private var closeButton:SliceScalingButton;
        private var contentGrids:Vector.<UIGrid>;
        private var jackpotsNumber:int = 0;
        private var jackpotsHeight:int = 0;
        private var jackpotUI:JackpotContainer;


        override public function initialize():void{
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.addJackpots(this.view.info.jackpots);
            this.addContentList(this.view.info.contents, this.view.info.jackpots);
        }

        private function addJackpots(_arg1:String):void{
            var _local3:String;
            var _local4:Array;
            var _local5:Array;
            var _local6:Array;
            var _local7:String;
            var _local8:int;
            var _local9:UIGrid;
            var _local10:UIItemContainer;
            var _local11:int;
            var _local2:Array = _arg1.split("|");
            for each (_local3 in _local2) {
                _local4 = _local3.split(",");
                _local5 = [];
                _local6 = [];
                for each (_local7 in _local4) {
                    _local8 = _local5.indexOf(_local7);
                    if (_local8 == -1){
                        _local5.push(_local7);
                        _local6.push(1);
                    }
                    else {
                        _local6[_local8] = (_local6[_local8] + 1);
                    }
                }
                if (_arg1.length > 0){
                    _local9 = new UIGrid(220, 5, 4);
                    _local9.centerLastRow = true;
                    for each (_local7 in _local5) {
                        _local10 = new UIItemContainer(int(_local7), 0x484848, 0, 40);
                        _local10.showTooltip = true;
                        _local9.addGridElement(_local10);
                        _local11 = _local6[_local5.indexOf(_local7)];
                        if (_local11 > 1){
                            _local10.showQuantityLabel(_local11);
                        }
                    }
                    this.jackpotUI = new JackpotContainer();
                    this.jackpotUI.x = 10;
                    this.jackpotUI.y = ((55 + this.jackpotsHeight) - 22);
                    if (this.jackpotsNumber == 0){
                        this.jackpotUI.diamondBackground();
                    }
                    else {
                        if (this.jackpotsNumber == 1){
                            this.jackpotUI.goldBackground();
                        }
                        else {
                            if (this.jackpotsNumber == 2){
                                this.jackpotUI.silverBackground();
                            }
                        }
                    }
                    this.jackpotUI.addGrid(_local9);
                    this.view.addChild(this.jackpotUI);
                    this.jackpotsHeight = (this.jackpotsHeight + (this.jackpotUI.height + 5));
                    this.jackpotsNumber++;
                }
            }
        }

        private function addContentList(_arg1:String, _arg2:String):void{
            var _local7:String;
            var _local8:int;
            var _local9:int;
            var _local12:Array;
            var _local13:Array;
            var _local14:Array;
            var _local15:String;
            var _local16:Boolean;
            var _local17:String;
            var _local18:Array;
            var _local19:UIGrid;
            var _local20:Array;
            var _local21:Vector.<ItemBox>;
            var _local22:Dictionary;
            var _local23:String;
            var _local24:Array;
            var _local25:String;
            var _local26:ItemsSetBox;
            var _local27:ItemBox;
            var _local3:Array = _arg1.split("|");
            var _local4:Array = _arg2.split("|");
            var _local5:Array = [];
            var _local6:int;
            for each (_local7 in _local3) {
                _local13 = [];
                _local14 = _local7.split(";");
                for each (_local15 in _local14) {
                    _local16 = false;
                    for each (_local17 in _local4) {
                        if (_local17 == _local15){
                            _local16 = true;
                            break;
                        }
                    }
                    if (!_local16){
                        _local18 = _local15.split(",");
                        _local13.push(_local18);
                    }
                }
                _local5[_local6] = _local13;
                _local6++;
            }
            _local8 = (486 - 11);
            _local9 = 30;
            if (this.jackpotsNumber > 0){
                _local8 = (_local8 - (this.jackpotsHeight + 10));
                _local9 = (_local9 + (this.jackpotsHeight + 10));
            }
            this.contentGrids = new <UIGrid>[];
            var _local10:int = 5;
            var _local11:Number = ((260 - (_local10 * (_local5.length - 1))) / _local5.length);
            for each (_local12 in _local5) {
                _local19 = new UIGrid(_local11, 1, 5);
                for each (_local20 in _local12) {
                    _local21 = new Vector.<ItemBox>();
                    _local22 = new Dictionary();
                    for each (_local23 in _local20) {
                        if (_local22[_local23]){
                            var _local34 = _local22;
                            var _local35 = _local23;
                            var _local36 = (_local34[_local35] + 1);
                            _local34[_local35] = _local36;
                        }
                        else {
                            _local22[_local23] = 1;
                        }
                    }
                    _local24 = [];
                    for each (_local25 in _local20) {
                        if (_local24.indexOf(_local25) == -1){
                            _local27 = new ItemBox(_local25, _local22[_local25], (_local5.length == 1), "", false);
                            _local27.clearBackground();
                            _local21.push(_local27);
                            _local24.push(_local25);
                        }
                    }
                    _local26 = new ItemsSetBox(_local21);
                    _local19.addGridElement(_local26);
                }
                _local19.y = _local9;
                _local19.x = ((10 + (_local11 * this.contentGrids.length)) + (_local10 * this.contentGrids.length));
                this.view.addChild(_local19);
                this.contentGrids.push(_local19);
            }
        }

        override public function destroy():void{
            var _local1:UIGrid;
            this.closeButton.dispose();
            for each (_local1 in this.contentGrids) {
                _local1.dispose();
            }
            this.contentGrids = null;
        }

        private function onClose(_arg1:BaseButton):void{
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

