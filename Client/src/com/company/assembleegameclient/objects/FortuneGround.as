﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.FortuneGround

package com.company.assembleegameclient.objects{
    import kabam.rotmg.game.view.FortuneGroundPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class FortuneGround extends GameObject implements IInteractiveObject {

        public function FortuneGround(_arg1:XML){
            super(_arg1);
            isInteractive_ = true;
        }

        public function getPanel(_arg1:GameSprite):Panel{
            return (new FortuneGroundPanel(_arg1, objectType_));
        }


    }
}//package com.company.assembleegameclient.objects

