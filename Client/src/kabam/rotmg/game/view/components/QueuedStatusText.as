﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.view.components.QueuedStatusText

package kabam.rotmg.game.view.components{
    import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import com.company.assembleegameclient.objects.GameObject;

    public class QueuedStatusText extends CharacterStatusText {

        public var list:QueuedStatusTextList;
        public var next:QueuedStatusText;
        public var stringBuilder:StringBuilder;

        public function QueuedStatusText(_arg1:GameObject, _arg2:StringBuilder, _arg3:uint, _arg4:int, _arg5:int=0){
            this.stringBuilder = _arg2;
            super(_arg1, _arg3, _arg4, _arg5);
            setStringBuilder(_arg2);
        }

        override public function dispose():void{
            this.list.shift();
        }


    }
}//package kabam.rotmg.game.view.components

