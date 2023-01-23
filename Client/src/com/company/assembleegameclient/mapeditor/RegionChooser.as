// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.RegionChooser

package com.company.assembleegameclient.mapeditor{
    public class RegionChooser extends Chooser {

        public function RegionChooser(){
            var _local1:XML;
            var _local2:RegionElement;
            super(Layer.REGION);
            for each (_local1 in GroupDivider.GROUPS["Regions"]) {
                _local2 = new RegionElement(_local1);
                addElement(_local2);
            };
            hasBeenLoaded = true;
        }

    }
}//package com.company.assembleegameclient.mapeditor

