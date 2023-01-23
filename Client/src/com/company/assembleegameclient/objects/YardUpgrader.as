﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.YardUpgrader

package com.company.assembleegameclient.objects{
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.text.model.TextKey;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import io.decagames.rotmg.pets.panels.YardUpgraderPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class YardUpgrader extends GameObject implements IInteractiveObject {

        public function YardUpgrader(_arg1:XML){
            super(_arg1);
            isInteractive_ = true;
        }

        public function getTooltip():ToolTip{
            var _local1:ToolTip = new TextToolTip(0x363636, 0x9B9B9B, TextKey.CLOSEDGIFTCHEST_TITLE, TextKey.TEXTPANEL_GIFTCHESTISEMPTY, 200);
            return (_local1);
        }

        public function getPanel(_arg1:GameSprite):Panel{
            return (new YardUpgraderPanel(_arg1, objectType_));
        }


    }
}//package com.company.assembleegameclient.objects

