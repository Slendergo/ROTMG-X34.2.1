// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.promotions.view.BeginnersPackageOfferDialog

package kabam.rotmg.promotions.view{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.NativeMappedSignal;
    import flash.events.MouseEvent;
    import kabam.rotmg.promotions.view.components.TransparentButton;

    public class BeginnersPackageOfferDialog extends Sprite {

        public static var hifiBeginnerOfferEmbed:Class = BeginnersPackageOfferDialog_hifiBeginnerOfferEmbed;

        public var close:Signal;
        public var buy:Signal;

        public function BeginnersPackageOfferDialog(){
            this.makeBackground();
            this.makeCloseButton();
            this.makeBuyButton();
        }

        public function centerOnScreen():void{
            x = ((stage.stageWidth - width) * 0.5);
            y = ((stage.stageHeight - height) * 0.5);
        }

        private function makeBackground():void{
            addChild(new hifiBeginnerOfferEmbed());
        }

        private function makeBuyButton():void{
            var _local1:Sprite = this.makeTransparentTargetButton(270, 400, 150, 40);
            this.buy = new NativeMappedSignal(_local1, MouseEvent.CLICK);
        }

        private function makeCloseButton():void{
            var _local1:Sprite = this.makeTransparentTargetButton(550, 30, 30, 30);
            this.close = new NativeMappedSignal(_local1, MouseEvent.CLICK);
        }

        private function makeTransparentTargetButton(_arg1:int, _arg2:int, _arg3:int, _arg4:int):Sprite{
            var _local5:TransparentButton = new TransparentButton(_arg1, _arg2, _arg3, _arg4);
            addChild(_local5);
            return (_local5);
        }


    }
}//package kabam.rotmg.promotions.view

