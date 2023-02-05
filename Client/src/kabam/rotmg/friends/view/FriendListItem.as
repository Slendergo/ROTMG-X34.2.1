﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.friends.view.FriendListItem

package kabam.rotmg.friends.view{
    import flash.display.Bitmap;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import com.company.assembleegameclient.ui.icons.IconButton;
    import io.decagames.rotmg.social.model.FriendVO;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import kabam.rotmg.core.StaticInjectorContext;
    import com.company.assembleegameclient.ui.icons.IconButtonFactory;
    import com.company.util.AssetLibrary;
    import kabam.rotmg.text.model.TextKey;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import io.decagames.rotmg.social.config.FriendsActions;

    public class FriendListItem extends FListItem {

        private const ONLINE_COLOR:uint = 3407650;
        private const NORMAL_COLOR:uint = 0xB3B3B3;

        private var _senderName:String;
        private var _serverName:String;
        private var _isOnline:Boolean;
        private var _portrait:Bitmap;
        private var _nameText:TextFieldDisplayConcrete;
        private var _serverText:TextFieldDisplayConcrete;
        private var _whisperButton:IconButton;
        private var _jumpButton:IconButton;
        private var _removeButton:FriendRemoveButton;

        public function FriendListItem(_arg1:FriendVO, _arg2:Number, _arg3:Number, _arg4:String){
            this.init(_arg2, _arg3);
            this.update(_arg1, _arg4);
        }

        override protected function init(_arg1:Number, _arg2:Number):void{
            this.graphics.beginFill(0x666666);
            this.graphics.drawRoundRect(0, 0, _arg1, _arg2, 10, 10);
            this.graphics.endFill();
            this._portrait = new Bitmap();
            this._portrait.x = 2;
            this._portrait.y = -8;
            this._portrait.scaleX = (this._portrait.scaleY = 1.2);
            addChild(this._portrait);
            this._nameText = new TextFieldDisplayConcrete().setSize(18).setColor(((this._isOnline) ? this.ONLINE_COLOR : this.NORMAL_COLOR));
            this._nameText.setStringBuilder(new StaticStringBuilder(this._senderName));
            this._nameText.y = 4;
            addChild(this._nameText);
            this._serverText = new TextFieldDisplayConcrete().setSize(16).setColor(this.NORMAL_COLOR);
            this._serverText.x = (this.width - 250);
            this._serverText.setStringBuilder(new StaticStringBuilder(this._serverName));
            addChild(this._serverText);
            var _local3:IconButtonFactory = StaticInjectorContext.getInjector().getInstance(IconButtonFactory);
            this._jumpButton = _local3.create(AssetLibrary.getImageFromSet("lofiInterface2", 3), TextKey.FRIEND_TELEPORT_TITLE, "", "");
            this._jumpButton.setToolTipTitle(TextKey.FRIEND_TELEPORT_TITLE);
            this._jumpButton.x = (this.width - 270);
            this._jumpButton.y = 4;
            this._jumpButton.addEventListener(MouseEvent.CLICK, this.onJumpClicked);
            addChild(this._jumpButton);
            this._whisperButton = _local3.create(AssetLibrary.getImageFromSet("lofiInterfaceBig", 21), TextKey.PLAYERMENU_PM, "", "");
            this._whisperButton.x = (this.width - 130);
            this._whisperButton.y = 4;
            this._whisperButton.addEventListener(MouseEvent.CLICK, this.onWhisperClicked);
            addChild(this._whisperButton);
            this._removeButton = new FriendRemoveButton(TextKey.FRIEND_REMOVE_BUTTON, TextKey.FRIEND_REMOVE_BUTTON_DESC);
            this._removeButton.addEventListener(MouseEvent.CLICK, this.onRemoveClicked);
            this._removeButton.x = (this.width - 30);
            this._removeButton.y = 11;
            addChild(this._removeButton);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromState);
        }

        override public function update(_arg1:FriendVO, _arg2:String):void{
            this._portrait.bitmapData = _arg1.getPortrait();
            if (_arg1.getName() != this._senderName){
                this._senderName = _arg1.getName();
                this._nameText.x = (this._portrait.width + 8);
                this._nameText.setStringBuilder(new StaticStringBuilder(this._senderName));
                this._serverText.y = (this._nameText.y + 16);
            }
            if (_arg1.getServerName() != this._serverName){
                this._serverName = _arg1.getServerName();
                this._serverText.setStringBuilder(new StaticStringBuilder(this._serverName));
            }
            this._isOnline = _arg1.isOnline;
            this._nameText.setColor(((this._isOnline) ? this.ONLINE_COLOR : this.NORMAL_COLOR));
            this._whisperButton.visible = this._isOnline;
            this._jumpButton.visible = this._isOnline;
            this._jumpButton.setToolTipText(TextKey.FRIEND_TELEPORT_DESC, {name:this._serverName});
            this._jumpButton.enabled = !((this._serverName == _arg2));
        }

        override public function destroy():void{
            while (numChildren > 0) {
                this.removeChildAt((numChildren - 1));
            }
            this._portrait = null;
            this._nameText = null;
            this._serverText = null;
            this._whisperButton.removeEventListener(MouseEvent.CLICK, this.onWhisperClicked);
            this._whisperButton = null;
            this._jumpButton.removeEventListener(MouseEvent.CLICK, this.onJumpClicked);
            this._jumpButton = null;
            this._removeButton.removeEventListener(MouseEvent.CLICK, this.onRemoveClicked);
            this._removeButton.destroy();
            this._removeButton = null;
        }

        private function onRemovedFromState(_arg1:Event):void{
            this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromState);
            this.destroy();
        }

        private function onRemoveClicked(_arg1:MouseEvent):void{
            actionSignal.dispatch(FriendsActions.REMOVE, this._senderName);
        }

        private function onWhisperClicked(_arg1:MouseEvent):void{
            actionSignal.dispatch(FriendsActions.WHISPER, this._senderName);
        }

        private function onJumpClicked(_arg1:MouseEvent):void{
            actionSignal.dispatch(FriendsActions.JUMP, this._serverName);
        }


    }
}//package kabam.rotmg.friends.view

