﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.view.panel.DailyQuestsPanel

package io.decagames.rotmg.dailyQuests.view.panel{
    import com.company.assembleegameclient.ui.panels.Panel;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.ui.DeprecatedTextButtonStatic;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import com.company.assembleegameclient.game.GameSprite;

    public class DailyQuestsPanel extends Panel {

        private const titleText:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 18, true);

        private var icon:Bitmap;
        private var title:String = "The Tinkerer";
        private var feedPetText:String = "See Quests";
        private var objectType:int;
        var feedButton:DeprecatedTextButtonStatic;

        public function DailyQuestsPanel(_arg1:GameSprite){
            super(_arg1);
            this.icon = PetsViewAssetFactory.returnBitmap(5972);
            this.icon.x = -4;
            this.icon.y = -8;
            addChild(this.icon);
            this.objectType = 5972;
            this.titleText.setStringBuilder(new StaticStringBuilder(this.title));
            this.titleText.x = 58;
            this.titleText.y = 28;
            addChild(this.titleText);
        }

        public function addSeeOffersButton():void{
            this.feedButton = new DeprecatedTextButtonStatic(16, this.feedPetText);
            this.feedButton.textChanged.addOnce(this.alignButton);
            addChild(this.feedButton);
        }

        private function alignButton():void{
            this.feedButton.x = ((WIDTH / 2) - (this.feedButton.width / 2));
            this.feedButton.y = ((HEIGHT - this.feedButton.height) - 4);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.panel

