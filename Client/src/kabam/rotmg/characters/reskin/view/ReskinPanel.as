﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.characters.reskin.view.ReskinPanel

package kabam.rotmg.characters.reskin.view{
    import com.company.assembleegameclient.ui.panels.Panel;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.ui.DeprecatedTextButton;
    import org.osflash.signals.Signal;
    import org.osflash.signals.natives.NativeMappedSignal;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.company.assembleegameclient.game.GameSprite;
    import flash.text.TextFieldAutoSize;
    import flash.filters.DropShadowFilter;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.model.TextKey;
    import flash.events.KeyboardEvent;
    import com.company.assembleegameclient.parameters.Parameters;

    public class ReskinPanel extends Panel {

        private const title:TextFieldDisplayConcrete = makeTitle();
        private const button:DeprecatedTextButton = makeButton();
        private const click:Signal = new org.osflash.signals.natives.NativeMappedSignal(button, flash.events.MouseEvent.CLICK);
        public const reskin:Signal = new Signal();

        public function ReskinPanel(_arg1:GameSprite=null){
            super(_arg1);
            this.click.add(this.onClick);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        private function onClick():void{
            this.reskin.dispatch();
        }

        private function makeTitle():TextFieldDisplayConcrete{
            var _local1:TextFieldDisplayConcrete;
            _local1 = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setAutoSize(TextFieldAutoSize.CENTER);
            _local1.x = int((WIDTH / 2));
            _local1.y = 6;
            _local1.setBold(true);
            _local1.filters = [new DropShadowFilter(0, 0, 0)];
            _local1.setStringBuilder(new LineBuilder().setParams(TextKey.RESKINPANEL_CHANGESKIN));
            addChild(_local1);
            return (_local1);
        }

        private function makeButton():DeprecatedTextButton{
            var _local1:DeprecatedTextButton = new DeprecatedTextButton(16, TextKey.RESKINPANEL_CHOOSE);
            _local1.textChanged.addOnce(this.onTextSet);
            addChild(_local1);
            return (_local1);
        }

        private function onTextSet():void{
            this.button.x = int(((WIDTH / 2) - (this.button.width / 2)));
            this.button.y = ((HEIGHT - this.button.height) - 4);
        }

        private function onAddedToStage(_arg1:Event):void{
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }

        private function onRemovedFromStage(_arg1:Event):void{
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        }

        private function onKeyDown(_arg1:KeyboardEvent):void{
            if ((((_arg1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))){
                this.reskin.dispatch();
            }
        }


    }
}//package kabam.rotmg.characters.reskin.view

