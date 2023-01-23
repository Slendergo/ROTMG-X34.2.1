// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petSkinSlot.PetSkinSlot

package io.decagames.rotmg.pets.components.petSkinSlot{
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import io.decagames.rotmg.pets.data.vo.IPetVO;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import org.osflash.signals.Signal;
    import io.decagames.rotmg.pets.components.tooltip.PetTooltip;
    import io.decagames.rotmg.utils.colors.GreyScale;
    import flash.display.BitmapData;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.tooltips.*;

    public class PetSkinSlot extends UIGridElement implements TooltipAble {

        public static const SLOT_SIZE:int = 40;

        private var _skinVO:IPetVO;
        private var skinBitmap:Bitmap;
        private var _isSkinSelectableSlot:Boolean;
        private var _selected:Boolean;
        private var _manualUpdate:Boolean;
        private var newLabel:Sprite;
        public var hoverTooltipDelegate:HoverTooltipDelegate;
        public var updatedVOSignal:Signal;

        public function PetSkinSlot(_arg1:IPetVO, _arg2:Boolean){
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.updatedVOSignal = new Signal();
            super();
            this._skinVO = _arg1;
            this._isSkinSelectableSlot = _arg2;
            this.renderSlotBackground();
            this.updateTooltip();
        }

        private function updateTooltip():void{
            if (this._skinVO){
                if (!this.hoverTooltipDelegate.getDisplayObject()){
                    this.hoverTooltipDelegate.setDisplayObject(this);
                };
                this.hoverTooltipDelegate.tooltip = new PetTooltip(this._skinVO);
            };
        }

        public function set selected(_arg1:Boolean):void{
            this._selected = _arg1;
            this.renderSlotBackground();
        }

        private function renderSlotBackground():void{
            this.graphics.clear();
            this.graphics.beginFill(((this._selected) ? 15306295 : ((((this._isSkinSelectableSlot) && (this._skinVO.isOwned))) ? this._skinVO.rarity.backgroundColor : 0x1D1D1D)));
            this.graphics.drawRect(-1, -1, (SLOT_SIZE + 2), (SLOT_SIZE + 2));
        }

        public function get skinVO():IPetVO{
            return (this._skinVO);
        }

        public function set skinVO(_arg1:IPetVO):void{
            this._skinVO = _arg1;
            this.updateTooltip();
            this.updatedVOSignal.dispatch();
        }

        public function addSkin(_arg1:BitmapData):void{
            this.clearSkinBitmap();
            if (_arg1 == null){
                this.graphics.clear();
                return;
            };
            this.renderSlotBackground();
            this.clearNewLabel();
            if (((this._isSkinSelectableSlot) && (!(this._skinVO.isOwned)))){
                _arg1 = GreyScale.setGreyScale(_arg1);
            };
            this.skinBitmap = new Bitmap(_arg1);
            this.skinBitmap.x = Math.round(((SLOT_SIZE - _arg1.width) / 2));
            this.skinBitmap.y = Math.round(((SLOT_SIZE - _arg1.height) / 2));
            addChild(this.skinBitmap);
            if (this._skinVO.isNew){
                this.newLabel = this.createNewLabel(24);
                addChild(this.newLabel);
            };
        }

        private function createNewLabel(_arg1:int):Sprite{
            var _local2:Sprite = new Sprite();
            _local2.graphics.beginFill(0xFFFFFF);
            _local2.graphics.drawRect(0, 0, _arg1, 9);
            _local2.graphics.endFill();
            var _local3:UILabel = new UILabel();
            DefaultLabelFormat.newSkinLabel(_local3);
            _local3.width = _arg1;
            _local3.wordWrap = true;
            _local3.text = "NEW";
            _local3.y = -1;
            _local2.addChild(_local3);
            return (_local2);
        }

        public function clearNewLabel():void{
            if (((this.newLabel) && (this.newLabel.parent))){
                removeChild(this.newLabel);
            };
        }

        override public function dispose():void{
            this.clearSkinBitmap();
            super.dispose();
        }

        public function get isSkinSelectableSlot():Boolean{
            return (this._isSkinSelectableSlot);
        }

        public function setShowToolTipSignal(_arg1:ShowTooltipSignal):void{
            this.hoverTooltipDelegate.setShowToolTipSignal(_arg1);
        }

        public function getShowToolTip():ShowTooltipSignal{
            return (this.hoverTooltipDelegate.getShowToolTip());
        }

        public function setHideToolTipsSignal(_arg1:HideTooltipsSignal):void{
            this.hoverTooltipDelegate.setHideToolTipsSignal(_arg1);
        }

        public function getHideToolTips():HideTooltipsSignal{
            return (this.hoverTooltipDelegate.getHideToolTips());
        }

        private function clearSkinBitmap():void{
            if (((this.skinBitmap) && (this.skinBitmap.bitmapData))){
                this.skinBitmap.bitmapData.dispose();
            };
        }

        public function get manualUpdate():Boolean{
            return (this._manualUpdate);
        }

        public function set manualUpdate(_arg1:Boolean):void{
            this._manualUpdate = _arg1;
        }


    }
}//package io.decagames.rotmg.pets.components.petSkinSlot

