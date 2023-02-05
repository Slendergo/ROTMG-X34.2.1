// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.SocialPopupView

package io.decagames.rotmg.social{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.textField.InputTextField;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import io.decagames.rotmg.ui.tabs.UITabs;
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.geom.Rectangle;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.gird.UIGridElement;
    import io.decagames.rotmg.social.widgets.FriendListItem;
    import io.decagames.rotmg.social.widgets.GuildInfoItem;
    import flash.text.TextFormatAlign;
    import io.decagames.rotmg.social.widgets.GuildListItem;
    import io.decagames.rotmg.ui.tabs.TabButton;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.util.AssetLibrary;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import io.decagames.rotmg.ui.tabs.UITab;
    import io.decagames.rotmg.ui.scroll.UIScrollbar;
    import flash.text.TextFieldAutoSize;

    public class SocialPopupView extends ModalPopup {

        public static const SOCIAL_LABEL:String = "Social";
        public static const FRIEND_TAB_LABEL:String = "Friends";
        public static const GUILD_TAB_LABEL:String = "Guild";
        public static const MAX_VISIBLE_INVITATIONS:int = 3;
        public static const DEFAULT_NO_GUILD_MESSAGE:String = ("You have not yet joined a Guild,\n" + "join a Guild to find Players to play with or\n create your own Guild.");

        public var search:InputTextField;
        public var addButton:SliceScalingButton;
        private var contentInset:SliceScalingBitmap;
        private var friendsGrid:UIGrid;
        private var guildsGrid:UIGrid;
        private var _tabs:UITabs;
        private var _tabContent:Sprite;

        public function SocialPopupView(){
            super(350, 505, SOCIAL_LABEL, DefaultLabelFormat.defaultSmallPopupTitle, new Rectangle(0, 0, 350, 565));
            this.init();
        }

        public function addFriendCategory(_arg1:String):void{
            var _local3:UILabel;
            var _local2:UIGridElement = new UIGridElement();
            _local3 = new UILabel();
            _local3.text = _arg1;
            DefaultLabelFormat.defaultSmallPopupTitle(_local3);
            _local2.addChild(_local3);
            this.friendsGrid.addGridElement(_local2);
        }

        public function addFriend(_arg1:FriendListItem):void{
            var _local2:UIGridElement = new UIGridElement();
            _local2.addChild(_arg1);
            this.friendsGrid.addGridElement(_local2);
        }

        public function addGuildInfo(_arg1:GuildInfoItem):void{
            var _local2:UIGridElement;
            _local2 = new UIGridElement();
            _local2.addChild(_arg1);
            _local2.x = ((_contentWidth - _local2.width) / 2);
            _local2.y = 10;
            this._tabContent.addChild(_local2);
        }

        public function addGuildCategory(_arg1:String):void{
            var _local2:UIGridElement = new UIGridElement();
            var _local3:UILabel = new UILabel();
            _local3.text = _arg1;
            DefaultLabelFormat.defaultSmallPopupTitle(_local3);
            _local2.addChild(_local3);
            this.guildsGrid.addGridElement(_local2);
        }

        public function addGuildDefaultMessage(_arg1:String):void{
            var _local2:UIGridElement;
            var _local3:UILabel;
            _local2 = new UIGridElement();
            _local3 = new UILabel();
            _local3.width = 300;
            _local3.multiline = true;
            _local3.wordWrap = true;
            _local3.text = _arg1;
            _local3.x = (((350 - 300) / 2) - 20);
            DefaultLabelFormat.guildInfoLabel(_local3, 14, 0xB3B3B3, TextFormatAlign.CENTER);
            _local2.addChild(_local3);
            this.guildsGrid.addGridElement(_local2);
        }

        public function addGuildMember(_arg1:GuildListItem):void{
            var _local2:UIGridElement = new UIGridElement();
            _local2.addChild(_arg1);
            this.guildsGrid.addGridElement(_local2);
        }

        public function addInvites(_arg1:FriendListItem):void{
            var _local2:UIGridElement = new UIGridElement();
            _local2.addChild(_arg1);
            this.friendsGrid.addGridElement(_local2);
        }

        public function showInviteIndicator(_arg1:Boolean, _arg2:String):void{
            var _local3:TabButton = this._tabs.getTabButtonByLabel(_arg2);
            if (_local3){
                _local3.showIndicator = _arg1;
            }
        }

        public function clearFriendsList():void{
            this.friendsGrid.clearGrid();
            this.showInviteIndicator(false, FRIEND_TAB_LABEL);
        }

        public function clearGuildList():void{
            this.guildsGrid.clearGrid();
            this.showInviteIndicator(false, GUILD_TAB_LABEL);
        }

        private function init():void{
            this.friendsGrid = new UIGrid(350, 1, 3);
            this.friendsGrid.x = 9;
            this.friendsGrid.y = 15;
            this.guildsGrid = new UIGrid(350, 1, 3);
            this.guildsGrid.x = 9;
            this.createContentInset();
            this.createContentTabs();
            this.addTabs();
        }

        private function addTabs():void{
            this._tabs = new UITabs(350, true);
            var _local1:Sprite = new Sprite();
            this._tabs.addTab(this.createTab(FRIEND_TAB_LABEL, _local1, this.friendsGrid, true), true);
            var _local2:Sprite = new Sprite();
            this._tabs.addTab(this.createTab(GUILD_TAB_LABEL, _local2, this.guildsGrid), false);
            this._tabs.y = 6;
            this._tabs.x = 0;
            addChild(this._tabs);
        }

        private function createContentTabs():void{
            var _local1:SliceScalingBitmap;
            _local1 = TextureParser.instance.getSliceScalingBitmap("UI", "tab_inset_content_background", 350);
            _local1.height = 45;
            _local1.x = 0;
            _local1.y = 5;
            addChild(_local1);
        }

        private function createContentInset():void{
            this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 350);
            this.contentInset.height = 465;
            this.contentInset.x = 0;
            this.contentInset.y = 40;
            addChild(this.contentInset);
        }

        private function createSearchInputField(_arg1:int):InputTextField{
            var _local2:InputTextField = new InputTextField("Filter");
            DefaultLabelFormat.defaultSmallPopupTitle(_local2);
            _local2.width = _arg1;
            return (_local2);
        }

        private function createSearchIcon():Bitmap{
            var _local1:BitmapData = TextureRedrawer.redraw(AssetLibrary.getImageFromSet("lofiInterfaceBig", 40), 20, true, 0);
            var _local2:Bitmap = new Bitmap(_local1);
            return (_local2);
        }

        private function createAddButton():SliceScalingButton{
            var _local1:SliceScalingButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "add_button"));
            return (_local1);
        }

        private function createSearchInset(_arg1:int):SliceScalingBitmap{
            var _local2:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", _arg1);
            _local2.height = 30;
            return (_local2);
        }

        private function createTab(_arg1:String, _arg2:Sprite, _arg3:UIGrid, _arg4:Boolean=false):UITab{
            var _local8:Sprite;
            var _local5:UITab = new UITab(_arg1, true);
            this._tabContent = new Sprite();
            _arg2.x = this.contentInset.x;
            this._tabContent.addChild(_arg2);
            if (_arg4){
                this.createSearchAndAdd();
            }
            _arg2.y = ((_arg4) ? 50 : 85);
            _arg2.addChild(_arg3);
            var _local6:int = ((_arg4) ? 410 : 375);
            var _local7:UIScrollbar = new UIScrollbar(_local6);
            _local7.mouseRollSpeedFactor = 1;
            _local7.scrollObject = _local5;
            _local7.content = _arg2;
            _local7.x = ((this.contentInset.x + this.contentInset.width) - 25);
            _local7.y = _arg2.y;
            this._tabContent.addChild(_local7);
            _local8 = new Sprite();
            _local8.graphics.beginFill(0);
            _local8.graphics.drawRect(0, 0, 350, (_local6 - 5));
            _local8.x = _arg2.x;
            _local8.y = _arg2.y;
            _arg2.mask = _local8;
            this._tabContent.addChild(_local8);
            _local5.addContent(this._tabContent);
            return (_local5);
        }

        private function createSearchAndAdd():void{
            var _local2:Bitmap;
            this.addButton = this.createAddButton();
            this.addButton.x = 7;
            this.addButton.y = 6;
            this._tabContent.addChild(this.addButton);
            var _local1:SliceScalingBitmap = this.createSearchInset(296);
            _local1.x = (this.addButton.x + this.addButton.width);
            _local1.y = 10;
            this._tabContent.addChild(_local1);
            _local2 = this.createSearchIcon();
            _local2.x = _local1.x;
            _local2.y = 5;
            this._tabContent.addChild(_local2);
            this.search = this.createSearchInputField(250);
            this.search.autoSize = TextFieldAutoSize.NONE;
            this.search.multiline = false;
            this.search.wordWrap = false;
            this.search.x = ((_local2.x + _local2.width) - 5);
            this.search.y = (_local1.y + 7);
            this._tabContent.addChild(this.search);
        }

        public function get tabs():UITabs{
            return (this._tabs);
        }


    }
}//package io.decagames.rotmg.social

