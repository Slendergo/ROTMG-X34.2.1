﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.commands.DeactivatePetCommand

package io.decagames.rotmg.pets.commands{
    import robotlegs.bender.bundles.mvcs.Command;
    import kabam.lib.net.api.MessageProvider;
    import kabam.lib.net.impl.SocketServer;
    import io.decagames.rotmg.pets.data.PetsModel;
    import kabam.rotmg.messaging.impl.GameServerConnection;
    import kabam.rotmg.messaging.impl.outgoing.ActivePetUpdateRequest;
    import io.decagames.rotmg.pets.utils.PetsConstants;

    public class DeactivatePetCommand extends Command {

        [Inject]
        public var instanceID:uint;
        [Inject]
        public var messages:MessageProvider;
        [Inject]
        public var server:SocketServer;
        [Inject]
        public var model:PetsModel;


        override public function execute():void{
            var _local1:ActivePetUpdateRequest = (this.messages.require(GameServerConnection.ACTIVE_PET_UPDATE_REQUEST) as ActivePetUpdateRequest);
            _local1.instanceid = this.instanceID;
            _local1.commandtype = PetsConstants.FOLLOWING;
            this.server.sendMessage(_local1);
        }


    }
}//package io.decagames.rotmg.pets.commands

