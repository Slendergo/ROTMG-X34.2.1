// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.fame.data.FameTracker

package io.decagames.rotmg.fame.data{
    import io.decagames.rotmg.characterMetrics.tracker.CharactersMetricsTracker;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.core.model.PlayerModel;
    import io.decagames.rotmg.fame.data.bonus.FameBonusConfig;
    import io.decagames.rotmg.fame.data.bonus.FameBonus;
    import io.decagames.rotmg.fame.data.bonus.FameBonusID;
    import io.decagames.rotmg.characterMetrics.data.MetricsID;
    import com.company.assembleegameclient.appengine.SavedCharacter;

    public class FameTracker {

        [Inject]
        public var metrics:CharactersMetricsTracker;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var player:PlayerModel;


        private function getFameBonus(_arg1:int, _arg2:int, _arg3:int):FameBonus{
            var _local4:FameBonus = FameBonusConfig.getBonus(_arg2);
            var _local5:int = this.getCharacterLevel(_arg1);
            if (_local5 < _local4.level){
                return (null);
            };
            _local4.fameAdded = Math.floor((((_local4.added * _arg3) / 100) + _local4.numAdded));
            return (_local4);
        }

        private function getWellEquippedBonus(_arg1:int, _arg2:int):FameBonus{
            var _local3:FameBonus = FameBonusConfig.getBonus(FameBonusID.WELL_EQUIPPED);
            _local3.fameAdded = Math.floor(((_arg1 * _arg2) / 100));
            return (_local3);
        }

        public function getCurrentTotalFame(_arg1:int):TotalFame{
            var _local2:TotalFame = new TotalFame(this.currentFame(_arg1));
            var _local3:int = this.getCharacterLevel(_arg1);
            var _local4:int = this.getCharacterType(_arg1);
            if (this.player.getTotalFame() == 0){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.ANCESTOR, _local2.currentFame));
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.POTIONS_DRUNK) == 0){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.THIRSTY, _local2.currentFame));
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.SHOTS_THAT_DAMAGE) == 0){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.PACIFIST, _local2.currentFame));
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.SPECIAL_ABILITY_USES) == 0){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.MUNDANE, _local2.currentFame));
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.TELEPORTS) == 0){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.BOOTS_ON_THE_GROUND, _local2.currentFame));
            };
            if ((((((((((((((((((((this.metrics.getCharacterStat(_arg1, MetricsID.PIRATE_CAVES_COMPLETED) > 0)) && ((this.metrics.getCharacterStat(_arg1, MetricsID.UNDEAD_LAIRS_COMPLETED) > 0)))) && ((this.metrics.getCharacterStat(_arg1, MetricsID.ABYSS_OF_DEMONS_COMPLETED) > 0)))) && ((this.metrics.getCharacterStat(_arg1, MetricsID.SNAKE_PITS_COMPLETED) > 0)))) && ((this.metrics.getCharacterStat(_arg1, MetricsID.SPIDER_DENS_COMPLETED) > 0)))) && ((this.metrics.getCharacterStat(_arg1, MetricsID.SPRITE_WORLDS_COMPLETED) > 0)))) && ((this.metrics.getCharacterStat(_arg1, MetricsID.TOMBS_COMPLETED) > 0)))) && ((this.metrics.getCharacterStat(_arg1, MetricsID.TRENCHES_COMPLETED) > 0)))) && ((this.metrics.getCharacterStat(_arg1, MetricsID.JUNGLES_COMPLETED) > 0)))) && ((this.metrics.getCharacterStat(_arg1, MetricsID.MANORS_COMPLETED) > 0)))){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.TUNNEL_RAT, _local2.currentFame));
            };
            var _local5:int = this.metrics.getCharacterStat(_arg1, MetricsID.MONSTER_KILLS);
            var _local6:int = this.metrics.getCharacterStat(_arg1, MetricsID.GOD_KILLS);
            if ((_local5 + _local6) > 0){
                if ((_local6 / (_local5 + _local6)) > 0.1){
                    _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.ENEMY_OF_THE_GODS, _local2.currentFame));
                };
                if ((_local6 / (_local5 + _local6)) > 0.5){
                    _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.SLAYER_OF_THE_GODS, _local2.currentFame));
                };
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.ORYX_KILLS) > 0){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.ORYX_SLAYER, _local2.currentFame));
            };
            var _local7:int = this.metrics.getCharacterStat(_arg1, MetricsID.SHOTS);
            var _local8:int = this.metrics.getCharacterStat(_arg1, MetricsID.SHOTS_THAT_DAMAGE);
            if ((((_local8 > 0)) && ((_local7 > 0)))){
                if ((_local8 / _local7) > 0.25){
                    _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.ACCURATE, _local2.currentFame));
                };
                if ((_local8 / _local7) > 0.5){
                    _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.SHARPSHOOTER, _local2.currentFame));
                };
                if ((_local8 / _local7) > 0.75){
                    _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.SNIPER, _local2.currentFame));
                };
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.TILES_UNCOVERED) > 1000000){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.EXPLORER, _local2.currentFame));
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.TILES_UNCOVERED) > 0x3D0900){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.CARTOGRAPHER, _local2.currentFame));
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.CUBE_KILLS) == 0){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.FRIEND_OF_THE_CUBES, _local2.currentFame));
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.LEVEL_UP_ASSISTS) > 100){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.TEAM_PLAYER, _local2.currentFame));
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.LEVEL_UP_ASSISTS) > 1000){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.LEADER_OF_MEN, _local2.currentFame));
            };
            if (this.metrics.getCharacterStat(_arg1, MetricsID.QUESTS_COMPLETED) > 1000){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.DOER_OF_DEEDS, _local2.currentFame));
            };
            _local2.addBonus(this.getWellEquippedBonus(this.getCharacterFameBonus(_arg1), _local2.currentFame));
            if (_local2.currentFame > this.player.getBestCharFame()){
                _local2.addBonus(this.getFameBonus(_arg1, FameBonusID.FIRST_BORN, _local2.currentFame));
            };
            return (_local2);
        }

        private function hasMapPlayer():Boolean{
            return (((((this.hudModel.gameSprite) && (this.hudModel.gameSprite.map))) && (this.hudModel.gameSprite.map.player_)));
        }

        private function getSavedCharacter(_arg1:int):SavedCharacter{
            return (this.player.getCharacterById(_arg1));
        }

        private function getCharacterExp(_arg1:int):int{
            if (this.hasMapPlayer()){
                return (this.hudModel.gameSprite.map.player_.exp_);
            };
            return (this.getSavedCharacter(_arg1).xp());
        }

        private function getCharacterLevel(_arg1:int):int{
            if (this.hasMapPlayer()){
                return (this.hudModel.gameSprite.map.player_.level_);
            };
            return (this.getSavedCharacter(_arg1).level());
        }

        private function getCharacterType(_arg1:int):int{
            if (this.hasMapPlayer()){
                return (this.hudModel.gameSprite.map.player_.objectType_);
            };
            return (this.getSavedCharacter(_arg1).objectType());
        }

        private function getCharacterFameBonus(_arg1:int):int{
            if (this.hasMapPlayer()){
                return (this.hudModel.gameSprite.map.player_.getFameBonus());
            };
            return (this.getSavedCharacter(_arg1).fameBonus());
        }

        public function currentFame(_arg1:int):int{
            var _local2:int = this.metrics.getCharacterStat(_arg1, MetricsID.MINUTES_ACTIVE);
            var _local3:int = this.getCharacterExp(_arg1);
            var _local4:int = this.getCharacterLevel(_arg1);
            if (this.hasMapPlayer()){
                _local3 = (_local3 + (((_local4 - 1) * (_local4 - 1)) * 50));
            };
            return (this.calculateBaseFame(_local3, _local2));
        }

        public function calculateBaseFame(_arg1:int, _arg2:int):int{
            var _local3:Number = 0;
            _local3 = (_local3 + (Math.max(0, Math.min(20000, _arg1)) * 0.001));
            _local3 = (_local3 + (Math.max(0, (Math.min(45200, _arg1) - 20000)) * 0.002));
            _local3 = (_local3 + (Math.max(0, (Math.min(80000, _arg1) - 45200)) * 0.003));
            _local3 = (_local3 + (Math.max(0, (Math.min(101200, _arg1) - 80000)) * 0.002));
            _local3 = (_local3 + (Math.max(0, (_arg1 - 101200)) * 0.0005));
            _local3 = (_local3 + Math.min(Math.floor((_arg2 / 6)), 30));
            return (Math.floor(_local3));
        }


    }
}//package io.decagames.rotmg.fame.data

