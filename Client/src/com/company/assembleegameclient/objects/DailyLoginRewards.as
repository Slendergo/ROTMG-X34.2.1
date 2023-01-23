// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.DailyLoginRewards

package com.company.assembleegameclient.objects{
    import kabam.rotmg.dailyLogin.view.DailyLoginPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class DailyLoginRewards extends GameObject implements IInteractiveObject {

        public function DailyLoginRewards(_arg1:XML){
            super(_arg1);
            isInteractive_ = true;
        }

        public function getPanel(_arg1:GameSprite):Panel{
            return (new DailyLoginPanel(_arg1));
        }


    }
}//package com.company.assembleegameclient.objects

