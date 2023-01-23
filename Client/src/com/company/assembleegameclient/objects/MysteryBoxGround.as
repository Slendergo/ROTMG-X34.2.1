// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.MysteryBoxGround

package com.company.assembleegameclient.objects{
    import kabam.rotmg.game.view.MysteryBoxPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class MysteryBoxGround extends GameObject implements IInteractiveObject {

        public function MysteryBoxGround(_arg1:XML){
            super(_arg1);
            isInteractive_ = true;
        }

        public function getPanel(_arg1:GameSprite):Panel{
            return (new MysteryBoxPanel(_arg1, objectType_));
        }


    }
}//package com.company.assembleegameclient.objects

