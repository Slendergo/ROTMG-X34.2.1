﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.GuildHallPortal

package com.company.assembleegameclient.objects{
    import com.company.assembleegameclient.ui.panels.GuildHallPortalPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class GuildHallPortal extends GameObject implements IInteractiveObject {

        public function GuildHallPortal(_arg1:XML){
            super(_arg1);
            isInteractive_ = true;
        }

        public function getPanel(_arg1:GameSprite):Panel{
            return (new GuildHallPortalPanel(_arg1, this));
        }


    }
}//package com.company.assembleegameclient.objects

