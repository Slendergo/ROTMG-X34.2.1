// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.widgets.BaseListItem

package io.decagames.rotmg.social.widgets{
    import flash.display.Sprite;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import com.company.assembleegameclient.ui.icons.IconButtonFactory;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Bitmap;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.core.StaticInjectorContext;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.social.data.SocialItemState;
    import flash.display.BitmapData;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import com.company.assembleegameclient.ui.icons.IconButton;
    import com.company.util.AssetLibrary;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import kabam.rotmg.tooltips.*;

    public class BaseListItem extends Sprite implements TooltipAble {

        protected const LIST_ITEM_WIDTH:int = 310;
        protected const LIST_ITEM_HEIGHT:int = 40;
        protected const ONLINE_COLOR:uint = 3407650;
        protected const OFFLINE_COLOR:uint = 0xB3B3B3;

        protected var _characterContainer:Sprite;
        protected var hoverTooltipDelegate:HoverTooltipDelegate;
        protected var _state:int;
        protected var _iconButtonFactory:IconButtonFactory;
        protected var listBackground:SliceScalingBitmap;
        protected var listLabel:UILabel;
        protected var listPortrait:Bitmap;
        private var toolTip_:TextToolTip;

        public function BaseListItem(_arg1:int){
            this._state = _arg1;
        }

        public function getLabelText():String{
            return (this.listLabel.text);
        }

        public function setToolTipTitle(_arg1:String, _arg2:Object=null):void{
            if (_arg1 != ""){
                if (this.toolTip_ == null){
                    this.toolTip_ = new TextToolTip(0x363636, 0x9B9B9B, "", "", 200);
                    this.hoverTooltipDelegate.setDisplayObject(this._characterContainer);
                    this.hoverTooltipDelegate.tooltip = this.toolTip_;
                }
                this.toolTip_.setTitle(new LineBuilder().setParams(_arg1, _arg2));
            }
        }

        public function setToolTipText(_arg1:String, _arg2:Object=null):void{
            if (_arg1 != ""){
                if (this.toolTip_ == null){
                    this.toolTip_ = new TextToolTip(0x363636, 0x9B9B9B, "", "", 200);
                    this.hoverTooltipDelegate.setDisplayObject(this._characterContainer);
                    this.hoverTooltipDelegate.tooltip = this.toolTip_;
                }
                this.toolTip_.setText(new LineBuilder().setParams(_arg1, _arg2));
            }
        }

        protected function init():void{
            this._iconButtonFactory = StaticInjectorContext.getInjector().getInstance(IconButtonFactory);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.setBaseItemState();
            this._characterContainer = new Sprite();
            addChild(this._characterContainer);
        }

        private function setBaseItemState():void{
            switch (this._state){
                case SocialItemState.ONLINE:
                    this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background");
                    addChild(this.listBackground);
                    break;
                case SocialItemState.OFFLINE:
                    this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background_inactive");
                    addChild(this.listBackground);
                    break;
                case SocialItemState.INVITE:
                    this.listBackground = TextureParser.instance.getSliceScalingBitmap("UI", "listitem_content_background_indicator");
                    addChild(this.listBackground);
                    break;
            }
            this.listBackground.height = this.LIST_ITEM_HEIGHT;
            this.listBackground.width = this.LIST_ITEM_WIDTH;
        }

        protected function createListLabel(_arg1:String):void{
            this.listLabel = new UILabel();
            this.listLabel.x = 40;
            this.listLabel.y = 12;
            this.listLabel.text = _arg1;
            this.setLabelColorByState(this.listLabel);
            this._characterContainer.addChild(this.listLabel);
        }

        protected function createListPortrait(_arg1:BitmapData):void{
            this.listPortrait = new Bitmap(_arg1);
            this.listPortrait.x = (-(Math.round((this.listPortrait.width / 2))) + 22);
            this.listPortrait.y = (-(Math.round((this.listPortrait.height / 2))) + 20);
            if (this.listPortrait){
                this._characterContainer.addChild(this.listPortrait);
            }
        }

        protected function setLabelColorByState(_arg1:UILabel):void{
            switch (this._state){
                case SocialItemState.ONLINE:
                    DefaultLabelFormat.friendsItemLabel(_arg1, this.ONLINE_COLOR);
                    return;
                case SocialItemState.OFFLINE:
                    DefaultLabelFormat.friendsItemLabel(_arg1, this.OFFLINE_COLOR);
                    return;
                default:
                    DefaultLabelFormat.defaultSmallPopupTitle(_arg1);
            }
        }

        protected function addButton(_arg1:String, _arg2:int, _arg3:int, _arg4:int, _arg5:String, _arg6:String=""):IconButton{
            var _local7:IconButton;
            _local7 = this._iconButtonFactory.create(AssetLibrary.getImageFromSet(_arg1, _arg2), "", "", "");
            _local7.setToolTipTitle(_arg5);
            _local7.setToolTipText(_arg6);
            _local7.x = _arg3;
            _local7.y = _arg4;
            addChild(_local7);
            return (_local7);
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


    }
}//package io.decagames.rotmg.social.widgets

