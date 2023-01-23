// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.screens.charrects.MyPlayerToolTipFactory

package com.company.assembleegameclient.screens.charrects{
    import com.company.assembleegameclient.ui.tooltip.MyPlayerToolTip;
    import com.company.assembleegameclient.appengine.CharacterStats;

    public class MyPlayerToolTipFactory {


        public function create(_arg1:String, _arg2:XML, _arg3:CharacterStats):MyPlayerToolTip{
            return (new MyPlayerToolTip(_arg1, _arg2, _arg3));
        }


    }
}//package com.company.assembleegameclient.screens.charrects

