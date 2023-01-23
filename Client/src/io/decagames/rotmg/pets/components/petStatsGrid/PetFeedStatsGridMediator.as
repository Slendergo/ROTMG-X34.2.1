// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petStatsGrid.PetFeedStatsGridMediator

package io.decagames.rotmg.pets.components.petStatsGrid{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.pets.signals.SelectPetSignal;
    import io.decagames.rotmg.pets.signals.SimulateFeedSignal;
    import io.decagames.rotmg.pets.signals.ReleasePetSignal;
    import io.decagames.rotmg.pets.data.ability.AbilitiesUtil;
    import io.decagames.rotmg.pets.data.vo.PetVO;

    public class PetFeedStatsGridMediator extends Mediator {

        [Inject]
        public var view:PetFeedStatsGrid;
        [Inject]
        public var selectPetSignal:SelectPetSignal;
        [Inject]
        public var simulateFeedSignal:SimulateFeedSignal;
        [Inject]
        public var release:ReleasePetSignal;


        override public function initialize():void{
            this.selectPetSignal.add(this.onPetSelected);
            if (((this.view.petVO) && (this.view.petVO.updated))){
                this.view.petVO.updated.add(this.VOUpdated);
            };
            this.simulateFeedSignal.add(this.simulateFeed);
            this.release.add(this.onRelease);
        }

        override public function destroy():void{
            this.selectPetSignal.remove(this.onPetSelected);
            if (((this.view.petVO) && (this.view.petVO.updated))){
                this.view.petVO.updated.remove(this.VOUpdated);
            };
            this.simulateFeedSignal.remove(this.simulateFeed);
            this.release.remove(this.onRelease);
        }

        private function onRelease(_arg1:int):void{
            this.view.updateVO(null);
        }

        private function simulateFeed(_arg1:int):void{
            var _local2:Array;
            if (this.view.petVO){
                _local2 = AbilitiesUtil.simulateAbilityUpgrade(this.view.petVO, _arg1);
                this.view.renderSimulation(_local2);
            };
        }

        private function VOUpdated():void{
            this.view.updateVO(this.view.petVO);
        }

        private function onPetSelected(_arg1:PetVO):void{
            if (((this.view.petVO) && (this.view.petVO.updated))){
                this.view.petVO.updated.remove(this.VOUpdated);
            };
            this.view.updateVO(_arg1);
            if (((this.view.petVO) && (this.view.petVO.updated))){
                this.view.petVO.updated.add(this.VOUpdated);
            };
        }


    }
}//package io.decagames.rotmg.pets.components.petStatsGrid

