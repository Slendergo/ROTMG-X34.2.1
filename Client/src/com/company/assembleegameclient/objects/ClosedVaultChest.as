// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.ClosedVaultChest

package com.company.assembleegameclient.objects{
    import kabam.rotmg.text.model.TextKey;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import flash.display.BitmapData;

    public class ClosedVaultChest extends SellableObject {

        public function ClosedVaultChest(_arg1:XML){
            super(_arg1);
        }

        override public function soldObjectName():String{
            return (TextKey.VAULT_CHEST);
        }

        override public function soldObjectInternalName():String{
            return ("Vault Chest");
        }

        override public function getTooltip():ToolTip{
            var _local1:ToolTip = new TextToolTip(0x363636, 0x9B9B9B, this.soldObjectName(), TextKey.VAULT_CHEST_DESCRIPTION, 200);
            return (_local1);
        }

        override public function getSellableType():int{
            return (ObjectLibrary.idToType_["Vault Chest"]);
        }

        override public function getIcon():BitmapData{
            return (ObjectLibrary.getRedrawnTextureFromType(ObjectLibrary.idToType_["Vault Chest"], 80, true));
        }


    }
}//package com.company.assembleegameclient.objects

