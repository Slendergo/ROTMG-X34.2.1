// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petInfoSlot.PetInfoSlot

package io.decagames.rotmg.pets.components.petInfoSlot{
    import flash.display.Sprite;
    import io.decagames.rotmg.pets.components.petPortrait.PetPortrait;
    import io.decagames.rotmg.pets.data.vo.IPetVO;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.pets.components.petStatsGrid.PetFeedStatsGrid;
    import io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGrid;

    public class PetInfoSlot extends Sprite {

        public static const INFO_HEIGHT:int = 207;
        public static const STATS_WIDTH:int = 150;
        public static const FEED_STATS_WIDTH:int = 195;

        private var petPortrait:PetPortrait;
        private var _switchable:Boolean;
        private var _slotWidth:int;
        private var showStats:Boolean;
        private var _showCurrentPet:Boolean;
        private var animations:Boolean;
        private var isRarityLabelHidden:Boolean;
        private var showReleaseButton:Boolean;
        private var _useFeedStats:Boolean;
        private var _petVO:IPetVO;
        private var _showFeedPower:Boolean;
        private var statsGrid:UIGrid;

        public function PetInfoSlot(_arg1:int, _arg2:Boolean, _arg3:Boolean, _arg4:Boolean, _arg5:Boolean=false, _arg6:Boolean=false, _arg7:Boolean=false, _arg8:Boolean=false, _arg9:Boolean=false){
            this._switchable = _arg2;
            this._slotWidth = _arg1;
            this._showFeedPower = _arg8;
            this._showCurrentPet = _arg4;
            this.showStats = _arg3;
            this.animations = _arg5;
            this.showReleaseButton = _arg7;
            this.isRarityLabelHidden = _arg6;
            this._useFeedStats = _arg9;
            var _local10:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", _arg1);
            addChild(_local10);
            _local10.height = INFO_HEIGHT;
            _local10.x = 0;
            _local10.y = 0;
        }

        public function showPetInfo(_arg1:IPetVO, _arg2:Boolean=true):void{
            var _local3:int;
            this._petVO = _arg1;
            if (!this.petPortrait){
                this.petPortrait = new PetPortrait(this._slotWidth, _arg1, this._switchable, this._showCurrentPet, this.showReleaseButton, this._showFeedPower);
                this.petPortrait.enableAnimation = this.animations;
                addChild(this.petPortrait);
            }
            else {
                this.petPortrait.petVO = _arg1;
            }
            if (this.isRarityLabelHidden){
                this.petPortrait.hideRarityLabel();
            }
            if (((this.showStats) && (_arg2))){
                this.statsGrid = ((this._useFeedStats) ? new PetFeedStatsGrid(FEED_STATS_WIDTH, _arg1) : new PetStatsGrid(STATS_WIDTH, _arg1));
                addChild(this.statsGrid);
                this.statsGrid.y = ((this._useFeedStats) ? 132 : 130);
                _local3 = ((this._useFeedStats) ? FEED_STATS_WIDTH : STATS_WIDTH);
                this.statsGrid.x = Math.round(((this._slotWidth - _local3) / 2));
            }
        }

        public function get slotWidth():int{
            return (this._slotWidth);
        }

        public function get showCurrentPet():Boolean{
            return (this._showCurrentPet);
        }

        public function get petVO():IPetVO{
            return (this._petVO);
        }


    }
}//package io.decagames.rotmg.pets.components.petInfoSlot

