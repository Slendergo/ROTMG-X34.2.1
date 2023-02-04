// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.data.CompressedInt

package kabam.rotmg.messaging.impl.data{
    import flash.utils.IDataInput;

    public class CompressedInt {

        public static function Read(_arg1:IDataInput):int{
            var _local2:int;
            var _local3:int = _arg1.readUnsignedByte();
            var _local4 = !(((_local3 & 64) == 0));
            var _local5:int = 6;
            _local2 = (_local3 & 63);
            while ((_local3 & 128)) {
                _local3 = _arg1.readUnsignedByte();
                _local2 = (_local2 | ((_local3 & 127) << _local5));
                _local5 = (_local5 + 7);
            }
            if (_local4){
                _local2 = -(_local2);
            }
            return (_local2);
        }


    }
}//package kabam.rotmg.messaging.impl.data

