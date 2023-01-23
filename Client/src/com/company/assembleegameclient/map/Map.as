﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.map.Map

package com.company.assembleegameclient.map{
    import flash.filters.ColorMatrixFilter;
    import flash.geom.ColorTransform;
    import flash.display.BitmapData;
    import kabam.rotmg.game.logging.RollingMeanLoopMonitor;
    import com.company.assembleegameclient.objects.BasicObject;
    import flash.utils.Dictionary;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.IGraphicsData;
    import kabam.rotmg.stage3D.Object3D.Object3DStage3D;
    import kabam.rotmg.assets.EmbeddedAssets;
    import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
    import com.company.assembleegameclient.map.partyoverlay.PartyOverlay;
    import com.company.assembleegameclient.objects.Party;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.game.model.GameModel;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.game.AGameSprite;
    import com.company.assembleegameclient.background.Background;
    import com.company.assembleegameclient.objects.GameObject;
    import kabam.rotmg.stage3D.graphic3D.TextureFactory;
    import kabam.rotmg.stage3D.GraphicsFillExtra;
    import kabam.rotmg.stage3D.graphic3D.Program3DFactory;
    import flash.geom.Point;
    import com.company.assembleegameclient.objects.particles.ParticleEffect;
    import com.company.assembleegameclient.objects.Character;
    import kabam.rotmg.game.model.QuestModel;
    import kabam.rotmg.ui.signals.RealmOryxSignal;
    import kabam.rotmg.stage3D.Render3D;
    import flash.geom.Rectangle;
    import kabam.rotmg.stage3D.Renderer;
    import flash.display.GraphicsBitmapFill;
    import flash.display.GraphicsSolidFill;
    import com.company.assembleegameclient.util.ConditionEffect;
    import flash.filters.BlurFilter;

    public class Map extends AbstractMap {

        public static const CLOTH_BAZAAR:String = "Cloth Bazaar";
        public static const NEXUS:String = "Nexus";
        public static const DAILY_QUEST_ROOM:String = "Daily Quest Room";
        public static const DAILY_LOGIN_ROOM:String = "Daily Login Room";
        public static const PET_YARD_1:String = "Pet Yard";
        public static const PET_YARD_2:String = "Pet Yard 2";
        public static const PET_YARD_3:String = "Pet Yard 3";
        public static const PET_YARD_4:String = "Pet Yard 4";
        public static const PET_YARD_5:String = "Pet Yard 5";
        public static const REALM:String = "Realm of the Mad God";
        public static const ORYX_CHAMBER:String = "Oryx's Chamber";
        public static const GUILD_HALL:String = "Guild Hall";
        public static const GUILD_HALL_2:String = "Guild Hall 2";
        public static const GUILD_HALL_3:String = "Guild Hall 3";
        public static const GUILD_HALL_4:String = "Guild Hall 4";
        public static const GUILD_HALL_5:String = "Guild Hall 5";
        public static const NEXUS_EXPLANATION:String = "Nexus_Explanation";
        public static const VAULT:String = "Vault";
        private static const VISIBLE_SORT_FIELDS:Array = ["sortVal_", "objectId_"];
        private static const VISIBLE_SORT_PARAMS:Array = [Array.NUMERIC, Array.NUMERIC];
        protected static const BLIND_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.05, 0.05, 0.05, 0, 0, 0.05, 0.05, 0.05, 0, 0, 0.05, 0.05, 0.05, 0, 0, 0.05, 0.05, 0.05, 1, 0]);

        public static var forceSoftwareRender:Boolean = false;
        protected static var BREATH_CT:ColorTransform = new ColorTransform((0xFF / 0xFF), (55 / 0xFF), (0 / 0xFF), 0);
        public static var texture:BitmapData;

        public var ifDrawEffectFlag:Boolean = true;
        private var loopMonitor:RollingMeanLoopMonitor;
        private var inUpdate_:Boolean = false;
        private var objsToAdd_:Vector.<BasicObject>;
        private var idsToRemove_:Vector.<int>;
        private var forceSoftwareMap:Dictionary;
        private var lastSoftwareClear:Boolean = false;
        private var darkness:DisplayObject;
        private var bgCont:Sprite;
        private var oryxObjectId:int;
        private var graphicsData_:Vector.<IGraphicsData>;
        private var graphicsDataStageSoftware_:Vector.<IGraphicsData>;
        private var graphicsData3d_:Vector.<Object3DStage3D>;
        public var visible_:Array;
        public var visibleUnder_:Array;
        public var visibleSquares_:Vector.<Square>;
        public var topSquares_:Vector.<Square>;

        public function Map(_arg1:AGameSprite){
            this.objsToAdd_ = new Vector.<BasicObject>();
            this.idsToRemove_ = new Vector.<int>();
            this.forceSoftwareMap = new Dictionary();
            this.darkness = new EmbeddedAssets.DarknessBackground();
            this.bgCont = new Sprite();
            this.graphicsData_ = new Vector.<IGraphicsData>();
            this.graphicsDataStageSoftware_ = new Vector.<IGraphicsData>();
            this.graphicsData3d_ = new Vector.<Object3DStage3D>();
            this.visible_ = [];
            this.visibleUnder_ = [];
            this.visibleSquares_ = new Vector.<Square>();
            this.topSquares_ = new Vector.<Square>();
            super();
            gs_ = _arg1;
            mapHitArea = new Sprite();
            hurtOverlay_ = new HurtOverlay();
            gradientOverlay_ = new GradientOverlay();
            mapOverlay_ = new MapOverlay();
            partyOverlay_ = new PartyOverlay(this);
            party_ = new Party(this);
            quest_ = new Quest(this);
            this.loopMonitor = StaticInjectorContext.getInjector().getInstance(RollingMeanLoopMonitor);
            StaticInjectorContext.getInjector().getInstance(GameModel).gameObjects = goDict_;
            this.forceSoftwareMap[PET_YARD_1] = true;
            this.forceSoftwareMap[PET_YARD_2] = true;
            this.forceSoftwareMap[PET_YARD_3] = true;
            this.forceSoftwareMap[PET_YARD_4] = true;
            this.forceSoftwareMap[PET_YARD_5] = true;
            this.forceSoftwareMap["Nexus"] = true;
            this.forceSoftwareMap["Tomb of the Ancients"] = true;
            this.forceSoftwareMap["Tomb of the Ancients (Heroic)"] = true;
            this.forceSoftwareMap["Mad Lab"] = true;
            this.forceSoftwareMap["Guild Hall"] = true;
            this.forceSoftwareMap["Guild Hall 2"] = true;
            this.forceSoftwareMap["Guild Hall 3"] = true;
            this.forceSoftwareMap["Guild Hall 4"] = true;
            this.forceSoftwareMap["Cloth Bazaar"] = true;
            this.forceSoftwareMap["Santa Workshop"] = true;
            wasLastFrameGpu = Parameters.isGpuRender();
        }

        override public function setProps(_arg1:int, _arg2:int, _arg3:String, _arg4:int, _arg5:Boolean, _arg6:Boolean):void{
            width_ = _arg1;
            height_ = _arg2;
            name_ = _arg3;
            back_ = _arg4;
            allowPlayerTeleport_ = _arg5;
            showDisplays_ = _arg6;
            this.forceSoftwareRenderCheck(name_);
        }

        override public function setHitAreaProps(_arg1:int, _arg2:int):void{
            mapHitArea.graphics.beginFill(0xFF0000, 0);
            mapHitArea.graphics.drawRect((-(_arg1) / 2), ((-(_arg2) / 2) - 20), _arg1, _arg2);
        }

        private function forceSoftwareRenderCheck(_arg1:String):void{
            forceSoftwareRender = ((!((this.forceSoftwareMap[_arg1] == null))) || (((!((WebMain.STAGE == null))) && ((WebMain.STAGE.stage3Ds[0].context3D == null)))));
        }

        override public function initialize():void{
            squares_.length = (width_ * height_);
            addChild(this.bgCont);
            background_ = Background.getBackground(back_);
            if (!Parameters.isGpuRender()){
                if (background_ != null){
                    this.bgCont.addChild(background_);
                };
            };
            addChild(map_);
            addChild(mapHitArea);
            addChild(hurtOverlay_);
            addChild(gradientOverlay_);
            addChild(mapOverlay_);
            addChild(partyOverlay_);
            isPetYard = (name_.substr(0, 8) == "Pet Yard");
            isQuestRoom = !((name_.indexOf("Quest") == -1));
        }

        override public function dispose():void{
            var _local1:Square;
            var _local2:GameObject;
            var _local3:BasicObject;
            gs_ = null;
            background_ = null;
            map_ = null;
            mapHitArea.graphics.clear();
            mapHitArea = null;
            hurtOverlay_ = null;
            gradientOverlay_ = null;
            mapOverlay_ = null;
            partyOverlay_ = null;
            for each (_local1 in squareList_) {
                _local1.dispose();
            };
            squareList_.length = 0;
            squareList_ = null;
            squares_.length = 0;
            squares_ = null;
            for each (_local2 in goDict_) {
                _local2.dispose();
            };
            goDict_ = null;
            for each (_local3 in boDict_) {
                _local3.dispose();
            };
            boDict_ = null;
            merchLookup_ = null;
            player_ = null;
            party_ = null;
            quest_ = null;
            this.objsToAdd_ = null;
            this.idsToRemove_ = null;
            TextureFactory.disposeTextures();
            GraphicsFillExtra.dispose();
            Program3DFactory.getInstance().dispose();
        }

        override public function update(_arg1:int, _arg2:int):void{
            var _local3:BasicObject;
            var _local4:int;
            this.inUpdate_ = true;
            for each (_local3 in goDict_) {
                if (!_local3.update(_arg1, _arg2)){
                    this.idsToRemove_.push(_local3.objectId_);
                };
            };
            for each (_local3 in boDict_) {
                if (!_local3.update(_arg1, _arg2)){
                    this.idsToRemove_.push(_local3.objectId_);
                };
            };
            this.inUpdate_ = false;
            for each (_local3 in this.objsToAdd_) {
                this.internalAddObj(_local3);
            };
            this.objsToAdd_.length = 0;
            for each (_local4 in this.idsToRemove_) {
                this.internalRemoveObj(_local4);
            };
            this.idsToRemove_.length = 0;
            party_.update(_arg1, _arg2);
        }

        override public function pSTopW(_arg1:Number, _arg2:Number):Point{
            var _local3:Square;
            for each (_local3 in this.visibleSquares_) {
                if (((!((_local3.faces_.length == 0))) && (_local3.faces_[0].face_.contains(_arg1, _arg2)))){
                    return (new Point(_local3.center_.x, _local3.center_.y));
                };
            };
            return (null);
        }

        override public function setGroundTile(_arg1:int, _arg2:int, _arg3:uint):void{
            var _local8:int;
            var _local9:int;
            var _local10:Square;
            var _local4:Square = this.getSquare(_arg1, _arg2);
            _local4.setTileType(_arg3);
            var _local5:int = (((_arg1 < (width_ - 1))) ? (_arg1 + 1) : _arg1);
            var _local6:int = (((_arg2 < (height_ - 1))) ? (_arg2 + 1) : _arg2);
            var _local7:int = (((_arg1 > 0)) ? (_arg1 - 1) : _arg1);
            while (_local7 <= _local5) {
                _local8 = (((_arg2 > 0)) ? (_arg2 - 1) : _arg2);
                while (_local8 <= _local6) {
                    _local9 = (_local7 + (_local8 * width_));
                    _local10 = squares_[_local9];
                    if (((!((_local10 == null))) && (((_local10.props_.hasEdge_) || (!((_local10.tileType_ == _arg3))))))){
                        _local10.faces_.length = 0;
                    };
                    _local8++;
                };
                _local7++;
            };
        }

        override public function addObj(_arg1:BasicObject, _arg2:Number, _arg3:Number):void{
            _arg1.x_ = _arg2;
            _arg1.y_ = _arg3;
            if ((_arg1 is ParticleEffect)){
                (_arg1 as ParticleEffect).reducedDrawEnabled = !(Parameters.data_.particleEffect);
            };
            if (this.inUpdate_){
                this.objsToAdd_.push(_arg1);
            }
            else {
                this.internalAddObj(_arg1);
            };
        }

        public function internalAddObj(_arg1:BasicObject):void{
            if (!_arg1.addTo(this, _arg1.x_, _arg1.y_)){
                return;
            };
            var _local2:Dictionary = (((_arg1 is GameObject)) ? goDict_ : boDict_);
            if (_local2[_arg1.objectId_] != null){
                if (!isPetYard){
                    return;
                };
            };
            if ((((name_ == ORYX_CHAMBER)) && ((this.oryxObjectId == 0)))){
                if ((((_arg1 is Character)) && (((_arg1 as Character).getName() == QuestModel.ORYX_THE_MAD_GOD)))){
                    this.oryxObjectId = _arg1.objectId_;
                };
            };
            _local2[_arg1.objectId_] = _arg1;
        }

        override public function removeObj(_arg1:int):void{
            if (this.inUpdate_){
                this.idsToRemove_.push(_arg1);
            }
            else {
                this.internalRemoveObj(_arg1);
            };
        }

        public function internalRemoveObj(_arg1:int):void{
            var _local2:Dictionary = goDict_;
            var _local3:BasicObject = _local2[_arg1];
            if (_local3 == null){
                _local2 = boDict_;
                _local3 = _local2[_arg1];
                if (_local3 == null){
                    return;
                };
            };
            _local3.removeFromMap();
            if ((((name_ == ORYX_CHAMBER)) && ((_arg1 == this.oryxObjectId)))){
                StaticInjectorContext.getInjector().getInstance(RealmOryxSignal).dispatch();
            };
            delete _local2[_arg1];
        }

        public function getSquare(_arg1:Number, _arg2:Number):Square{
            if ((((((((_arg1 < 0)) || ((_arg1 >= width_)))) || ((_arg2 < 0)))) || ((_arg2 >= height_)))){
                return (null);
            };
            var _local3:int = (int(_arg1) + (int(_arg2) * width_));
            var _local4:Square = squares_[_local3];
            if (_local4 == null){
                _local4 = new Square(this, int(_arg1), int(_arg2));
                squares_[_local3] = _local4;
                squareList_.push(_local4);
            };
            return (_local4);
        }

        public function lookupSquare(_arg1:int, _arg2:int):Square{
            if ((((((((_arg1 < 0)) || ((_arg1 >= width_)))) || ((_arg2 < 0)))) || ((_arg2 >= height_)))){
                return (null);
            };
            return (squares_[(_arg1 + (_arg2 * width_))]);
        }

        override public function draw(_arg1:Camera, _arg2:int):void{
            var _local6:Square;
            var _local13:GameObject;
            var _local14:BasicObject;
            var _local15:int;
            var _local16:Number;
            var _local17:Number;
            var _local18:Number;
            var _local19:Number;
            var _local20:Number;
            var _local21:uint;
            var _local22:Render3D;
            var _local23:int;
            var _local24:Array;
            var _local25:Number;
            if (wasLastFrameGpu != Parameters.isGpuRender()){
                if ((((((wasLastFrameGpu == true)) && (!((WebMain.STAGE.stage3Ds[0].context3D == null))))) && (!(((!((WebMain.STAGE.stage3Ds[0].context3D == null))) && (!((WebMain.STAGE.stage3Ds[0].context3D.driverInfo.toLowerCase().indexOf("disposed") == -1)))))))){
                    WebMain.STAGE.stage3Ds[0].context3D.clear();
                    WebMain.STAGE.stage3Ds[0].context3D.present();
                }
                else {
                    map_.graphics.clear();
                };
                signalRenderSwitch.dispatch(wasLastFrameGpu);
                wasLastFrameGpu = Parameters.isGpuRender();
                if (Parameters.isGpuRender()){
                    if (((!((background_ == null))) && (this.bgCont.contains(background_)))){
                        this.bgCont.removeChild(background_);
                    };
                }
                else {
                    if (((!((background_ == null))) && (!(this.bgCont.contains(background_))))){
                        this.bgCont.addChild(background_);
                    };
                };
            };
            var _local3:Rectangle = _arg1.clipRect_;
            x = -(_local3.x);
            y = -(_local3.y);
            var _local4:Number = ((-(_local3.y) - (_local3.height / 2)) / 50);
            var _local5:Point = new Point((_arg1.x_ + (_local4 * Math.cos((_arg1.angleRad_ - (Math.PI / 2))))), (_arg1.y_ + (_local4 * Math.sin((_arg1.angleRad_ - (Math.PI / 2))))));
            if (((!((background_ == null))) && (this.bgCont.contains(background_)))){
                background_.draw(_arg1, _arg2);
            };
            this.visible_.length = 0;
            this.visibleUnder_.length = 0;
            this.visibleSquares_.length = 0;
            this.topSquares_.length = 0;
            var _local7:int = _arg1.maxDist_;
            var _local8:int = Math.max(0, (_local5.x - _local7));
            var _local9:int = Math.min((width_ - 1), (_local5.x + _local7));
            var _local10:int = Math.max(0, (_local5.y - _local7));
            var _local11:int = Math.min((height_ - 1), (_local5.y + _local7));
            this.graphicsData_.length = 0;
            this.graphicsDataStageSoftware_.length = 0;
            this.graphicsData3d_.length = 0;
            var _local12:int = _local8;
            while (_local12 <= _local9) {
                _local15 = _local10;
                while (_local15 <= _local11) {
                    _local6 = squares_[(_local12 + (_local15 * width_))];
                    if (_local6 != null){
                        _local16 = (_local5.x - _local6.center_.x);
                        _local17 = (_local5.y - _local6.center_.y);
                        _local18 = ((_local16 * _local16) + (_local17 * _local17));
                        if (_local18 <= _arg1.maxDistSq_){
                            _local6.lastVisible_ = _arg2;
                            _local6.draw(this.graphicsData_, _arg1, _arg2);
                            this.visibleSquares_.push(_local6);
                            if (_local6.topFace_ != null){
                                this.topSquares_.push(_local6);
                            };
                        };
                    };
                    _local15++;
                };
                _local12++;
            };
            for each (_local13 in goDict_) {
                _local13.drawn_ = false;
                if (!((_local13.dead_) || ((_local13.size_ == 0)))){
                    _local6 = _local13.square_;
                    if (!(((_local6 == null)) || (!((_local6.lastVisible_ == _arg2))))){
                        _local13.drawn_ = true;
                        _local13.computeSortVal(_arg1);
                        if (_local13.props_.drawUnder_){
                            if (_local13.props_.drawOnGround_){
                                _local13.draw(this.graphicsData_, _arg1, _arg2);
                            }
                            else {
                                this.visibleUnder_.push(_local13);
                            };
                        }
                        else {
                            this.visible_.push(_local13);
                        };
                    };
                };
            };
            for each (_local14 in boDict_) {
                _local14.drawn_ = false;
                _local6 = _local14.square_;
                if (!(((_local6 == null)) || (!((_local6.lastVisible_ == _arg2))))){
                    _local14.drawn_ = true;
                    _local14.computeSortVal(_arg1);
                    this.visible_.push(_local14);
                };
            };
            if (this.visibleUnder_.length > 0){
                this.visibleUnder_.sortOn(VISIBLE_SORT_FIELDS, VISIBLE_SORT_PARAMS);
                for each (_local14 in this.visibleUnder_) {
                    _local14.draw(this.graphicsData_, _arg1, _arg2);
                };
            };
            this.visible_.sortOn(VISIBLE_SORT_FIELDS, VISIBLE_SORT_PARAMS);
            if (Parameters.data_.drawShadows){
                for each (_local14 in this.visible_) {
                    if (_local14.hasShadow_){
                        _local14.drawShadow(this.graphicsData_, _arg1, _arg2);
                    };
                };
            };
            for each (_local14 in this.visible_) {
                _local14.draw(this.graphicsData_, _arg1, _arg2);
                if (Parameters.isGpuRender()){
                    _local14.draw3d(this.graphicsData3d_);
                };
            };
            if (this.topSquares_.length > 0){
                for each (_local6 in this.topSquares_) {
                    _local6.drawTop(this.graphicsData_, _arg1, _arg2);
                };
            };
            if (((((!((player_ == null))) && ((player_.breath_ >= 0)))) && ((player_.breath_ < Parameters.BREATH_THRESH)))){
                _local19 = ((Parameters.BREATH_THRESH - player_.breath_) / Parameters.BREATH_THRESH);
                _local20 = (Math.abs(Math.sin((_arg2 / 300))) * 0.75);
                BREATH_CT.alphaMultiplier = (_local19 * _local20);
                hurtOverlay_.transform.colorTransform = BREATH_CT;
                hurtOverlay_.visible = true;
                hurtOverlay_.x = _local3.left;
                hurtOverlay_.y = _local3.top;
            }
            else {
                hurtOverlay_.visible = false;
            };
            if (((!((player_ == null))) && (!(Parameters.screenShotMode_)))){
                gradientOverlay_.visible = true;
                gradientOverlay_.x = (_local3.right - 10);
                gradientOverlay_.y = _local3.top;
            }
            else {
                gradientOverlay_.visible = false;
            };
            if (((Parameters.isGpuRender()) && (Renderer.inGame))){
                _local21 = this.getFilterIndex();
                _local22 = StaticInjectorContext.getInjector().getInstance(Render3D);
                _local22.dispatch(this.graphicsData_, this.graphicsData3d_, width_, height_, _arg1, _local21);
                _local23 = 0;
                while (_local23 < this.graphicsData_.length) {
                    if ((((this.graphicsData_[_local23] is GraphicsBitmapFill)) && (GraphicsFillExtra.isSoftwareDraw(GraphicsBitmapFill(this.graphicsData_[_local23]))))){
                        this.graphicsDataStageSoftware_.push(this.graphicsData_[_local23]);
                        this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local23 + 1)]);
                        this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local23 + 2)]);
                    }
                    else {
                        if ((((this.graphicsData_[_local23] is GraphicsSolidFill)) && (GraphicsFillExtra.isSoftwareDrawSolid(GraphicsSolidFill(this.graphicsData_[_local23]))))){
                            this.graphicsDataStageSoftware_.push(this.graphicsData_[_local23]);
                            this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local23 + 1)]);
                            this.graphicsDataStageSoftware_.push(this.graphicsData_[(_local23 + 2)]);
                        };
                    };
                    _local23++;
                };
                if (this.graphicsDataStageSoftware_.length > 0){
                    map_.graphics.clear();
                    map_.graphics.drawGraphicsData(this.graphicsDataStageSoftware_);
                    if (this.lastSoftwareClear){
                        this.lastSoftwareClear = false;
                    };
                }
                else {
                    if (!this.lastSoftwareClear){
                        map_.graphics.clear();
                        this.lastSoftwareClear = true;
                    };
                };
                if ((_arg2 % 149) == 0){
                    GraphicsFillExtra.manageSize();
                };
            }
            else {
                map_.graphics.clear();
                map_.graphics.drawGraphicsData(this.graphicsData_);
            };
            map_.filters.length = 0;
            if (((!((player_ == null))) && (!(((player_.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.MAP_FILTER_BITMASK) == 0))))){
                _local24 = [];
                if (player_.isDrunk()){
                    _local25 = (20 + (10 * Math.sin((_arg2 / 1000))));
                    _local24.push(new BlurFilter(_local25, _local25));
                };
                if (player_.isBlind()){
                    _local24.push(BLIND_FILTER);
                };
                map_.filters = _local24;
            }
            else {
                if (map_.filters.length > 0){
                    map_.filters = [];
                };
            };
            mapOverlay_.draw(_arg1, _arg2);
            partyOverlay_.draw(_arg1, _arg2);
            if (((player_) && (player_.isDarkness()))){
                this.darkness.x = -300;
                this.darkness.y = ((Parameters.data_.centerOnPlayer) ? -525 : -515);
                this.darkness.alpha = 0.95;
                addChild(this.darkness);
            }
            else {
                if (contains(this.darkness)){
                    removeChild(this.darkness);
                };
            };
        }

        private function getFilterIndex():uint{
            var _local1:uint;
            if (((!((player_ == null))) && (!(((player_.condition_[ConditionEffect.CE_FIRST_BATCH] & ConditionEffect.MAP_FILTER_BITMASK) == 0))))){
                if (player_.isPaused()){
                    _local1 = Renderer.STAGE3D_FILTER_PAUSE;
                }
                else {
                    if (player_.isBlind()){
                        _local1 = Renderer.STAGE3D_FILTER_BLIND;
                    }
                    else {
                        if (player_.isDrunk()){
                            _local1 = Renderer.STAGE3D_FILTER_DRUNK;
                        };
                    };
                };
            };
            return (_local1);
        }


    }
}//package com.company.assembleegameclient.map

