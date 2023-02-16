// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.incoming.RealmHeroesResponse

package kabam.rotmg.messaging.impl.incoming{
import flash.net.Socket;
import flash.utils.ByteArray;

    public class RealmHeroesResponse extends IncomingMessage {

        public var numberOfRealmHeroes:int;

        public function RealmHeroesResponse(_arg1:uint, _arg2:Function){
            super(_arg1, _arg2);
        }

        override public function parseFromInput(_arg1:Socket):void{
            this.numberOfRealmHeroes = _arg1.readInt();
        }

        override public function toString():String{
            return (formatToString("REALMHEROESRESPONSE", "numberOfRealmHeroes"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

