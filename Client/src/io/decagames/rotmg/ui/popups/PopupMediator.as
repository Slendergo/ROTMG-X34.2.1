// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.ui.popups.PopupMediator

package io.decagames.rotmg.ui.popups{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupByClassSignal;
    import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
    import io.decagames.rotmg.ui.popups.signals.CloseAllPopupsSignal;
    import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
    import io.decagames.rotmg.ui.popups.signals.ShowLockFade;

    public class PopupMediator extends Mediator {

        [Inject]
        public var view:PopupView;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var closePopupByClassSignal:ClosePopupByClassSignal;
        [Inject]
        public var closeCurrentPopupSignal:CloseCurrentPopupSignal;
        [Inject]
        public var closeAllPopupsSignal:CloseAllPopupsSignal;
        [Inject]
        public var removeLockFade:RemoveLockFade;
        [Inject]
        public var showLockFade:ShowLockFade;
        private var popups:Vector.<BasePopup>;

        public function PopupMediator(){
            this.popups = new Vector.<BasePopup>();
        }

        override public function initialize():void{
            this.showPopupSignal.add(this.showPopupHandler);
            this.closePopupSignal.add(this.closePopupHandler);
            this.closePopupByClassSignal.add(this.closeByClassHandler);
            this.closeCurrentPopupSignal.add(this.closeCurrentPopupHandler);
            this.closeAllPopupsSignal.add(this.closeAllPopupsHandler);
            this.removeLockFade.add(this.onRemoveLock);
            this.showLockFade.add(this.onShowLock);
        }

        private function closeCurrentPopupHandler():void{
            var _local1:BasePopup = this.popups.pop();
            this.view.removeChild(_local1);
        }

        private function onShowLock():void{
            this.view.showFade();
        }

        private function onRemoveLock():void{
            this.view.removeFade();
        }

        private function closeAllPopupsHandler():void{
            var _local1:BasePopup;
            for each (_local1 in this.popups) {
                this.view.removeChild(_local1);
            }
            this.popups = new Vector.<BasePopup>();
        }

        private function showPopupHandler(_arg1:BasePopup):void{
            this.view.addChild(_arg1);
            this.popups.push(_arg1);
            if (_arg1.showOnFullScreen){
                if (_arg1.overrideSizePosition != null){
                    _arg1.x = Math.round(((800 - _arg1.overrideSizePosition.width) / 2));
                    _arg1.y = Math.round(((600 - _arg1.overrideSizePosition.height) / 2));
                }
                else {
                    _arg1.x = Math.round(((800 - _arg1.width) / 2));
                    _arg1.y = Math.round(((600 - _arg1.height) / 2));
                }
            }
            this.drawPopupBackground(_arg1);
        }

        private function closePopupHandler(_arg1:BasePopup):void{
            var _local2:int = this.popups.indexOf(_arg1);
            if (_local2 >= 0){
                this.view.removeChild(this.popups[_local2]);
                this.popups.splice(_local2, 1);
            }
        }

        private function closeByClassHandler(_arg1:Class):void{
            var _local2:int = (this.popups.length - 1);
            while (_local2 >= 0) {
                if ((this.popups[_local2] is _arg1)){
                    this.view.removeChild(this.popups[_local2]);
                    this.popups.splice(_local2, 1);
                }
                _local2--;
            }
        }

        private function drawPopupBackground(_arg1:BasePopup):void{
            _arg1.graphics.beginFill(_arg1.popupFadeColor, _arg1.popupFadeAlpha);
            _arg1.graphics.drawRect(-(_arg1.x), -(_arg1.y), 800, 600);
            _arg1.graphics.endFill();
        }

        override public function destroy():void{
            this.showPopupSignal.remove(this.showPopupHandler);
            this.closePopupSignal.remove(this.closePopupHandler);
            this.closePopupByClassSignal.remove(this.closeByClassHandler);
            this.closeCurrentPopupSignal.remove(this.closeCurrentPopupHandler);
            this.removeLockFade.remove(this.onRemoveLock);
            this.showLockFade.remove(this.onShowLock);
        }


    }
}//package io.decagames.rotmg.ui.popups

