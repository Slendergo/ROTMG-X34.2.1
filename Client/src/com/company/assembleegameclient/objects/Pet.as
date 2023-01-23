﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.Pet

package com.company.assembleegameclient.objects{
    import kabam.rotmg.game.signals.TextPanelMessageUpdateSignal;
    import io.decagames.rotmg.pets.data.vo.PetVO;
    import com.company.assembleegameclient.util.AnimatedChar;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.core.StaticInjectorContext;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.text.model.TextKey;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import io.decagames.rotmg.pets.panels.PetPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;
    import com.company.assembleegameclient.util.MaskedImage;
    import com.company.assembleegameclient.util.AnimatedChars;

    public class Pet extends GameObject implements IInteractiveObject {

        private var textPanelUpdateSignal:TextPanelMessageUpdateSignal;
        public var vo:PetVO;
        public var skin:AnimatedChar;
        public var defaultSkin:AnimatedChar;
        public var skinId:int;
        public var isDefaultAnimatedChar:Boolean = false;
        private var petsModel:PetsModel;

        public function Pet(_arg1:XML){
            super(_arg1);
            isInteractive_ = true;
            this.textPanelUpdateSignal = StaticInjectorContext.getInjector().getInstance(TextPanelMessageUpdateSignal);
            this.petsModel = StaticInjectorContext.getInjector().getInstance(PetsModel);
            this.petsModel.getActivePet();
        }

        public function getTooltip():ToolTip{
            var _local1:ToolTip = new TextToolTip(0x363636, 0x9B9B9B, TextKey.CLOSEDGIFTCHEST_TITLE, TextKey.TEXTPANEL_GIFTCHESTISEMPTY, 200);
            return (_local1);
        }

        public function getPanel(_arg1:GameSprite):Panel{
            return (new PetPanel(_arg1, this.vo));
        }

        public function setSkin(_arg1:int):void{
            var _local5:MaskedImage;
            this.skinId = _arg1;
            var _local2:XML = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(_arg1));
            var _local3:String = _local2.AnimatedTexture.File;
            var _local4:int = _local2.AnimatedTexture.Index;
            if (this.skin == null){
                this.isDefaultAnimatedChar = true;
                this.skin = AnimatedChars.getAnimatedChar(_local3, _local4);
                this.defaultSkin = this.skin;
            }
            else {
                this.skin = AnimatedChars.getAnimatedChar(_local3, _local4);
            };
            this.isDefaultAnimatedChar = (this.skin == this.defaultSkin);
            _local5 = this.skin.imageFromAngle(0, AnimatedChar.STAND, 0);
            animatedChar_ = this.skin;
            texture_ = _local5.image_;
            mask_ = _local5.mask_;
            var _local6:ObjectProperties = ObjectLibrary.getPropsFromId(_local2.DisplayId);
            if (_local6){
                props_.flying_ = _local6.flying_;
                props_.whileMoving_ = _local6.whileMoving_;
                flying_ = props_.flying_;
                z_ = props_.z_;
            };
        }

        public function setDefaultSkin():void{
            var _local1:MaskedImage;
            this.skinId = -1;
            if (this.defaultSkin == null){
                return;
            };
            _local1 = this.defaultSkin.imageFromAngle(0, AnimatedChar.STAND, 0);
            this.isDefaultAnimatedChar = true;
            animatedChar_ = this.defaultSkin;
            texture_ = _local1.image_;
            mask_ = _local1.mask_;
        }


    }
}//package com.company.assembleegameclient.objects

