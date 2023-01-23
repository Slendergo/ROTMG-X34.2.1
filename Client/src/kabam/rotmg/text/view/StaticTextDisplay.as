// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.text.view.StaticTextDisplay

package kabam.rotmg.text.view{
    import kabam.rotmg.core.StaticInjectorContext;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.text.model.FontModel;
    import kabam.rotmg.text.model.TextAndMapProvider;

    public class StaticTextDisplay extends TextDisplay {

        public function StaticTextDisplay(){
            var _local1:Injector = StaticInjectorContext.getInjector();
            super(_local1.getInstance(FontModel), _local1.getInstance(TextAndMapProvider));
        }

    }
}//package kabam.rotmg.text.view

