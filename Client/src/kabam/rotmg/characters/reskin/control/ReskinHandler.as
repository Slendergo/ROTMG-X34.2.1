// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.characters.reskin.control.ReskinHandler

package kabam.rotmg.characters.reskin.control{
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.assets.services.CharacterFactory;
    import com.company.assembleegameclient.objects.Player;
    import kabam.rotmg.classes.model.CharacterClass;
    import kabam.rotmg.classes.model.CharacterSkin;
    import kabam.rotmg.messaging.impl.outgoing.Reskin;

    public class ReskinHandler {

        [Inject]
        public var model:GameModel;
        [Inject]
        public var classes:ClassesModel;
        [Inject]
        public var factory:CharacterFactory;


        public function execute(_arg1:Reskin):void{
            var _local2:Player;
            var _local3:int;
            var _local4:CharacterClass;
            var _local5:CharacterClass;
            _local2 = ((_arg1.player) || (this.model.player));
            _local3 = _arg1.skinID;
            _local4 = this.classes.getCharacterClass(_local2.objectType_);
            _local5 = this.classes.getCharacterClass(0xFFFF);
            var _local6:CharacterSkin = ((_local5.skins.getSkin(_local3)) || (_local4.skins.getSkin(_local3)));
            _local2.skinId = _local3;
            _local2.skin = this.factory.makeCharacter(_local6.template);
            _local2.isDefaultAnimatedChar = false;
        }


    }
}//package kabam.rotmg.characters.reskin.control

