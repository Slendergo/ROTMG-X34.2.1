// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.classes.view.CharacterSkinView

package kabam.rotmg.classes.view{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import kabam.rotmg.ui.view.SignalWaiter;
    import com.company.assembleegameclient.screens.TitleMenuOption;
    import org.osflash.signals.natives.NativeMappedSignal;
    import flash.events.MouseEvent;
    import kabam.rotmg.ui.view.components.ScreenBase;
    import com.company.assembleegameclient.screens.AccountScreen;
    import kabam.rotmg.game.view.CreditDisplay;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.core.model.PlayerModel;
    import flash.display.Shape;
    import com.company.rotmg.graphics.ScreenGraphic;
    import com.company.assembleegameclient.constants.ScreenTypes;
    import flash.text.TextFieldAutoSize;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import io.decagames.rotmg.ui.labels.UILabel;
    import org.swiftsuspenders.Injector;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;

    public class CharacterSkinView extends Sprite {

        public var play:Signal;
        public var back:Signal;
        public var waiter:SignalWaiter;
        private var playBtn:TitleMenuOption;
        private var backBtn:TitleMenuOption;

        public function CharacterSkinView(){
            this.init();
        }

        private function init():void{
            this.makeScreenBase();
            this.makeAccountScreen();
            this.makeLines();
            this.makeCreditDisplay();
            this.makeScreenGraphic();
            this.playBtn = this.makePlayButton();
            this.backBtn = this.makeBackButton();
            this.makeListView();
            this.makeClassDetailView();
            this.waiter = this.makeSignalWaiter();
            this.play = new NativeMappedSignal(this.playBtn, MouseEvent.CLICK);
            this.back = new NativeMappedSignal(this.backBtn, MouseEvent.CLICK);
        }

        private function makeScreenBase():void{
            var _local1:ScreenBase = new ScreenBase();
            addChild(_local1);
        }

        private function makeAccountScreen():void{
            var _local1:AccountScreen = new AccountScreen();
            addChild(_local1);
        }

        private function makeCreditDisplay():void{
            var _local1:CreditDisplay = new CreditDisplay(null, true, true);
            var _local2:PlayerModel = StaticInjectorContext.getInjector().getInstance(PlayerModel);
            if (_local2 != null){
                _local1.draw(_local2.getCredits(), _local2.getFame(), _local2.getTokens());
            };
            _local1.x = 800;
            _local1.y = 20;
            addChild(_local1);
        }

        private function makeLines():void{
            var _local1:Shape = new Shape();
            _local1.graphics.clear();
            _local1.graphics.lineStyle(2, 0x545454);
            _local1.graphics.moveTo(0, 105);
            _local1.graphics.lineTo(800, 105);
            _local1.graphics.moveTo(346, 105);
            _local1.graphics.lineTo(346, 526);
            addChild(_local1);
        }

        private function makeScreenGraphic():void{
            var _local1:ScreenGraphic = new ScreenGraphic();
            addChild(_local1);
        }

        private function makePlayButton():TitleMenuOption{
            var _local1:TitleMenuOption = new TitleMenuOption(ScreenTypes.PLAY, 36, false);
            _local1.setAutoSize(TextFieldAutoSize.CENTER);
            _local1.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            _local1.x = (400 - (_local1.width / 2));
            _local1.y = 550;
            addChild(_local1);
            return (_local1);
        }

        private function makeBackButton():TitleMenuOption{
            var _local1:TitleMenuOption;
            _local1 = new TitleMenuOption(ScreenTypes.BACK, 22, false);
            _local1.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            _local1.x = 30;
            _local1.y = 550;
            addChild(_local1);
            return (_local1);
        }

        private function makeListView():void{
            var _local3:UILabel;
            var _local4:CharacterSkinListView;
            var _local1:Injector = StaticInjectorContext.getInjector();
            var _local2:SeasonalEventModel = _local1.getInstance(SeasonalEventModel);
            if (_local2.isChallenger){
                _local3 = new UILabel();
                DefaultLabelFormat.createLabelFormat(_local3, 18, 0xFF0000, TextFormatAlign.CENTER, true);
                _local3.width = 200;
                _local3.multiline = true;
                _local3.wordWrap = true;
                _local3.text = "Skins are not available in Rifts Mode";
                _local3.x = (600 - (_local3.width / 2));
                _local3.y = ((600 - _local3.height) / 2);
                addChild(_local3);
            }
            else {
                _local4 = new CharacterSkinListView();
                _local4.x = 351;
                _local4.y = 110;
                addChild(_local4);
            };
        }

        private function makeClassDetailView():void{
            var _local1:ClassDetailView;
            _local1 = new ClassDetailView();
            _local1.x = 5;
            _local1.y = 110;
            addChild(_local1);
        }

        public function setPlayButtonEnabled(_arg1:Boolean):void{
            if (!_arg1){
                this.playBtn.deactivate();
            };
        }

        private function makeSignalWaiter():SignalWaiter{
            var _local1:SignalWaiter = new SignalWaiter();
            _local1.push(this.playBtn.changed);
            _local1.complete.add(this.positionOptions);
            return (_local1);
        }

        private function positionOptions():void{
            this.playBtn.x = (stage.stageWidth / 2);
        }


    }
}//package kabam.rotmg.classes.view

