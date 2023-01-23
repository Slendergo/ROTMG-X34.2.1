// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.windows.yard.fuse.FuseTab

package io.decagames.rotmg.pets.windows.yard.fuse{
    import io.decagames.rotmg.ui.tabs.UITab;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.shop.ShopBuyButton;
    import io.decagames.rotmg.ui.scroll.UIScrollbar;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import com.company.assembleegameclient.util.Currency;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import io.decagames.rotmg.pets.components.petItem.PetItem;

    public class FuseTab extends UITab {

        public static const MAXED_COLOR:uint = 6735914;
        public static const BAD_COLOR:uint = 0xE41800;
        public static const DEFAULT_COLOR:uint = 0xE56200;
        public static const LOW:String = "FusionStrength.Low";
        public static const BAD:String = "FusionStrength.Bad";
        public static const GOOD:String = "FusionStrength.Good";
        public static const GREAT:String = "FusionStrength.Great";
        public static const FANTASTIC:String = "FusionStrength.Fantastic";
        public static const MAXED:String = "FusionStrength.Maxed";
        public static const NONE:String = "FusionStrength.None";

        private var petsGrid:UIGrid;
        private var gridWidth:int = 220;
        private var fusionStrengthLabel:UILabel;
        private var _fuseGoldButton:ShopBuyButton;
        private var _fuseFameButton:ShopBuyButton;
        private var fuseButtonsMargin:int = 20;

        public function FuseTab(_arg1:int){
            var _local2:int;
            super("Fuse");
            this.petsGrid = new UIGrid(220, 5, 5, 85, 5);
            this.petsGrid.x = Math.round((((_arg1 - this.gridWidth) - UIScrollbar.SCROLL_SLIDER_WIDTH) / 2));
            this.petsGrid.y = 15;
            addChild(this.petsGrid);
            this.fusionStrengthLabel = new UILabel();
            DefaultLabelFormat.fusionStrengthLabel(this.fusionStrengthLabel, 0, 0);
            this.fusionStrengthLabel.width = _arg1;
            this.fusionStrengthLabel.wordWrap = true;
            this.fusionStrengthLabel.y = 102;
            addChild(this.fusionStrengthLabel);
            this._fuseGoldButton = new ShopBuyButton(0, Currency.GOLD);
            this._fuseFameButton = new ShopBuyButton(0, Currency.FAME);
            this._fuseGoldButton.width = (this._fuseFameButton.width = 100);
            this._fuseGoldButton.y = (this._fuseFameButton.y = 125);
            _local2 = ((_arg1 - ((this._fuseGoldButton.width + this._fuseFameButton.width) + this.fuseButtonsMargin)) / 2);
            this._fuseGoldButton.x = _local2;
            this._fuseFameButton.x = ((this._fuseGoldButton.x + this._fuseGoldButton.width) + _local2);
            addChild(this._fuseGoldButton);
            addChild(this._fuseFameButton);
        }

        private static function getKeyFor(_arg1:Number):String{
            if (isMaxed(_arg1)){
                return (MAXED);
            };
            if (_arg1 > 0.8){
                return (FANTASTIC);
            };
            if (_arg1 > 0.6){
                return (GREAT);
            };
            if (_arg1 > 0.4){
                return (GOOD);
            };
            if (_arg1 > 0.2){
                return (LOW);
            };
            return (BAD);
        }

        private static function isMaxed(_arg1:Number):Boolean{
            return ((Math.abs((_arg1 - 1)) < 0.001));
        }

        private static function isBad(_arg1:Number):Boolean{
            return ((_arg1 < 0.2));
        }


        public function setStrengthPercentage(_arg1:Number, _arg2:Boolean=false):void{
            var _local3:String;
            if (_arg2){
                this.fusionStrengthLabel.text = "This pet is at its highest Rarity";
            }
            else {
                if (_arg1 == -1){
                    this.fusionStrengthLabel.text = "Select a Pet to Fuse";
                }
                else {
                    _local3 = LineBuilder.getLocalizedStringFromKey(getKeyFor(_arg1));
                    this.fusionStrengthLabel.text = (_local3 + " Fusion");
                    DefaultLabelFormat.fusionStrengthLabel(this.fusionStrengthLabel, this.colorText(_arg1), _local3.length);
                };
            };
        }

        public function clearGrid():void{
            this.petsGrid.clearGrid();
        }

        public function addPet(_arg1:PetItem):void{
            var _local2:UIGridElement = new UIGridElement();
            _local2.addChild(_arg1);
            this.petsGrid.addGridElement(_local2);
        }

        public function get fuseGoldButton():ShopBuyButton{
            return (this._fuseGoldButton);
        }

        public function get fuseFameButton():ShopBuyButton{
            return (this._fuseFameButton);
        }

        private function colorText(_arg1:Number):uint{
            if (isMaxed(_arg1)){
                return (MAXED_COLOR);
            };
            if (isBad(_arg1)){
                return (BAD_COLOR);
            };
            return (DEFAULT_COLOR);
        }


    }
}//package io.decagames.rotmg.pets.windows.yard.fuse

