﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.MoneyChanger

package com.company.assembleegameclient.objects{
    import kabam.rotmg.game.view.MoneyChangerPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class MoneyChanger extends GameObject implements IInteractiveObject {

        public function MoneyChanger(_arg1:XML){
            super(_arg1);
            isInteractive_ = true;
        }

        public function getPanel(_arg1:GameSprite):Panel{
            return (new MoneyChangerPanel(_arg1));
        }


    }
}//package com.company.assembleegameclient.objects

