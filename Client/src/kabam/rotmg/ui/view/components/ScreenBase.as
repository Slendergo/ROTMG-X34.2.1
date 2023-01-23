// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.ui.view.components.ScreenBase

package kabam.rotmg.ui.view.components{
    import flash.display.Sprite;
    import com.company.assembleegameclient.ui.SoundIcon;

    public class ScreenBase extends Sprite {

        static var TitleScreenBackground:Class = ScreenBase_TitleScreenBackground;

        public function ScreenBase(){
            addChild(new TitleScreenBackground());
            addChild(new DarkLayer());
            addChild(new SoundIcon());
        }

    }
}//package kabam.rotmg.ui.view.components

