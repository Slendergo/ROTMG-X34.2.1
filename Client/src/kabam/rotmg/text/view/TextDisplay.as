// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.text.view.TextDisplay

package kabam.rotmg.text.view{
    import kabam.rotmg.text.model.FontModel;
    import kabam.rotmg.text.model.TextAndMapProvider;

    public class TextDisplay extends TextFieldDisplayConcrete {

        public var text:TextFieldDisplayConcrete;

        public function TextDisplay(_arg1:FontModel, _arg2:TextAndMapProvider){
            setFont(_arg1.getFont());
            setTextField(_arg2.getTextField());
            setStringMap(_arg2.getStringMap());
        }

    }
}//package kabam.rotmg.text.view

