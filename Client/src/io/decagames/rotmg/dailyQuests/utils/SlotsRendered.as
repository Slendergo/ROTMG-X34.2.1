// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.dailyQuests.utils.SlotsRendered

package io.decagames.rotmg.dailyQuests.utils{
    import flash.display.Sprite;
    import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;
    import io.decagames.rotmg.dailyQuests.data.DailyQuestItemSlotType;

    public class SlotsRendered {


        public static function renderSlots(_arg1:Vector.<int>, _arg2:Vector.<int>, _arg3:String, _arg4:Sprite, _arg5:int, _arg6:int, _arg7:int, _arg8:Vector.<DailyQuestItemSlot>, _arg9:Boolean=false):void{
            var _local11:int;
            var _local18:Sprite;
            var _local19:int;
            var _local20:int;
            var _local21:int;
            var _local22:int;
            var _local23:DailyQuestItemSlot;
            var _local10:int;
            _local11 = 4;
            var _local12:int;
            var _local13:int;
            var _local14:int;
            var _local15:Boolean;
            var _local16:Sprite = new Sprite();
            var _local17:Sprite = new Sprite();
            _local18 = _local16;
            _arg4.addChild(_local16);
            _arg4.addChild(_local17);
            _local17.y = (DailyQuestItemSlot.SLOT_SIZE + _arg6);
            for each (_local19 in _arg1) {
                if (!_local15){
                    _local13++;
                }
                else {
                    _local14++;
                };
                _local22 = _arg2.indexOf(_local19);
                if (_local22 >= 0){
                    _arg2.splice(_local22, 1);
                };
                _local23 = new DailyQuestItemSlot(_local19, _arg3, (((_arg3 == DailyQuestItemSlotType.REWARD)) ? false : (_local22 >= 0)), _arg9);
                _local23.x = (_local10 * (DailyQuestItemSlot.SLOT_SIZE + _arg6));
                _local18.addChild(_local23);
                _arg8.push(_local23);
                _local10++;
                if (_local10 >= _local11){
                    _local18 = _local17;
                    _local10 = 0;
                    _local15 = true;
                };
            };
            _local20 = ((_local13 * DailyQuestItemSlot.SLOT_SIZE) + ((_local13 - 1) * _arg6));
            _local21 = ((_local14 * DailyQuestItemSlot.SLOT_SIZE) + ((_local14 - 1) * _arg6));
            _arg4.y = _arg5;
            if (!_local15){
                _arg4.y = (_arg4.y + Math.round(((DailyQuestItemSlot.SLOT_SIZE / 2) + (_arg6 / 2))));
            };
            _local16.x = Math.round(((_arg7 - _local20) / 2));
            _local17.x = Math.round(((_arg7 - _local21) / 2));
        }


    }
}//package io.decagames.rotmg.dailyQuests.utils

