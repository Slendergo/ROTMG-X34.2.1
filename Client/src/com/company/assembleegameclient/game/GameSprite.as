// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.game.GameSprite

package com.company.assembleegameclient.game{
    import com.company.assembleegameclient.map.Map;
    import flash.filters.ColorMatrixFilter;
    import com.company.util.MoreColorUtil;
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.objects.Player;
    import kabam.rotmg.chat.view.Chat;
    import com.company.assembleegameclient.ui.RankText;
    import com.company.assembleegameclient.ui.GuildText;
    import kabam.rotmg.game.view.ShopDisplay;
    import kabam.rotmg.game.view.CreditDisplay;
    import kabam.rotmg.game.view.RealmQuestsDisplay;
    import kabam.rotmg.game.view.GiftStatusDisplay;
    import kabam.rotmg.game.view.NewsModalButton;
    import kabam.rotmg.news.view.NewsTicker;
    import kabam.rotmg.arena.view.ArenaTimer;
    import kabam.rotmg.arena.view.ArenaWaveCounter;
    import kabam.rotmg.core.model.MapModel;
    import kabam.rotmg.promotions.model.BeginnersPackageModel;
    import kabam.rotmg.dialogs.model.DialogsModel;
    import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;
    import kabam.rotmg.dailyLogin.signal.ShowDailyCalendarPopupSignal;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import kabam.rotmg.packages.services.PackageModel;
    import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
    import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
    import kabam.rotmg.ui.signals.ShowHideKeyUISignal;
    import com.company.assembleegameclient.ui.menu.PlayerMenu;
    import com.company.assembleegameclient.objects.GameObject;
    import flash.display.DisplayObject;
    import kabam.rotmg.promotions.view.SpecialOfferButton;
    import kabam.rotmg.game.model.QuestModel;
    import flash.display.Sprite;
    import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
    import flash.events.MouseEvent;
    import kabam.rotmg.servers.api.Server;
    import flash.utils.ByteArray;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.maploading.signals.MapLoadedSignal;
    import kabam.rotmg.messaging.impl.incoming.MapInfo;
    import kabam.rotmg.maploading.signals.HideMapLoadingSignal;
    import kabam.rotmg.ui.view.HUDView;
    import kabam.rotmg.protip.signals.ShowProTipSignal;
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.dialogs.model.PopupNamesConfig;
    import kabam.rotmg.appengine.api.AppEngineClient;
    import com.company.util.MoreObjectUtil;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.ui.UIUtils;
    import kabam.rotmg.news.model.NewsModel;
    import robotlegs.bender.framework.api.ILogger;
    import flash.external.ExternalInterface;
    import com.company.assembleegameclient.tutorial.Tutorial;
    import com.company.assembleegameclient.objects.IInteractiveObject;
    import kabam.rotmg.constants.GeneralConstants;
    import com.company.assembleegameclient.objects.Pet;
    import com.company.util.PointUtil;
    import kabam.rotmg.stage3D.Renderer;
    import flash.utils.getTimer;
    import com.company.assembleegameclient.game.events.MoneyChangedEvent;
    import flash.events.Event;
    import kabam.lib.loopedprocs.LoopedProcess;
    import kabam.lib.loopedprocs.LoopedCallback;
    import com.company.util.CachingColorTransformer;
    import com.company.assembleegameclient.util.TextureRedrawer;
    import com.company.assembleegameclient.objects.Projectile;

    public class GameSprite extends AGameSprite {

        public static const NON_COMBAT_MAPS:Vector.<String> = new <String>[Map.NEXUS, Map.VAULT, Map.GUILD_HALL, Map.GUILD_HALL_2, Map.GUILD_HALL_3, Map.GUILD_HALL_4, Map.GUILD_HALL_5, Map.CLOTH_BAZAAR, Map.NEXUS_EXPLANATION, Map.DAILY_QUEST_ROOM, Map.DAILY_LOGIN_ROOM, Map.PET_YARD_1, Map.PET_YARD_2, Map.PET_YARD_3, Map.PET_YARD_4, Map.PET_YARD_5];
        public static const DISPLAY_AREA_Y_SPACE:int = 32;
        protected static const PAUSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);

        public const monitor:Signal = new Signal(String, int);
        public const modelInitialized:Signal = new Signal();
        public const drawCharacterWindow:Signal = new Signal(Player);

        public var chatBox_:Chat;
        public var isNexus_:Boolean = false;
        public var idleWatcher_:IdleWatcher;
        public var rankText_:RankText;
        public var guildText_:GuildText;
        public var shopDisplay:ShopDisplay;
        public var creditDisplay_:CreditDisplay;
        public var realmQuestsDisplay:RealmQuestsDisplay;
        public var giftStatusDisplay:GiftStatusDisplay;
        public var newsModalButton:NewsModalButton;
        public var newsTicker:NewsTicker;
        public var arenaTimer:ArenaTimer;
        public var arenaWaveCounter:ArenaWaveCounter;
        public var mapModel:MapModel;
        public var beginnersPackageModel:BeginnersPackageModel;
        public var dialogsModel:DialogsModel;
        public var showBeginnersPackage:ShowBeginnersPackageSignal;
        public var openDailyCalendarPopupSignal:ShowDailyCalendarPopupSignal;
        public var openDialog:OpenDialogSignal;
        public var showPackage:Signal;
        public var packageModel:PackageModel;
        public var addToQueueSignal:AddPopupToStartupQueueSignal;
        public var flushQueueSignal:FlushPopupStartupQueueSignal;
        public var showHideKeyUISignal:ShowHideKeyUISignal;
        public var chatPlayerMenu:PlayerMenu;
        private var focus:GameObject;
        private var frameTimeSum_:int = 0;
        private var frameTimeCount_:int = 0;
        private var isGameStarted:Boolean;
        private var displaysPosY:uint = 4;
        private var currentPackage:DisplayObject;
        private var packageY:Number;
        private var specialOfferButton:SpecialOfferButton;
        private var questModel:QuestModel;
        private var mapName:String;

        public function GameSprite(_arg1:Server, _arg2:int, _arg3:Boolean, _arg4:int, _arg5:int, _arg6:ByteArray, _arg7:PlayerModel, _arg8:String, _arg9:Boolean){
            this.showPackage = new Signal();
            this.currentPackage = new Sprite();
            super();
            this.model = _arg7;
            map = new Map(this);
            addChild(map);
            gsc_ = new GameServerConnectionConcrete(this, _arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg8, _arg9);
            mui_ = new MapUserInput(this);
            this.chatBox_ = new Chat();
            this.chatBox_.list.addEventListener(MouseEvent.MOUSE_DOWN, this.onChatDown);
            this.chatBox_.list.addEventListener(MouseEvent.MOUSE_UP, this.onChatUp);
            addChild(this.chatBox_);
            this.idleWatcher_ = new IdleWatcher();
        }

        private static function hidePreloader():void{
            var _local1:HideMapLoadingSignal = StaticInjectorContext.getInjector().getInstance(HideMapLoadingSignal);
            ((_local1) && (_local1.dispatch()));
        }


        public function onChatDown(_arg1:MouseEvent):void{
            if (this.chatPlayerMenu != null){
                this.removeChatPlayerMenu();
            }
            mui_.onMouseDown(_arg1);
        }

        public function onChatUp(_arg1:MouseEvent):void{
            mui_.onMouseUp(_arg1);
        }

        override public function setFocus(_arg1:GameObject):void{
            _arg1 = ((_arg1) || (map.player_));
            this.focus = _arg1;
        }

        public function addChatPlayerMenu(_arg1:Player, _arg2:Number, _arg3:Number, _arg4:String=null, _arg5:Boolean=false, _arg6:Boolean=false):void{
            this.removeChatPlayerMenu();
            this.chatPlayerMenu = new PlayerMenu();
            if (_arg4 == null){
                this.chatPlayerMenu.init(this, _arg1);
            }
            else {
                if (_arg6){
                    this.chatPlayerMenu.initDifferentServer(this, _arg4, _arg5, _arg6);
                }
                else {
                    if ((((_arg4.length > 0)) && ((((((_arg4.charAt(0) == "#")) || ((_arg4.charAt(0) == "*")))) || ((_arg4.charAt(0) == "@")))))){
                        return;
                    }
                    this.chatPlayerMenu.initDifferentServer(this, _arg4, _arg5);
                }
            }
            addChild(this.chatPlayerMenu);
            this.chatPlayerMenu.x = _arg2;
            this.chatPlayerMenu.y = (_arg3 - this.chatPlayerMenu.height);
        }

        public function removeChatPlayerMenu():void{
            if (((!((this.chatPlayerMenu == null))) && (!((this.chatPlayerMenu.parent == null))))){
                removeChild(this.chatPlayerMenu);
                this.chatPlayerMenu = null;
            }
        }


        override public function applyMapInfo(width:int, height:int, name:String, displayName:String, realmName:String, background:int, difficulty:int, allowPlayerTeleport:Boolean, showDisplays:Boolean):void{
            map.setProps(width, height, name, background, allowPlayerTeleport, showDisplays);
            var _local2:MapLoadedSignal = StaticInjectorContext.getInjector().getInstance(MapLoadedSignal);
            ((_local2) && (_local2.dispatch(displayName, difficulty)));
        }

        public function hudModelInitialized():void{
            hudView = new HUDView();
            hudView.x = 600;
            addChild(hudView);
        }

        override public function initialize():void{
            var _local4:ShowProTipSignal;
            this.questModel = StaticInjectorContext.getInjector().getInstance(QuestModel);
            map.initialize();
            this.modelInitialized.dispatch();
            this.mapName = map.name_;
            if (this.evalIsNotInCombatMapArea()){
                this.showSafeAreaDisplays();
            }
            this.showHideKeyUISignal.dispatch((this.mapName == "Davy Jones' Locker"));
            if (this.mapName == "Arena"){
                this.showTimer();
                this.showWaveCounter();
            }
            var _local1:Account = StaticInjectorContext.getInjector().getInstance(Account);
            this.isNexus_ = (this.mapName == Map.NEXUS);
            if (this.isNexus_){
                this.addToQueueSignal.dispatch(PopupNamesConfig.DAILY_LOGIN_POPUP, this.openDailyCalendarPopupSignal, -1, null);
                if (this.beginnersPackageModel.status == BeginnersPackageModel.STATUS_CAN_BUY_SHOW_POP_UP){
                    this.addToQueueSignal.dispatch(PopupNamesConfig.BEGINNERS_OFFER_POPUP, this.showBeginnersPackage, 1, null);
                }
                else {
                    this.addToQueueSignal.dispatch(PopupNamesConfig.PACKAGES_OFFER_POPUP, this.showPackage, 1, null);
                }
                this.flushQueueSignal.dispatch();
            }
            if (((this.isNexus_) || ((this.mapName == Map.DAILY_QUEST_ROOM)))){
                this.creditDisplay_ = new CreditDisplay(this, true, true);
            }
            else {
                this.creditDisplay_ = new CreditDisplay(this);
            }
            this.creditDisplay_.x = 594;
            addChild(this.creditDisplay_);
            if (((!(this.evalIsNotInCombatMapArea())) && (this.canShowRealmQuestDisplay(this.mapName)))){
                this.realmQuestsDisplay = new RealmQuestsDisplay(map);
                this.realmQuestsDisplay.x = 10;
                this.realmQuestsDisplay.y = 10;
                addChild(this.realmQuestsDisplay);
                gsc_.playerText("/server");
            }
            else {
                this.questModel.previousRealm = "";
            }
            var _local2:AppEngineClient = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
            var _local3:Object = {};
            MoreObjectUtil.addToObject(_local3, _local1.getCredentials());
            if (((((((!((this.mapName == "Kitchen"))) && (!((this.mapName == "Tutorial"))))) && (!((this.mapName == "Nexus Explanation"))))) && ((Parameters.data_.watchForTutorialExit == true)))){
                Parameters.data_.watchForTutorialExit = false;
                _local3["fteStepCompleted"] = 9900;
                _local2.sendRequest("/log/logFteStep", _local3);
            }
            if (this.mapName == "Kitchen"){
                _local3["fteStepCompleted"] = 200;
                _local2.sendRequest("/log/logFteStep", _local3);
            }
            if (this.mapName == "Tutorial"){
                if (Parameters.data_.needsTutorial == true){
                    Parameters.data_.watchForTutorialExit = true;
                    _local3["fteStepCompleted"] = 100;
                    _local2.sendRequest("/log/logFteStep", _local3);
                }
                this.startTutorial();
            }
            else {
                if (((((((((((((!((this.mapName == "Arena"))) && (!((this.mapName == "Kitchen"))))) && (!((this.mapName == "Nexus Explanation"))))) && (!((this.mapName == "Vault Explanation"))))) && (!((this.mapName == "Guild Explanation"))))) && (!(this.evalIsNotInCombatMapArea())))) && (Parameters.data_.showProtips))){
                    _local4 = StaticInjectorContext.getInjector().getInstance(ShowProTipSignal);
                    ((_local4) && (_local4.dispatch()));
                }
            }
            if (this.mapName == Map.DAILY_QUEST_ROOM){
                gsc_.questFetch();
            }
            map.setHitAreaProps(map.width, map.height);
            Parameters.save();
            hidePreloader();
        }

        private function canShowRealmQuestDisplay(_arg1:String):Boolean{
            var _local2:Boolean;
            if (_arg1 == Map.REALM){
                this.questModel.previousRealm = _arg1;
                this.questModel.requirementsStates[QuestModel.REMAINING_HEROES_REQUIREMENT] = false;
                this.questModel.remainingHeroes = -1;
                if (this.questModel.hasOryxBeenKilled){
                    this.questModel.hasOryxBeenKilled = false;
                    this.questModel.resetRequirementsStates();
                }
                _local2 = true;
            }
            else {
                if ((((this.questModel.previousRealm == Map.REALM)) && (!((_arg1.indexOf("Oryx") == -1))))){
                    this.questModel.requirementsStates[QuestModel.REMAINING_HEROES_REQUIREMENT] = true;
                    this.questModel.remainingHeroes = 0;
                    _local2 = true;
                }
            }
            return (_local2);
        }

        private function showSafeAreaDisplays():void{
            this.showRankText();
            this.showGuildText();
            this.showShopDisplay();
            this.showGiftStatusDisplay();
            this.showNewsUpdate();
            this.showNewsTicker();
        }

        private function setDisplayPosY(_arg1:Number):void{
            var _local2:Number = (UIUtils.NOTIFICATION_SPACE * _arg1);
            if (_arg1 != 0){
                this.displaysPosY = (4 + _local2);
            }
            else {
                this.displaysPosY = 2;
            }
        }

        public function positionDynamicDisplays():void{
            var _local1:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
            var _local2:int = 72;
            if (((this.giftStatusDisplay) && (this.giftStatusDisplay.isOpen))){
                this.giftStatusDisplay.y = _local2;
                _local2 = (_local2 + DISPLAY_AREA_Y_SPACE);
            }
            if (((this.newsModalButton) && (((NewsModalButton.showsHasUpdate) || (_local1.hasValidModalNews()))))){
                this.newsModalButton.y = _local2;
                _local2 = (_local2 + DISPLAY_AREA_Y_SPACE);
            }
            if (((this.specialOfferButton) && (this.specialOfferButton.isSpecialOfferAvailable))){
                this.specialOfferButton.y = _local2;
            }
            if (((this.newsTicker) && (this.newsTicker.visible))){
                this.newsTicker.y = _local2;
            }
        }

        private function showTimer():void{
            this.arenaTimer = new ArenaTimer();
            this.arenaTimer.y = 5;
            addChild(this.arenaTimer);
        }

        private function showWaveCounter():void{
            this.arenaWaveCounter = new ArenaWaveCounter();
            this.arenaWaveCounter.y = 5;
            this.arenaWaveCounter.x = 5;
            addChild(this.arenaWaveCounter);
        }

        private function showNewsTicker():void{
            this.newsTicker = new NewsTicker();
            this.newsTicker.x = (300 - (this.newsTicker.width / 2));
            addChild(this.newsTicker);
            this.positionDynamicDisplays();
        }

        private function showGiftStatusDisplay():void{
            this.giftStatusDisplay = new GiftStatusDisplay();
            this.giftStatusDisplay.x = 6;
            addChild(this.giftStatusDisplay);
            this.positionDynamicDisplays();
        }

        private function showShopDisplay():void{
            this.shopDisplay = new ShopDisplay((map.name_ == Map.NEXUS));
            this.shopDisplay.x = 6;
            this.shopDisplay.y = 40;
            addChild(this.shopDisplay);
        }

        private function showNewsUpdate(_arg1:Boolean=true):void{
            var _local4:NewsModalButton;
            var _local2:ILogger = StaticInjectorContext.getInjector().getInstance(ILogger);
            var _local3:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
            _local2.debug("NEWS UPDATE -- making button");
            if (_local3.hasValidModalNews()){
                _local2.debug("NEWS UPDATE -- making button - ok");
                _local4 = new NewsModalButton();
                if (this.newsModalButton != null){
                    removeChild(this.newsModalButton);
                }
                _local4.x = 6;
                this.newsModalButton = _local4;
                addChild(this.newsModalButton);
                this.positionDynamicDisplays();
            }
        }

        public function refreshNewsUpdateButton():void{
            var _local1:ILogger = StaticInjectorContext.getInjector().getInstance(ILogger);
            _local1.debug("NEWS UPDATE -- refreshing button, update noticed");
            this.showNewsUpdate(false);
        }

        private function setYAndPositionPackage():void{
            this.packageY = (this.displaysPosY + 2);
            this.displaysPosY = (this.displaysPosY + UIUtils.NOTIFICATION_SPACE);
            this.positionPackage();
        }

        public function showSpecialOfferIfSafe(_arg1:Boolean):void{
            if (this.evalIsNotInCombatMapArea()){
                this.specialOfferButton = new SpecialOfferButton(_arg1);
                this.specialOfferButton.x = 6;
                addChild(this.specialOfferButton);
                this.positionDynamicDisplays();
            }
        }

        public function showPackageButtonIfSafe():void{
            if (this.evalIsNotInCombatMapArea()){
            }
        }

        private function addAndPositionPackage(_arg1:DisplayObject):void{
            this.currentPackage = _arg1;
            addChild(this.currentPackage);
            this.positionPackage();
        }

        private function positionPackage():void{
            this.currentPackage.x = 80;
            this.setDisplayPosY(1);
            this.currentPackage.y = this.displaysPosY;
        }

        private function showGuildText():void{
            this.guildText_ = new GuildText("", -1);
            this.guildText_.x = 86;
            this.guildText_.y = 2;
            addChild(this.guildText_);
        }

        private function showRankText():void{
            this.rankText_ = new RankText(-1, true, false);
            this.rankText_.x = 8;
            this.rankText_.y = 2;
            addChild(this.rankText_);
        }

        private function startTutorial():void{
            tutorial_ = new Tutorial(this);
            addChild(tutorial_);
        }

        private function updateNearestInteractive():void{
            var _local4:Number;
            var _local7:GameObject;
            var _local8:IInteractiveObject;
            if (((!(map)) || (!(map.player_)))){
                return;
            }
            var _local1:Player = map.player_;
            var _local2:Number = GeneralConstants.MAXIMUM_INTERACTION_DISTANCE;
            var _local3:IInteractiveObject;
            var _local5:Number = _local1.x_;
            var _local6:Number = _local1.y_;
            for each (_local7 in map.goDict_) {
                _local8 = (_local7 as IInteractiveObject);
                if (((_local8) && (((!((_local8 is Pet))) || (this.map.isPetYard))))){
                    if ((((Math.abs((_local5 - _local7.x_)) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE)) || ((Math.abs((_local6 - _local7.y_)) < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE)))){
                        _local4 = PointUtil.distanceXY(_local7.x_, _local7.y_, _local5, _local6);
                        if ((((_local4 < GeneralConstants.MAXIMUM_INTERACTION_DISTANCE)) && ((_local4 < _local2)))){
                            _local2 = _local4;
                            _local3 = _local8;
                        }
                    }
                }
            }
            this.mapModel.currentInteractiveTarget = _local3;
        }

        public function connect():void{
            if (!this.isGameStarted){
                this.isGameStarted = true;
                Renderer.inGame = true;
                gsc_.connect();
                this.idleWatcher_.start(this);
                lastUpdate_ = getTimer();
                stage.addEventListener(MoneyChangedEvent.MONEY_CHANGED, this.onMoneyChanged);
                stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                LoopedProcess.addProcess(new LoopedCallback(100, this.updateNearestInteractive));
            }
        }

        public function disconnect():void{
            if (this.isGameStarted){
                this.isGameStarted = false;
                Renderer.inGame = false;
                this.idleWatcher_.stop();
                stage.removeEventListener(MoneyChangedEvent.MONEY_CHANGED, this.onMoneyChanged);
                stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                LoopedProcess.destroyAll();
                ((contains(map)) && (removeChild(map)));
                map.dispose();
                CachingColorTransformer.clear();
                TextureRedrawer.clearCache();
                Projectile.dispose();
                gsc_.disconnect();
            }
        }

        private function onMoneyChanged(_arg1:Event):void{
            gsc_.checkCredits();
        }

        override public function evalIsNotInCombatMapArea():Boolean{
            return (!((NON_COMBAT_MAPS.indexOf(map.name_) == -1)));
        }

        private function onEnterFrame(_arg1:Event):void{
            var _local7:Number;
            var _local2:int = getTimer();
            var _local3:int = (_local2 - lastUpdate_);
            if (this.idleWatcher_.update(_local3)){
                closed.dispatch();
                return;
            }
            LoopedProcess.runProcesses(_local2);
            this.frameTimeSum_ = (this.frameTimeSum_ + _local3);
            this.frameTimeCount_ = (this.frameTimeCount_ + 1);
            if (this.frameTimeSum_ > 300000){
                _local7 = int(Math.round(((1000 * this.frameTimeCount_) / this.frameTimeSum_)));
                this.frameTimeCount_ = 0;
                this.frameTimeSum_ = 0;
            }
            var _local4:int = getTimer();
            map.update(_local2, _local3);
            this.monitor.dispatch("Map.update", (getTimer() - _local4));
            camera_.update(_local3);
            var _local5:Player = map.player_;
            if (this.focus){
                camera_.configureCamera(this.focus, ((_local5) ? _local5.isHallucinating() : false));
                map.draw(camera_, _local2);
            }
            if (_local5 != null){
                _local5.isNotInCombatMapArea = this.evalIsNotInCombatMapArea();
                this.creditDisplay_.draw(_local5.credits_, _local5.fame_, _local5.tokens_);
                this.drawCharacterWindow.dispatch(_local5);
                if (this.evalIsNotInCombatMapArea()){
                    this.rankText_.draw(_local5.numStars_);
                    this.guildText_.draw(_local5.guildName_, _local5.guildRank_);
                }
                if (_local5.isPaused()){
                    map.filters = [PAUSED_FILTER];
                    hudView.filters = [PAUSED_FILTER];
                    map.mouseEnabled = false;
                    map.mouseChildren = false;
                    hudView.mouseEnabled = false;
                    hudView.mouseChildren = false;
                }
                else {
                    if (map.filters.length > 0){
                        map.filters = [];
                        hudView.filters = [];
                        map.mouseEnabled = true;
                        map.mouseChildren = true;
                        hudView.mouseEnabled = true;
                        hudView.mouseChildren = true;
                    }
                }
                moveRecords_.addRecord(_local2, _local5.x_, _local5.y_);
            }
            lastUpdate_ = _local2;
            var _local6:int = (getTimer() - _local2);
            this.monitor.dispatch("GameSprite.loop", _local6);
        }

        public function showPetToolTip(_arg1:Boolean):void{
        }


    }
}//package com.company.assembleegameclient.game

