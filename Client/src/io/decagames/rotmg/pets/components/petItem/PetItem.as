// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petItem.PetItem

package io.decagames.rotmg.pets.components.petItem{
    import flash.display.Sprite;
    import io.decagames.rotmg.pets.components.petIcon.PetIcon;
    import io.decagames.rotmg.pets.utils.ItemBackgroundFactory;
    import io.decagames.rotmg.pets.data.vo.PetVO;
    import kabam.rotmg.pets.view.dialogs.*;

    public class PetItem extends Sprite implements Disableable {

        public static const TOP_LEFT:String = "topLeft";
        public static const TOP_RIGHT:String = "topRight";
        public static const BOTTOM_RIGHT:String = "bottomRight";
        public static const BOTTOM_LEFT:String = "bottomLeft";
        public static const REGULAR:String = "regular";
        private static const CUT_STATES:Array = [TOP_LEFT, TOP_RIGHT, BOTTOM_RIGHT, BOTTOM_LEFT];

        private var petIcon:PetIcon;
        private var background:String;
        private var size:int;
        private var backgroundGraphic:PetItemBackground;
        private var defaultBackgroundColor:uint;
        private var defaultSelectedColor:uint = 15306295;

        public function PetItem(_arg1:uint=0x545454):void{
            this.defaultBackgroundColor = _arg1;
        }

        public function setPetIcon(_arg1:PetIcon):void{
            this.petIcon = _arg1;
            this.petIcon.x = -8;
            this.petIcon.y = -8;
            addChild(_arg1);
        }

        public function disable():void{
            this.petIcon.disable();
        }

        public function isEnabled():Boolean{
            return (this.petIcon.isEnabled());
        }

        public function setSize(_arg1:int):void{
            this.size = _arg1;
        }

        public function setBackground(_arg1:String, _arg2:uint, _arg3:Number):void{
            this.background = _arg1;
            if (this.backgroundGraphic){
                removeChild(this.backgroundGraphic);
            };
            this.backgroundGraphic = PetItemBackground(ItemBackgroundFactory.create(this.size, this.getCuts(), _arg2, _arg3));
            addChildAt(this.backgroundGraphic, 0);
        }

        public function set selected(_arg1:Boolean):void{
            this.setBackground(this.background, ((_arg1) ? this.defaultSelectedColor : this.defaultBackgroundColor), 1);
        }

        private function getCuts():Array{
            var _local1:Array = [0, 0, 0, 0];
            if (this.background != REGULAR){
                _local1[CUT_STATES.indexOf(this.background)] = 1;
            };
            return (_local1);
        }

        public function getBackground():String{
            return (this.background);
        }

        public function getPetVO():PetVO{
            return (this.petIcon.getPetVO());
        }


    }
}//package io.decagames.rotmg.pets.components.petItem

