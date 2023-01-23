﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.menu.PlayerGroupMenu

package com.company.assembleegameclient.ui.menu{
    import com.company.assembleegameclient.ui.GameObjectListItem;
    import com.company.assembleegameclient.map.AbstractMap;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.ui.LineBreakDesign;
    import org.osflash.signals.Signal;
    import flash.events.MouseEvent;
    import flash.events.Event;

    public class PlayerGroupMenu extends Menu {

        private var playerPanels_:Vector.<GameObjectListItem>;
        private var posY:uint = 4;
        public var map_:AbstractMap;
        public var players_:Vector.<Player>;
        public var teleportOption_:MenuOption;
        public var lineBreakDesign_:LineBreakDesign;
        public var unableToTeleport:Signal;

        public function PlayerGroupMenu(_arg1:AbstractMap, _arg2:Vector.<Player>){
            this.playerPanels_ = new Vector.<GameObjectListItem>();
            this.unableToTeleport = new Signal();
            super(0x363636, 0xFFFFFF);
            this.map_ = _arg1;
            this.players_ = _arg2.concat();
            this.createHeader();
            this.createPlayerList();
        }

        private function createPlayerList():void{
            var _local1:Player;
            var _local2:GameObjectListItem;
            for each (_local1 in this.players_) {
                _local2 = new GameObjectListItem(0xB3B3B3, true, _local1);
                _local2.x = 0;
                _local2.y = this.posY;
                addChild(_local2);
                this.playerPanels_.push(_local2);
                _local2.textReady.addOnce(this.onTextChanged);
                this.posY = (this.posY + 32);
            };
        }

        private function onTextChanged():void{
            var _local1:GameObjectListItem;
            draw();
            for each (_local1 in this.playerPanels_) {
                _local1.textReady.remove(this.onTextChanged);
            };
        }

        private function createHeader():void{
            if (this.map_.allowPlayerTeleport()){
                this.teleportOption_ = new TeleportMenuOption(this.map_.player_);
                this.teleportOption_.x = 8;
                this.teleportOption_.y = 8;
                this.teleportOption_.addEventListener(MouseEvent.CLICK, this.onTeleport);
                addChild(this.teleportOption_);
                this.lineBreakDesign_ = new LineBreakDesign(150, 0x1C1C1C);
                this.lineBreakDesign_.x = 6;
                this.lineBreakDesign_.y = 40;
                addChild(this.lineBreakDesign_);
                this.posY = 52;
            };
        }

        private function onTeleport(_arg1:Event):void{
            var _local4:Player;
            var _local2:Player = this.map_.player_;
            var _local3:Player;
            for each (_local4 in this.players_) {
                if (_local2.isTeleportEligible(_local4)){
                    _local3 = _local4;
                    if (_local2.msUtilTeleport() > Player.MS_BETWEEN_TELEPORT){
                        if (_local4.isFellowGuild_) break;
                    }
                    else {
                        break;
                    };
                };
            };
            if (_local3 != null){
                _local2.teleportTo(_local3);
            }
            else {
                this.unableToTeleport.dispatch();
            };
            remove();
        }


    }
}//package com.company.assembleegameclient.ui.menu

