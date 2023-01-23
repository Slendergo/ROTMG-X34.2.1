// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.QuestRewards

package com.company.assembleegameclient.objects{
    import io.decagames.rotmg.dailyQuests.view.panel.DailyQuestsPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class QuestRewards extends GameObject implements IInteractiveObject {

        public function QuestRewards(_arg1:XML){
            super(_arg1);
            isInteractive_ = true;
        }

        public function getPanel(_arg1:GameSprite):Panel{
            return (new DailyQuestsPanel(_arg1));
        }


    }
}//package com.company.assembleegameclient.objects

