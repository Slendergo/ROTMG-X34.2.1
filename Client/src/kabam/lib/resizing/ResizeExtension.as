// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.resizing.ResizeExtension

package kabam.lib.resizing{
    import robotlegs.bender.extensions.mediatorMap.MediatorMapExtension;
    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.api.*;

    public class ResizeExtension implements IExtension {


        public function extend(_arg1:IContext):void{
            _arg1.extend(MediatorMapExtension);
            _arg1.configure(ResizeConfig);
        }


    }
}//package kabam.lib.resizing

