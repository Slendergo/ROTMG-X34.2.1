// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.map.mapoverlay.IMapOverlayElement

package com.company.assembleegameclient.map.mapoverlay{
    import com.company.assembleegameclient.map.Camera;
    import com.company.assembleegameclient.objects.GameObject;

    public interface IMapOverlayElement {

        function draw(_arg1:Camera, _arg2:int):Boolean;
        function dispose():void;
        function getGameObject():GameObject;

    }
}//package com.company.assembleegameclient.map.mapoverlay

