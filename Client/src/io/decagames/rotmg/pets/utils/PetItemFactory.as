// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.utils.PetItemFactory

package io.decagames.rotmg.pets.utils{
    import io.decagames.rotmg.pets.components.petIcon.PetIconFactory;
    import io.decagames.rotmg.pets.components.petItem.PetItem;
    import io.decagames.rotmg.pets.components.petIcon.PetIcon;
    import io.decagames.rotmg.pets.data.vo.PetVO;

    public class PetItemFactory {

        [Inject]
        public var petIconFactory:PetIconFactory;


        public function create(_arg1:PetVO, _arg2:int, _arg3:uint=0x545454, _arg4:Number=1):PetItem{
            var _local5:PetItem = new PetItem(_arg3);
            var _local6:PetIcon = this.petIconFactory.create(_arg1, _arg2);
            _local5.setPetIcon(_local6);
            _local5.setSize(_arg2);
            _local5.setBackground(PetItem.REGULAR, _arg3, _arg4);
            return (_local5);
        }


    }
}//package io.decagames.rotmg.pets.utils

