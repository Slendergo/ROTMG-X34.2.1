// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.packages.view.PackageOfferDialog

package kabam.rotmg.packages.view{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.pets.view.components.DialogCloseButton;
    import org.osflash.signals.Signal;
    import kabam.display.Loader.LoaderProxy;
    import kabam.rotmg.packages.model.PackageInfo;
    import flash.geom.Rectangle;
    import kabam.display.Loader.LoaderProxyConcrete;
    import com.company.assembleegameclient.ui.DeprecatedTextButton;
    import kabam.rotmg.text.model.TextKey;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import flash.events.IOErrorEvent;
    import flash.events.Event;
    import flash.net.URLRequest;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import kabam.lib.resizing.view.*;

    public class PackageOfferDialog extends Sprite implements Resizable {

        const paddingTop:Number = 6;
        const paddingRight:Number = 6;
        const paddingBottom:Number = 16;
        const fontSize:int = 27;
        private const busyIndicator:DisplayObject = makeBusyIndicator();
        private const buyNow:Sprite = makeBuyNow();
        private const title:TextFieldDisplayConcrete = makeTitle();
        private const closeButton:DialogCloseButton = makeCloseButton();

        public var ready:Signal;
        public var buy:Signal;
        public var close:Signal;
        var loader:LoaderProxy;
        var goldDisplay:GoldDisplay;
        var image:DisplayObject;
        private var packageInfo:PackageInfo;
        private var spaceAvailable:Rectangle;

        public function PackageOfferDialog(){
            this.ready = new Signal();
            this.buy = new Signal();
            this.close = new Signal();
            this.loader = new LoaderProxyConcrete();
            this.goldDisplay = new GoldDisplay();
            this.spaceAvailable = new Rectangle();
            super();
        }

        private function makeBusyIndicator():DisplayObject{
            var _local1:DisplayObject = new BusyIndicator();
            addChild(_local1);
            return (_local1);
        }

        private function makeCloseButton():DialogCloseButton{
            return (new DialogCloseButton());
        }

        private function makeBuyNow():DeprecatedTextButton{
            var _local1:DeprecatedTextButton = new DeprecatedTextButton(16, TextKey.PACKAGE_OFFER_DIALOG_BUY_NOW);
            return (_local1);
        }

        private function makeTitle():TextFieldDisplayConcrete{
            var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(this.fontSize).setColor(0xB3B3B3);
            _local1.y = (this.paddingTop + 5);
            _local1.setAutoSize(TextFieldAutoSize.CENTER);
            return (_local1);
        }

        public function setPackage(_arg1:PackageInfo):PackageOfferDialog{
            removeChild(this.busyIndicator);
            this.packageInfo = _arg1;
            return (this);
        }

        public function getPackage():PackageInfo{
            return (this.packageInfo);
        }

        private function onMouseUp(_arg1:MouseEvent):void{
            this.closeButton.disabled = true;
            this.closeButton.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this.close.dispatch();
        }

        private function setImageURL(_arg1:String):void{
            ((this.loader) && (this.loader.unload()));
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
            this.loader.load(new URLRequest(_arg1));
        }

        public function destroy():void{
            this.loader.unload();
        }

        private function onIOError(_arg1:IOErrorEvent):void{
            this.removeListeners();
            this.populateDialog(new PackageBackground());
            this.ready.dispatch();
        }

        private function onComplete(_arg1:Event):void{
            this.removeListeners();
            this.populateDialog(this.loader);
            this.ready.dispatch();
        }

        private function populateDialog(_arg1:DisplayObject):void{
            this.setImage(_arg1);
            addChild(this.title);
            this.handleCloseButton();
            this.handleBuyNow();
            this.handleGold();
        }

        private function removeListeners():void{
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
        }

        private function handleGold():void{
            this.goldDisplay.init();
            addChild(this.goldDisplay);
            this.goldDisplay.x = (this.buyNow.x - 16);
            this.goldDisplay.y = (this.buyNow.y + (this.buyNow.height / 2));
        }

        private function handleBuyNow():void{
            addChild(this.buyNow);
            this.buyNow.x = ((this.image.width / 2) - (this.buyNow.width / 2));
            this.buyNow.y = (((this.image.height - this.buyNow.height) - this.paddingBottom) - 4);
            this.buyNow.addEventListener(MouseEvent.MOUSE_UP, this.onBuyNow);
        }

        private function onBuyNow(_arg1:Event):void{
            this.buyNow.removeEventListener(MouseEvent.MOUSE_UP, this.onBuyNow);
            this.buy.dispatch();
        }

        private function handleCloseButton():void{
            addChild(this.closeButton);
            this.closeButton.x = ((this.image.width - (this.closeButton.width * 2)) - this.paddingRight);
            this.closeButton.y = (this.paddingTop + 5);
            this.closeButton.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

        private function setImage(_arg1:DisplayObject):void{
            ((this.image) && (removeChild(this.image)));
            this.image = _arg1;
            ((this.image) && (addChild(this.image)));
            this.center();
        }

        private function center():void{
            x = ((this.spaceAvailable.width - width) / 2);
            y = ((this.spaceAvailable.height - height) / 2);
        }

        private function setTitle(_arg1:String):void{
            this.title.setStringBuilder(new StaticStringBuilder(_arg1));
            this.title.x = (this.image.width / 2);
        }

        private function setGold(_arg1:int):void{
            this.goldDisplay.setGold(_arg1);
        }

        public function resize(_arg1:Rectangle):void{
            this.spaceAvailable = _arg1;
            this.center();
        }


    }
}//package kabam.rotmg.packages.view

