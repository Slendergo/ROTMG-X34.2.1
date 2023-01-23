﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.panels.PetPanel

package io.decagames.rotmg.pets.panels{
    import com.company.assembleegameclient.ui.panels.Panel;
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
    import org.osflash.signals.natives.NativeSignal;
    import flash.display.Sprite;
    import kabam.rotmg.editor.view.StaticTextButton;
    import io.decagames.rotmg.pets.data.vo.PetVO;
    import flash.display.Bitmap;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.game.AGameSprite;
    import kabam.rotmg.text.model.TextKey;
    import io.decagames.rotmg.pets.utils.PetsConstants;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import io.decagames.rotmg.pets.components.tooltip.PetTooltip;

    public class PetPanel extends Panel {

        private static const FONT_SIZE:int = 16;
        private static const INVENTORY_PADDING:int = 6;
        private static const HUD_PADDING:int = 5;

        public const addToolTip:Signal = new Signal(ToolTip);
        private const nameTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 16, true);
        private const rarityTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB6B6B6, 12, false);

        public var petBitmapRollover:NativeSignal;
        public var petBitmapContainer:Sprite;
        public var followButton:StaticTextButton;
        public var releaseButton:StaticTextButton;
        public var unFollowButton:StaticTextButton;
        public var petVO:PetVO;
        private var petBitmap:Bitmap;

        public function PetPanel(_arg1:AGameSprite, _arg2:PetVO){
            this.petBitmapContainer = new Sprite();
            super(_arg1);
            this.petVO = _arg2;
            this.petBitmapRollover = new NativeSignal(this.petBitmapContainer, MouseEvent.MOUSE_OVER);
            this.petBitmapRollover.add(this.onRollOver);
            this.petBitmap = _arg2.getSkinBitmap();
            this.addChildren();
            this.positionChildren();
            this.updateTextFields();
            this.createButtons();
        }

        private static function sendToBottom(_arg1:StaticTextButton):void{
            _arg1.y = ((HEIGHT - _arg1.height) - 4);
        }


        private function createButtons():void{
            this.followButton = this.makeButton(TextKey.PET_PANEL_FOLLOW);
            this.releaseButton = this.makeButton(TextKey.RELEASE);
            this.unFollowButton = this.makeButton(TextKey.PET_PANEL_UNFOLLOW);
            this.alignButtons();
        }

        private function makeButton(_arg1:String):StaticTextButton{
            var _local2:StaticTextButton = new StaticTextButton(FONT_SIZE, _arg1);
            addChild(_local2);
            return (_local2);
        }

        public function setState(_arg1:uint):void{
            this.toggleButtons((_arg1 == PetsConstants.INTERACTING));
        }

        public function toggleButtons(_arg1:Boolean):void{
            this.followButton.visible = _arg1;
            this.releaseButton.visible = _arg1;
            this.unFollowButton.visible = !(_arg1);
        }

        private function addChildren():void{
            this.petBitmapContainer.addChild(this.petBitmap);
            addChild(this.petBitmapContainer);
            addChild(this.nameTextField);
            addChild(this.rarityTextField);
        }

        private function updateTextFields():void{
            this.nameTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.name)).setColor(this.petVO.rarity.color).setSize((((this.petVO.name.length > 17)) ? 11 : 15));
            this.rarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.rarity.rarityKey));
        }

        private function positionChildren():void{
            this.petBitmap.x = 4;
            this.petBitmap.y = -3;
            this.nameTextField.x = 58;
            this.nameTextField.y = 21;
            this.rarityTextField.x = 58;
            this.rarityTextField.y = 35;
        }

        private function alignButtons():void{
            this.positionFollow();
            this.positionRelease();
            this.positionUnfollow();
        }

        private function positionFollow():void{
            this.followButton.x = INVENTORY_PADDING;
            sendToBottom(this.followButton);
        }

        private function positionRelease():void{
            this.releaseButton.x = (((WIDTH - this.releaseButton.width) - INVENTORY_PADDING) - HUD_PADDING);
            sendToBottom(this.releaseButton);
        }

        private function positionUnfollow():void{
            this.unFollowButton.x = ((WIDTH - this.unFollowButton.width) / 2);
            sendToBottom(this.unFollowButton);
        }

        private function onRollOver(_arg1:MouseEvent):void{
            var _local2:PetTooltip = new PetTooltip(this.petVO);
            _local2.attachToTarget(this);
            this.addToolTip.dispatch(_local2);
        }


    }
}//package io.decagames.rotmg.pets.panels

