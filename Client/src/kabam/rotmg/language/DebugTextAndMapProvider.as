// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.language.DebugTextAndMapProvider

package kabam.rotmg.language{
    import kabam.rotmg.language.model.DebugStringMap;
    import kabam.rotmg.text.view.DebugTextField;
    import flash.text.TextField;
    import kabam.rotmg.language.model.StringMap;
    import kabam.rotmg.text.model.*;

    public class DebugTextAndMapProvider implements TextAndMapProvider {

        [Inject]
        public var debugStringMap:DebugStringMap;


        public function getTextField():TextField{
            var _local1:DebugTextField = new DebugTextField();
            _local1.debugStringMap = this.debugStringMap;
            return (_local1);
        }

        public function getStringMap():StringMap{
            return (this.debugStringMap);
        }


    }
}//package kabam.rotmg.language

