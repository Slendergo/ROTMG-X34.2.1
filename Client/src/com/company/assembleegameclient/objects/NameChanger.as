﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.NameChanger

package com.company.assembleegameclient.objects{
    import kabam.rotmg.game.view.NameChangerPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class NameChanger extends GameObject implements IInteractiveObject {

        public var rankRequired_:int = 0;

        public function NameChanger(_arg1:XML){
            super(_arg1);
            isInteractive_ = true;
        }

        public function setRankRequired(_arg1:int):void{
            this.rankRequired_ = _arg1;
        }

        public function getPanel(_arg1:GameSprite):Panel{
            return (new NameChangerPanel(_arg1, this.rankRequired_));
        }


    }
}//package com.company.assembleegameclient.objects

