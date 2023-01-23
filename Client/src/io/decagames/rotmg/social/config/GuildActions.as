// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.social.config.GuildActions

package io.decagames.rotmg.social.config{
    public class GuildActions {

        public static const BASE_DIRECTORY:String = "/guild";
        public static const GUILD_LIST:String = "/listMembers";


        public static function getURL(_arg1:String):String{
            return ((BASE_DIRECTORY + _arg1));
        }


    }
}//package io.decagames.rotmg.social.config

