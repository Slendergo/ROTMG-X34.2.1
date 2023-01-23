﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.characters.reskin.control.ReskinCharacterCommand

package kabam.rotmg.characters.reskin.control{
    import kabam.rotmg.classes.model.CharacterSkin;
    import kabam.lib.net.api.MessageProvider;
    import kabam.lib.net.impl.SocketServer;
    import kabam.rotmg.messaging.impl.GameServerConnection;
    import kabam.rotmg.messaging.impl.outgoing.Reskin;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.game.model.GameModel;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.parameters.Parameters;

    public class ReskinCharacterCommand {

        [Inject]
        public var skin:CharacterSkin;
        [Inject]
        public var messages:MessageProvider;
        [Inject]
        public var server:SocketServer;


        public function execute():void{
            var _local1:Reskin = (this.messages.require(GameServerConnection.RESKIN) as Reskin);
            _local1.skinID = this.skin.id;
            var _local2:Player = StaticInjectorContext.getInjector().getInstance(GameModel).player;
            if (_local2 != null){
                _local2.clearTextureCache();
                if (Parameters.skinTypes16.indexOf(_local1.skinID) != -1){
                    _local2.size_ = 80;
                }
                else {
                    _local2.size_ = 100;
                };
            };
            this.server.sendMessage(_local1);
        }


    }
}//package kabam.rotmg.characters.reskin.control

