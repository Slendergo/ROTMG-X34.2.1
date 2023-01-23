// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.ui.view.ButtonFactory

package kabam.rotmg.ui.view{
    import flash.text.TextFieldAutoSize;
    import com.company.assembleegameclient.constants.ScreenTypes;
    import com.company.assembleegameclient.screens.TitleMenuOption;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;

    public class ButtonFactory {

        public static const BUTTON_SIZE_LARGE:uint = 36;
        public static const BUTTON_SIZE_SMALL:uint = 22;
        private static const LEFT:String = TextFieldAutoSize.LEFT;//"left"
        private static const CENTER:String = TextFieldAutoSize.CENTER;//"center"
        private static const RIGHT:String = TextFieldAutoSize.RIGHT;//"right"


        public function getPlayButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.PLAY, BUTTON_SIZE_LARGE, CENTER, true));
        }

        public function getClassesButton():TitleMenuOption{
            return (this.makeButton(TextKey.SCREENS_CLASSES, BUTTON_SIZE_SMALL, LEFT));
        }

        public function getMainButton():TitleMenuOption{
            return (this.makeButton(TextKey.SCREENS_MAIN, BUTTON_SIZE_SMALL, RIGHT));
        }

        public function getDoneButton():TitleMenuOption{
            return (this.makeButton(TextKey.DONE_TEXT, BUTTON_SIZE_LARGE, CENTER));
        }

        public function getAccountButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.ACCOUNT, BUTTON_SIZE_SMALL, LEFT));
        }

        public function getLegendsButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.LEGENDS, BUTTON_SIZE_SMALL, LEFT));
        }

        public function getServersButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.SERVERS, BUTTON_SIZE_SMALL, RIGHT));
        }

        public function getLanguagesButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.LANGUAGES, BUTTON_SIZE_SMALL, RIGHT));
        }

        public function getSupportButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.SUPPORT, BUTTON_SIZE_SMALL, RIGHT));
        }

        public function getEditorButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.EDITOR, BUTTON_SIZE_SMALL, RIGHT));
        }

        public function getQuitButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.QUIT, BUTTON_SIZE_SMALL, LEFT));
        }

        public function getBackButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.BACK, BUTTON_SIZE_LARGE, CENTER));
        }

        public function getTransferButton():TitleMenuOption{
            return (this.makeButton(ScreenTypes.TRANSFER_ACCOUNT, BUTTON_SIZE_SMALL, RIGHT));
        }

        private function makeButton(_arg1:String, _arg2:int, _arg3:String, _arg4:Boolean=false):TitleMenuOption{
            var _local5:TitleMenuOption = new TitleMenuOption(_arg1, _arg2, _arg4);
            _local5.setAutoSize(_arg3);
            _local5.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            return (_local5);
        }


    }
}//package kabam.rotmg.ui.view

