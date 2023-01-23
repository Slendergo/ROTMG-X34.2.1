// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalItemDataFactory

package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard{
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.assets.services.CharacterFactory;
    import kabam.rotmg.classes.model.CharacterClass;
    import kabam.rotmg.classes.model.CharacterSkin;
    import com.company.util.ConversionUtil;

    public class SeasonalItemDataFactory {

        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var classesModel:ClassesModel;
        [Inject]
        public var factory:CharacterFactory;
        private var seasonalLeaderBoardItemDatas:Vector.<SeasonalLeaderBoardItemData>;


        public function createSeasonalLeaderBoardItemDatas(_arg1:XML):Vector.<SeasonalLeaderBoardItemData>{
            this.seasonalLeaderBoardItemDatas = new <SeasonalLeaderBoardItemData>[];
            this.createItemsFromList(_arg1.FameListElem);
            return (this.seasonalLeaderBoardItemDatas);
        }

        private function createItemsFromList(_arg1:XMLList):void{
            var _local2:XML;
            var _local3:SeasonalLeaderBoardItemData;
            for each (_local2 in _arg1) {
                if (!this.seasonalLeaderBoardItemDatasContains(_local2)){
                    _local3 = this.createSeasonalLeaderBoardItemData(_local2);
                    _local3.isOwn = (_local2.Name == this.playerModel.getName());
                    this.seasonalLeaderBoardItemDatas.push(_local3);
                };
            };
        }

        private function seasonalLeaderBoardItemDatasContains(_arg1:XML):Boolean{
            var _local2:SeasonalLeaderBoardItemData;
            for each (_local2 in this.seasonalLeaderBoardItemDatas) {
                if ((((_local2.accountId == _arg1.@accountId)) && ((_local2.charId == _arg1.@charId)))){
                    return (true);
                };
            };
            return (false);
        }

        public function createSeasonalLeaderBoardItemData(_arg1:XML):SeasonalLeaderBoardItemData{
            var _local2:int = _arg1.ObjectType;
            var _local3:int = _arg1.Texture;
            var _local4:CharacterClass = this.classesModel.getCharacterClass(_local2);
            var _local5:CharacterSkin = _local4.skins.getSkin(_local3);
            var _local6:int = ((_arg1.hasOwnProperty("Tex1")) ? _arg1.Tex1 : 0);
            var _local7:int = ((_arg1.hasOwnProperty("Tex2")) ? _arg1.Tex2 : 0);
            var _local8:int = ((_local5.is16x16) ? 50 : 100);
            var _local9:SeasonalLeaderBoardItemData = new SeasonalLeaderBoardItemData();
            _local9.rank = _arg1.Rank;
            _local9.accountId = _arg1.@accountId;
            _local9.charId = _arg1.@charId;
            _local9.name = _arg1.Name;
            _local9.totalFame = _arg1.TotalFame;
            _local9.character = this.factory.makeIcon(_local5.template, _local8, _local6, _local7, (_local9.rank <= 10));
            _local9.equipmentSlots = _local4.slotTypes;
            _local9.equipment = ConversionUtil.toIntVector(_arg1.Equipment);
            return (_local9);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard

