﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.account.web.WebAccount

package kabam.rotmg.account.web{
    import flash.external.ExternalInterface;
    import com.company.assembleegameclient.util.GUID;
    import flash.net.SharedObject;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.account.core.*;

    public class WebAccount implements Account {

        public static const NETWORK_NAME:String = "rotmg";
        private static const WEB_USER_ID:String = "";
        private static const WEB_PLAY_PLATFORM_NAME:String = "rotmg";

        private var userId:String = "";
        private var password:String;
        private var token:String = "";
        private var entryTag:String = "";
        private var isVerifiedEmail:Boolean;
        private var platformToken:String;
        private var _userDisplayName:String = "";
        private var _rememberMe:Boolean = true;
        private var _paymentProvider:String = "";
        private var _paymentData:String = "";
        private var _creationDate:Date;
        public var signedRequest:String;
        public var kabamId:String;

        public function WebAccount(){
            try {
                this.entryTag = ExternalInterface.call("rotmg.UrlLib.getParam", "entrypt");
            }
            catch(error:Error) {
            };
        }

        public function getUserName():String{
            return (this.userId);
        }

        public function getUserId():String{
            return ((this.userId = ((this.userId) || (GUID.create()))));
        }

        public function getPassword():String{
            return (((this.password) || ("")));
        }

        public function getToken():String{
            return ("");
        }

        public function getCredentials():Object{
            return ({
                guid:this.getUserId(),
                password:this.getPassword()
            });
        }

        public function isRegistered():Boolean{
            return (((!((this.getPassword() == ""))) || (!((this.getToken() == "")))));
        }

        public function updateUser(_arg1:String, _arg2:String, _arg3:String):void{
            var _local4:SharedObject;
            this.userId = _arg1;
            this.password = _arg2;
            this.token = _arg3;
            try {
                if (this._rememberMe){
                    _local4 = SharedObject.getLocal("RotMG", "/");
                    _local4.data["GUID"] = _arg1;
                    _local4.data["Token"] = _arg3;
                    _local4.data["Password"] = _arg2;
                    _local4.flush();
                };
            }
            catch(error:Error) {
            };
        }

        public function clear():void{
            this._rememberMe = true;
            this.updateUser(GUID.create(), null, null);
            Parameters.sendLogin_ = true;
            Parameters.data_.charIdUseMap = {};
            Parameters.save();
        }

        public function reportIntStat(_arg1:String, _arg2:int):void{
        }

        public function getRequestPrefix():String{
            return ("/credits");
        }

        public function gameNetworkUserId():String{
            return (WEB_USER_ID);
        }

        public function gameNetwork():String{
            return (NETWORK_NAME);
        }

        public function playPlatform():String{
            return (WEB_PLAY_PLATFORM_NAME);
        }

        public function getEntryTag():String{
            return (((this.entryTag) || ("")));
        }

        public function getSecret():String{
            return ("");
        }

        public function verify(_arg1:Boolean):void{
            this.isVerifiedEmail = _arg1;
        }

        public function isVerified():Boolean{
            return (this.isVerifiedEmail);
        }

        public function getPlatformToken():String{
            return (((this.platformToken) || ("")));
        }

        public function setPlatformToken(_arg1:String):void{
            this.platformToken = _arg1;
        }

        public function getMoneyAccessToken():String{
            return (this.signedRequest);
        }

        public function getMoneyUserId():String{
            return (this.kabamId);
        }

        public function get userDisplayName():String{
            return (this._userDisplayName);
        }

        public function set userDisplayName(_arg1:String):void{
            this._userDisplayName = _arg1;
        }

        public function set rememberMe(_arg1:Boolean):void{
            this._rememberMe = _arg1;
        }

        public function get rememberMe():Boolean{
            return (this._rememberMe);
        }

        public function set paymentProvider(_arg1:String):void{
            this._paymentProvider = _arg1;
        }

        public function get paymentProvider():String{
            return (this._paymentProvider);
        }

        public function set paymentData(_arg1:String):void{
            this._paymentData = _arg1;
        }

        public function get paymentData():String{
            return (this._paymentData);
        }

        public function get creationDate():Date{
            return (this._creationDate);
        }

        public function set creationDate(_arg1:Date):void{
            this._creationDate = _arg1;
        }


    }
}//package kabam.rotmg.account.web

