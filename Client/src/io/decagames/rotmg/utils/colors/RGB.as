// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.utils.colors.RGB

package io.decagames.rotmg.utils.colors{
    public class RGB {


        public static function fromRGB(_arg1:int, _arg2:int, _arg3:int):uint{
            return ((((_arg1 << 16) | (_arg2 << 8)) | _arg3));
        }

        public static function toRGB(_arg1:uint):Array{
            return ([getRed(_arg1), getGreen(_arg1), getBlue(_arg1)]);
        }

        public static function getRed(_arg1:int):int{
            return (((_arg1 >> 16) & 0xFF));
        }

        public static function getGreen(_arg1:int):int{
            return (((_arg1 >> 8) & 0xFF));
        }

        public static function getBlue(_arg1:int):int{
            return ((_arg1 & 0xFF));
        }


    }
}//package io.decagames.rotmg.utils.colors

