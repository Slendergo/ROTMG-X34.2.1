// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.widgets.FriendListItem

package io.decagames.rotmg.social.widgets{
    import com.company.assembleegameclient.ui.icons.IconButton;
    import io.decagames.rotmg.social.model.FriendVO;
    import flash.events.Event;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.text.model.TextKey;
    import io.decagames.rotmg.social.data.SocialItemState;
    import com.company.assembleegameclient.util.TimeUtil;

    public class FriendListItem extends BaseListItem {

        public var teleportButton:IconButton;
        public var messageButton:IconButton;
        public var removeButton:IconButton;
        public var acceptButton:IconButton;
        public var rejectButton:IconButton;
        public var blockButton:IconButton;
        private var _vo:FriendVO;

        public function FriendListItem(_arg1:FriendVO, _arg2:int){
            super(_arg2);
            this._vo = _arg1;
            this.init();
        }

        override protected function init():void{
            super.init();
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
            this.setState();
            createListLabel(this._vo.getName());
            createListPortrait(this._vo.getPortrait());
        }

        private function onRemoved(_arg1:Event):void{
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
            ((this.teleportButton) && (this.teleportButton.destroy()));
            ((this.messageButton) && (this.messageButton.destroy()));
            ((this.removeButton) && (this.removeButton.destroy()));
            ((this.acceptButton) && (this.acceptButton.destroy()));
            ((this.rejectButton) && (this.rejectButton.destroy()));
            ((this.blockButton) && (this.blockButton.destroy()));
        }

        private function setState():void{
            var _local1:String;
            var _local2:String;
            var _local3:String;
            switch (_state){
                case SocialItemState.ONLINE:
                    _local1 = this._vo.getServerName();
                    _local2 = ((Parameters.data_.preferredServer) ? Parameters.data_.preferredServer : Parameters.data_.bestServer);
                    if (_local2 != _local1){
                        _local3 = ((("Your friend is playing on server: " + _local1) + ". ") + "Clicking this will take you to this server.");
                        this.teleportButton = addButton("lofiInterface2", 3, 230, 12, TextKey.FRIEND_TELEPORT_TITLE, _local3);
                    };
                    this.messageButton = addButton("lofiInterfaceBig", 21, 0xFF, 12, TextKey.PLAYERMENU_PM);
                    this.removeButton = addButton("lofiInterfaceBig", 12, 280, 12, TextKey.FRIEND_REMOVE_BUTTON);
                    return;
                case SocialItemState.OFFLINE:
                    hoverTooltipDelegate.setDisplayObject(_characterContainer);
                    setToolTipTitle("Last Seen:");
                    setToolTipText((TimeUtil.humanReadableTime(this._vo.lastLogin) + " ago!"));
                    this.removeButton = addButton("lofiInterfaceBig", 12, 280, 12, TextKey.FRIEND_REMOVE_BUTTON, TextKey.FRIEND_REMOVE_BUTTON_DESC);
                    return;
                case SocialItemState.INVITE:
                    this.acceptButton = addButton("lofiInterfaceBig", 11, 230, 12, TextKey.GUILD_ACCEPT);
                    this.rejectButton = addButton("lofiInterfaceBig", 12, 0xFF, 12, TextKey.GUILD_REJECTION);
                    this.blockButton = addButton("lofiInterfaceBig", 8, 280, 12, TextKey.FRIEND_BLOCK_BUTTON, TextKey.FRIEND_BLOCK_BUTTON_DESC);
                    return;
            };
        }

        public function get vo():FriendVO{
            return (this._vo);
        }


    }
}//package io.decagames.rotmg.social.widgets

