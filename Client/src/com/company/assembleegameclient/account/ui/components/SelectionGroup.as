// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.account.ui.components.SelectionGroup

package com.company.assembleegameclient.account.ui.components{

    public class SelectionGroup {

        private var selectables:Vector.<Selectable>;
        private var selected:Selectable;

        public function SelectionGroup(_arg1:Vector.<Selectable>){
            this.selectables = _arg1;
        }

        public function setSelected(_arg1:String):void{
            var _local2:Selectable;
            for each (_local2 in this.selectables) {
                if (_local2.getValue() == _arg1){
                    this.replaceSelected(_local2);
                    return;
                }
            }
        }

        public function getSelected():Selectable{
            return (this.selected);
        }

        private function replaceSelected(_arg1:Selectable):void{
            if (this.selected != null){
                this.selected.setSelected(false);
            }
            this.selected = _arg1;
            this.selected.setSelected(true);
        }


    }
}//package com.company.assembleegameclient.account.ui.components

