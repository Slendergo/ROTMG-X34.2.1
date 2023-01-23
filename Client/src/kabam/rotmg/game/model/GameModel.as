// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.game.model.GameModel

package kabam.rotmg.game.model{
    import com.company.assembleegameclient.objects.Player;
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.objects.GameObject;

    public class GameModel {

        public var player:Player;
        public var gameObjects:Dictionary;


        public function getGameObject(_arg1:int):GameObject{
            var _local2:GameObject = this.gameObjects[_arg1];
            if (((!(_local2)) && ((this.player.objectId_ == _arg1)))){
                _local2 = this.player;
            };
            return (_local2);
        }


    }
}//package kabam.rotmg.game.model

