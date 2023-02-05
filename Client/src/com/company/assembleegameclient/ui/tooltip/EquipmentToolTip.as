// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.tooltip.EquipmentToolTip

package com.company.assembleegameclient.ui.tooltip{
    import flash.utils.Dictionary;
    import flash.display.Bitmap;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import io.decagames.rotmg.ui.labels.UILabel;
    import com.company.assembleegameclient.ui.LineBreakDesign;
    import com.company.assembleegameclient.objects.Player;
    import com.company.assembleegameclient.game.events.KeyInfoResponseSignal;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import kabam.rotmg.text.model.TextKey;
    import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
    import com.company.assembleegameclient.util.FilterUtil;
    import kabam.rotmg.constants.ActivationType;
    import kabam.rotmg.messaging.impl.incoming.KeyInfoResponse;
    import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
    import flash.display.BitmapData;
    import com.company.util.BitmapUtil;
    import com.company.assembleegameclient.util.TierUtil;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import com.company.assembleegameclient.util.MathUtil;
    import kabam.rotmg.messaging.impl.data.StatData;
    import com.company.assembleegameclient.constants.InventoryOwnerTypes;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.util.KeyCodes;
    import kabam.rotmg.text.view.stringBuilder.StringBuilder;
    import kabam.rotmg.constants.*;

    public class EquipmentToolTip extends ToolTip {

        private static const MAX_WIDTH:int = 230;

        public static var keyInfo:Dictionary = new Dictionary();

        private var icon:Bitmap;
        public var titleText:TextFieldDisplayConcrete;
        private var tierText:UILabel;
        private var descText:TextFieldDisplayConcrete;
        private var line1:LineBreakDesign;
        private var effectsText:TextFieldDisplayConcrete;
        private var line2:LineBreakDesign;
        private var line3:LineBreakDesign;
        private var restrictionsText:TextFieldDisplayConcrete;
        private var setInfoText:TextFieldDisplayConcrete;
        private var player:Player;
        private var isEquippable:Boolean = false;
        private var objectType:int;
        private var titleOverride:String;
        private var descriptionOverride:String;
        private var curItemXML:XML = null;
        private var objectXML:XML = null;
        private var objectPatchXML:XML = null;
        private var slotTypeToTextBuilder:SlotComparisonFactory;
        private var restrictions:Vector.<Restriction>;
        private var setInfo:Vector.<Effect>;
        private var effects:Vector.<Effect>;
        private var uniqueEffects:Vector.<Effect>;
        private var itemSlotTypeId:int;
        private var invType:int;
        private var inventorySlotID:uint;
        private var inventoryOwnerType:String;
        private var isInventoryFull:Boolean;
        private var playerCanUse:Boolean;
        private var comparisonResults:SlotComparisonResult;
        private var powerText:TextFieldDisplayConcrete;
        private var supporterPointsText:TextFieldDisplayConcrete;
        private var keyInfoResponse:KeyInfoResponseSignal;
        private var originalObjectType:int;
        private var sameActivateEffect:Boolean;

        public function EquipmentToolTip(_arg1:int, _arg2:Player, _arg3:int, _arg4:String){
            this.uniqueEffects = new Vector.<Effect>();
            this.objectType = _arg1;
            this.originalObjectType = this.objectType;
            this.player = _arg2;
            this.invType = _arg3;
            this.inventoryOwnerType = _arg4;
            this.isInventoryFull = ((_arg2) ? _arg2.isInventoryFull() : false);
            this.playerCanUse = ((_arg2) ? ObjectLibrary.isUsableByPlayer(this.objectType, _arg2) : false);
            var _local5:uint = ((((this.playerCanUse) || ((this.player == null)))) ? 0x363636 : 6036765);
            var _local6:uint = ((((this.playerCanUse) || ((_arg2 == null)))) ? 0x9B9B9B : 10965039);
            super(_local5, 1, _local6, 1, true);
            var _local7:int = ((_arg2) ? ObjectLibrary.getMatchingSlotIndex(this.objectType, _arg2) : -1);
            this.slotTypeToTextBuilder = new SlotComparisonFactory();
            this.objectXML = ObjectLibrary.xmlLibrary_[this.objectType];
            this.objectPatchXML = ObjectLibrary.xmlPatchLibrary_[this.objectType];
            this.isEquippable = !((_local7 == -1));
            this.setInfo = new Vector.<Effect>();
            this.effects = new Vector.<Effect>();
            this.itemSlotTypeId = int(this.objectXML.SlotType);
            if (this.player == null){
                this.curItemXML = this.objectXML;
            }
            else {
                if (this.isEquippable){
                    if (this.player.equipment_[_local7] != -1){
                        this.curItemXML = ObjectLibrary.xmlLibrary_[this.player.equipment_[_local7]];
                    }
                }
            }
            this.addIcon();
            this.addTitle();
            this.addDescriptionText();
            this.addTierText();
            this.handleWisMod();
            this.buildCategorySpecificText();
            this.addUniqueEffectsToList();
            this.sameActivateEffect = false;
            this.addActivateTagsToEffectsList();
            this.addNumProjectiles();
            this.addProjectileTagsToEffectsList();
            this.addRateOfFire();
            this.addActivateOnEquipTagsToEffectsList();
            this.addDoseTagsToEffectsList();
            this.addMpCostTagToEffectsList();
            this.addFameBonusTagToEffectsList();
            this.addCooldown();
            this.addSetInfo();
            this.makeSetInfoText();
            this.makeEffectsList();
            this.makeLineTwo();
            this.makeRestrictionList();
            this.makeRestrictionText();
            this.makeItemPowerText();
            this.makeSupporterPointsText();
        }

        private function addSetInfo():void{
            if (!this.objectXML.hasOwnProperty("@setType")){
                return;
            }
            var _local1:int = this.objectXML.attribute("setType");
            this.setInfo.push(new Effect("{name} ", {name:(("<b>" + this.objectXML.attribute("setName")) + "</b>")}).setColor(TooltipHelper.SET_COLOR).setReplacementsColor(TooltipHelper.SET_COLOR));
            this.addSetActivateOnEquipTagsToEffectsList(_local1);
        }

        private function addSetActivateOnEquipTagsToEffectsList(_arg1:int):void{
            var _local4:XML;
            var _local5:uint;
            var _local6:uint;
            var _local7:XML;
            var _local8:XML;
            var _local9:XML;
            var _local2:XML = ObjectLibrary.getSetXMLFromType(_arg1);
            var _local3:int;
            for each (_local4 in _local2.Setpiece) {
                if (_local4.toString() == "Equipment"){
                    if (((!((this.player == null))) && ((this.player.equipment_[int(_local4.@slot)] == int(_local4.@itemtype))))){
                        _local3++;
                    }
                }
            }
            _local5 = TooltipHelper.SET_COLOR_INACTIVE;
            _local6 = TooltipHelper.NO_DIFF_COLOR;
            if (_local2.hasOwnProperty("ActivateOnEquip2")){
                _local5 = (((_local3 >= 2)) ? TooltipHelper.SET_COLOR : TooltipHelper.SET_COLOR_INACTIVE);
                _local6 = (((_local3 >= 2)) ? TooltipHelper.NO_DIFF_COLOR : TooltipHelper.NO_DIFF_COLOR_INACTIVE);
                this.setInfo.push(new Effect("2 Pieces", null).setColor(_local5).setReplacementsColor(_local5));
                for each (_local7 in _local2.ActivateOnEquip2) {
                    this.makeSetEffectLine(_local7, _local6);
                }
            }
            if (_local2.hasOwnProperty("ActivateOnEquip3")){
                _local5 = (((_local3 >= 3)) ? TooltipHelper.SET_COLOR : TooltipHelper.SET_COLOR_INACTIVE);
                _local6 = (((_local3 >= 3)) ? TooltipHelper.NO_DIFF_COLOR : TooltipHelper.NO_DIFF_COLOR_INACTIVE);
                this.setInfo.push(new Effect("3 Pieces", null).setColor(_local5).setReplacementsColor(_local5));
                for each (_local8 in _local2.ActivateOnEquip3) {
                    this.makeSetEffectLine(_local8, _local6);
                }
            }
            if (_local2.hasOwnProperty("ActivateOnEquipAll")){
                _local5 = (((_local3 >= 4)) ? TooltipHelper.SET_COLOR : TooltipHelper.SET_COLOR_INACTIVE);
                _local6 = (((_local3 >= 4)) ? TooltipHelper.NO_DIFF_COLOR : TooltipHelper.NO_DIFF_COLOR_INACTIVE);
                this.setInfo.push(new Effect("Full Set", null).setColor(_local5).setReplacementsColor(_local5));
                for each (_local9 in _local2.ActivateOnEquipAll) {
                    this.makeSetEffectLine(_local9, _local6);
                }
            }
        }

        private function makeSetEffectLine(_arg1:XML, _arg2:uint):void{
            if (_arg1.toString() == "IncrementStat"){
                this.setInfo.push(new Effect(TextKey.INCREMENT_STAT, this.getComparedStatText(_arg1)).setColor(_arg2).setReplacementsColor(_arg2));
            }
        }

        private function makeItemPowerText():void{
            var _local1:int;
            var _local2:int;
            if (this.objectXML.hasOwnProperty("feedPower")){
                _local1 = this.objectXML.feedPower;
                if (((ObjectLibrary.usePatchedData) && (this.objectPatchXML))){
                    if (this.objectPatchXML.hasOwnProperty("feedPower")){
                        _local1 = this.objectPatchXML.feedPower;
                    }
                }
                _local2 = ((((this.playerCanUse) || ((this.player == null)))) ? 0xFFFFFF : 16549442);
                this.powerText = new TextFieldDisplayConcrete().setSize(12).setColor(_local2).setBold(true).setTextWidth((((MAX_WIDTH - this.icon.width) - 4) - 30)).setWordWrap(true);
                this.powerText.setStringBuilder(new StaticStringBuilder().setString(("Feed Power: " + _local1)));
                this.powerText.filters = FilterUtil.getStandardDropShadowFilter();
                waiter.push(this.powerText.textChanged);
                addChild(this.powerText);
            }
        }

        private function makeSupporterPointsText():void{
            var _local1:XML;
            var _local2:String;
            for each (_local1 in this.objectXML.Activate) {
                _local2 = _local1.toString();
                if (_local2 == ActivationType.GRANT_SUPPORTER_POINTS){
                    this.supporterPointsText = new TextFieldDisplayConcrete().setSize(12).setColor(0xFFFFFF).setBold(true).setTextWidth((((MAX_WIDTH - this.icon.width) - 4) - 30)).setWordWrap(true);
                    this.supporterPointsText.setStringBuilder(new StaticStringBuilder().setString(("Campaign points: " + _local1.@amount)));
                    this.supporterPointsText.filters = FilterUtil.getStandardDropShadowFilter();
                    waiter.push(this.supporterPointsText.textChanged);
                    addChild(this.supporterPointsText);
                }
            }
        }

        private function onKeyInfoResponse(_arg1:KeyInfoResponse):void{
            this.keyInfoResponse.remove(this.onKeyInfoResponse);
            this.removeTitle();
            this.removeDesc();
            this.titleOverride = _arg1.name;
            this.descriptionOverride = _arg1.description;
            keyInfo[this.originalObjectType] = [_arg1.name, _arg1.description, _arg1.creator];
            this.addTitle();
            this.addDescriptionText();
        }

        private function addUniqueEffectsToList():void{
            var _local1:XMLList;
            var _local2:XML;
            var _local3:String;
            var _local4:String;
            var _local5:String;
            var _local6:AppendingLineBuilder;
            if (this.objectXML.hasOwnProperty("ExtraTooltipData")){
                _local1 = this.objectXML.ExtraTooltipData.EffectInfo;
                for each (_local2 in _local1) {
                    _local3 = _local2.attribute("name");
                    _local4 = _local2.attribute("description");
                    _local5 = ((((_local3) && (_local4))) ? ": " : "\n");
                    _local6 = new AppendingLineBuilder();
                    if (_local3){
                        _local6.pushParams(_local3);
                    }
                    if (_local4){
                        _local6.pushParams(_local4, {}, TooltipHelper.getOpenTag(16777103), TooltipHelper.getCloseTag());
                    }
                    _local6.setDelimiter(_local5);
                    this.uniqueEffects.push(new Effect(TextKey.BLANK, {data:_local6}));
                }
            }
        }

        private function isEmptyEquipSlot():Boolean{
            return (((this.isEquippable) && ((this.curItemXML == null))));
        }

        private function addIcon():void{
            var _local1:XML = ObjectLibrary.xmlLibrary_[this.objectType];
            var _local2:int = 5;
            if ((((this.objectType == 4874)) || ((this.objectType == 4618)))){
                _local2 = 8;
            }
            if (_local1.hasOwnProperty("ScaleValue")){
                _local2 = _local1.ScaleValue;
            }
            var _local3:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.objectType, 60, true, true, _local2);
            _local3 = BitmapUtil.cropToBitmapData(_local3, 4, 4, (_local3.width - 8), (_local3.height - 8));
            this.icon = new Bitmap(_local3);
            addChild(this.icon);
        }

        private function addTierText():void{
            this.tierText = TierUtil.getTierTag(this.objectXML, 16);
            if (this.tierText){
                addChild(this.tierText);
            }
        }

        private function removeTitle():void{
            removeChild(this.titleText);
        }

        private function removeDesc():void{
            removeChild(this.descText);
        }

        private function addTitle():void{
            var _local1:int = ((((this.playerCanUse) || ((this.player == null)))) ? 0xFFFFFF : 16549442);
            this.titleText = new TextFieldDisplayConcrete().setSize(16).setColor(_local1).setBold(true).setTextWidth((((MAX_WIDTH - this.icon.width) - 4) - 30)).setWordWrap(true);
            if (this.titleOverride){
                this.titleText.setStringBuilder(new StaticStringBuilder(this.titleOverride));
            }
            else {
                this.titleText.setStringBuilder(new LineBuilder().setParams(ObjectLibrary.typeToDisplayId_[this.objectType]));
            }
            this.titleText.filters = FilterUtil.getStandardDropShadowFilter();
            waiter.push(this.titleText.textChanged);
            addChild(this.titleText);
        }

        private function buildUniqueTooltipData():String{
            var _local1:XMLList;
            var _local2:Vector.<Effect>;
            var _local3:XML;
            if (this.objectXML.hasOwnProperty("ExtraTooltipData")){
                _local1 = this.objectXML.ExtraTooltipData.EffectInfo;
                _local2 = new Vector.<Effect>();
                for each (_local3 in _local1) {
                    _local2.push(new Effect(_local3.attribute("name"), _local3.attribute("description")));
                }
            }
            return ("");
        }

        private function makeEffectsList():void{
            var _local1:AppendingLineBuilder;
            if (((((!((this.effects.length == 0))) || (!((this.comparisonResults.lineBuilder == null))))) || (this.objectXML.hasOwnProperty("ExtraTooltipData")))){
                this.line1 = new LineBreakDesign((MAX_WIDTH - 12), 0);
                this.effectsText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth(MAX_WIDTH).setWordWrap(true).setHTML(true);
                _local1 = this.getEffectsStringBuilder();
                this.effectsText.setStringBuilder(_local1);
                this.effectsText.filters = FilterUtil.getStandardDropShadowFilter();
                if (_local1.hasLines()){
                    addChild(this.line1);
                    addChild(this.effectsText);
                    waiter.push(this.effectsText.textChanged);
                }
            }
        }

        private function getEffectsStringBuilder():AppendingLineBuilder{
            var _local1:AppendingLineBuilder = new AppendingLineBuilder();
            this.appendEffects(this.uniqueEffects, _local1);
            if (this.comparisonResults.lineBuilder.hasLines()){
                _local1.pushParams(TextKey.BLANK, {data:this.comparisonResults.lineBuilder});
            }
            this.appendEffects(this.effects, _local1);
            return (_local1);
        }

        private function appendEffects(_arg1:Vector.<Effect>, _arg2:AppendingLineBuilder):void{
            var _local3:Effect;
            var _local4:String;
            var _local5:String;
            for each (_local3 in _arg1) {
                _local4 = "";
                _local5 = "";
                if (_local3.color_){
                    _local4 = (('<font color="#' + _local3.color_.toString(16)) + '">');
                    _local5 = "</font>";
                }
                _arg2.pushParams(_local3.name_, _local3.getValueReplacementsWithColor(), _local4, _local5);
            }
        }

        private function addFameBonusTagToEffectsList():void{
            var _local1:int;
            var _local2:uint;
            var _local3:int;
            if (this.objectXML.hasOwnProperty("FameBonus")){
                _local1 = int(this.objectXML.FameBonus);
                _local2 = ((this.playerCanUse) ? TooltipHelper.BETTER_COLOR : TooltipHelper.NO_DIFF_COLOR);
                if (((!((this.curItemXML == null))) && (this.curItemXML.hasOwnProperty("FameBonus")))){
                    _local3 = int(this.curItemXML.FameBonus.text());
                    _local2 = TooltipHelper.getTextColor((_local1 - _local3));
                }
                this.effects.push(new Effect(TextKey.FAME_BONUS, {percent:(this.objectXML.FameBonus + "%")}).setReplacementsColor(_local2));
            }
        }

        private function addMpCostTagToEffectsList():void{
            var _local1:int;
            var _local2:int;
            if (this.objectXML.hasOwnProperty("MpEndCost")){
                _local2 = this.objectXML.MpEndCost;
                _local1 = _local2;
                if (((this.curItemXML) && (this.curItemXML.hasOwnProperty("MpEndCost")))){
                    _local2 = this.curItemXML.MpEndCost;
                }
                this.effects.push(new Effect(TextKey.MP_COST, {cost:TooltipHelper.compare(_local1, _local2, false)}));
            }
            else {
                if (this.objectXML.hasOwnProperty("MpCost")){
                    _local2 = this.objectXML.MpCost;
                    _local1 = _local2;
                    if (((this.curItemXML) && (this.curItemXML.hasOwnProperty("MpCost")))){
                        _local2 = this.curItemXML.MpCost;
                    }
                    this.effects.push(new Effect(TextKey.MP_COST, {cost:TooltipHelper.compare(_local1, _local2, false)}));
                }
            }
        }

        private function addDoseTagsToEffectsList():void{
            if (this.objectXML.hasOwnProperty("Doses")){
                this.effects.push(new Effect(TextKey.DOSES, {dose:this.objectXML.Doses}));
            }
            if (this.objectXML.hasOwnProperty("Quantity")){
                this.effects.push(new Effect("Quantity: {quantity}", {quantity:this.objectXML.Quantity}));
            }
        }

        private function addNumProjectiles():void{
            var _local1:ComPairTag = new ComPairTag(this.objectXML, this.curItemXML, "NumProjectiles", 1);
            if (((!((_local1.a == 1))) || (!((_local1.a == _local1.b))))){
                this.effects.push(new Effect(TextKey.SHOTS, {numShots:TooltipHelper.compare(_local1.a, _local1.b)}));
            }
        }

        private function addProjectileTagsToEffectsList():void{
            var _local1:XML;
            if (this.objectXML.hasOwnProperty("Projectile")){
                _local1 = (((this.curItemXML == null)) ? null : this.curItemXML.Projectile[0]);
                this.addProjectile(this.objectXML.Projectile[0], _local1);
            }
        }

        private function addProjectile(_arg1:XML, _arg2:XML=null):void{
            var _local15:XML;
            var _local3:ComPairTag = new ComPairTag(_arg1, _arg2, "MinDamage");
            var _local4:ComPairTag = new ComPairTag(_arg1, _arg2, "MaxDamage");
            var _local5:ComPairTag = new ComPairTag(_arg1, _arg2, "Speed");
            var _local6:ComPairTag = new ComPairTag(_arg1, _arg2, "LifetimeMS");
            var _local7:ComPairTagBool = new ComPairTagBool(_arg1, _arg2, "Boomerang");
            var _local8:ComPairTagBool = new ComPairTagBool(_arg1, _arg2, "Parametric");
            var _local9:ComPairTag = new ComPairTag(_arg1, _arg2, "Magnitude", 3);
            var _local10:Number = ((_local8.a) ? _local9.a : MathUtil.round((((_local5.a * _local6.a) / (int(_local7.a) + 1)) / 10000), 2));
            var _local11:Number = ((_local8.b) ? _local9.b : MathUtil.round((((_local5.b * _local6.b) / (int(_local7.b) + 1)) / 10000), 2));
            var _local12:Number = ((_local4.a + _local3.a) / 2);
            var _local13:Number = ((_local4.b + _local3.b) / 2);
            var _local14:String = (((_local3.a == _local4.a)) ? _local3.a : ((_local3.a + " - ") + _local4.a)).toString();
            this.effects.push(new Effect(TextKey.DAMAGE, {damage:TooltipHelper.wrapInFontTag(_local14, ("#" + TooltipHelper.getTextColor((_local12 - _local13)).toString(16)))}));
            this.effects.push(new Effect(TextKey.RANGE, {range:TooltipHelper.compare(_local10, _local11)}));
            if (_arg1.hasOwnProperty("MultiHit")){
                this.effects.push(new Effect(TextKey.MULTIHIT, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            }
            if (_arg1.hasOwnProperty("PassesCover")){
                this.effects.push(new Effect(TextKey.PASSES_COVER, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            }
            if (_arg1.hasOwnProperty("ArmorPiercing")){
                this.effects.push(new Effect(TextKey.ARMOR_PIERCING, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            }
            if (_local8.a){
                this.effects.push(new Effect("Shots are parametric", {}).setColor(TooltipHelper.NO_DIFF_COLOR));
            }
            else {
                if (_local7.a){
                    this.effects.push(new Effect("Shots boomerang", {}).setColor(TooltipHelper.NO_DIFF_COLOR));
                }
            }
            if (_arg1.hasOwnProperty("ConditionEffect")){
                this.effects.push(new Effect(TextKey.SHOT_EFFECT, {effect:""}));
            }
            for each (_local15 in _arg1.ConditionEffect) {
                this.effects.push(new Effect(TextKey.EFFECT_FOR_DURATION, {
                    effect:_local15,
                    duration:_local15.@duration
                }).setColor(TooltipHelper.NO_DIFF_COLOR));
            }
        }

        private function addRateOfFire():void{
            var _local2:String;
            var _local1:ComPairTag = new ComPairTag(this.objectXML, this.curItemXML, "RateOfFire", 1);
            if (((!((_local1.a == 1))) || (!((_local1.a == _local1.b))))){
                _local1.a = MathUtil.round((_local1.a * 100), 2);
                _local1.b = MathUtil.round((_local1.b * 100), 2);
                _local2 = TooltipHelper.compare(_local1.a, _local1.b, true, "%");
                this.effects.push(new Effect(TextKey.RATE_OF_FIRE, {data:_local2}));
            }
        }

        private function addCooldown():void{
            var _local1:ComPairTag = new ComPairTag(this.objectXML, this.curItemXML, "Cooldown", 0.5);
            if (((!((_local1.a == 0.5))) || (!((_local1.a == _local1.b))))){
                this.effects.push(new Effect("Cooldown: {cd}", {cd:TooltipHelper.compareAndGetPlural(_local1.a, _local1.b, "second", false)}));
            }
        }

        private function addActivateTagsToEffectsList():void{
            var activateXML:XML;
            var val:String;
            var stat:int;
            var amt:int;
            var test:String;
            var activationType:String;
            var compareXML:XML;
            var effectColor:uint;
            var current:XML;
            var tokens:Object;
            var template:String;
            var effectColor2:uint;
            var current2:XML;
            var statStr:String;
            var tokens2:Object;
            var template2:String;
            var replaceParams:Object;
            var rNew:Number;
            var rCurrent:Number;
            var dNew:Number;
            var dCurrent:Number;
            var comparer:Number;
            var rNew2:Number;
            var rCurrent2:Number;
            var dNew2:Number;
            var dCurrent2:Number;
            var aNew2:Number;
            var aCurrent2:Number;
            var comparer2:Number;
            var alb:AppendingLineBuilder;
            for each (activateXML in this.objectXML.Activate) {
                test = this.comparisonResults.processedTags[activateXML.toXMLString()];
                if (this.comparisonResults.processedTags[activateXML.toXMLString()] != true){
                    activationType = activateXML.toString();
                    compareXML = (((this.curItemXML == null)) ? null : this.curItemXML.Activate.(text() == activationType)[0]);
                    switch (activationType){
                        case ActivationType.COND_EFFECT_AURA:
                            this.effects.push(new Effect(TextKey.PARTY_EFFECT, {effect:new AppendingLineBuilder().pushParams(TextKey.WITHIN_SQRS, {range:activateXML.@range}, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                            this.effects.push(new Effect(TextKey.EFFECT_FOR_DURATION, {
                                effect:activateXML.@effect,
                                duration:activateXML.@duration
                            }).setColor(TooltipHelper.NO_DIFF_COLOR));
                            break;
                        case ActivationType.COND_EFFECT_SELF:
                            this.effects.push(new Effect(TextKey.EFFECT_ON_SELF, {effect:""}));
                            this.effects.push(new Effect(TextKey.EFFECT_FOR_DURATION, {
                                effect:activateXML.@effect,
                                duration:activateXML.@duration
                            }));
                            break;
                        case ActivationType.STAT_BOOST_SELF:
                            this.effects.push(new Effect("{amount} {stat} for {duration} ", {
                                amount:this.prefix(activateXML.@amount),
                                stat:new LineBuilder().setParams(StatData.statToName(int(activateXML.@stat))),
                                duration:TooltipHelper.getPlural(activateXML.@duration, "second")
                            }));
                            break;
                        case ActivationType.HEAL:
                            this.effects.push(new Effect(TextKey.INCREMENT_STAT, {
                                statAmount:(("+" + activateXML.@amount) + " "),
                                statName:new LineBuilder().setParams(TextKey.STATUS_BAR_HEALTH_POINTS)
                            }));
                            break;
                        case ActivationType.HEAL_NOVA:
                            if (((activateXML.hasOwnProperty("@damage")) && ((int(activateXML.@damage) > 0)))){
                                this.effects.push(new Effect("{damage} damage within {range} sqrs", {
                                    damage:activateXML.@damage,
                                    range:activateXML.@range
                                }));
                            }
                            this.effects.push(new Effect(TextKey.PARTY_HEAL, {effect:new AppendingLineBuilder().pushParams(TextKey.HP_WITHIN_SQRS, {
                                    amount:activateXML.@amount,
                                    range:activateXML.@range
                                }, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                            break;
                        case ActivationType.MAGIC:
                            this.effects.push(new Effect(TextKey.INCREMENT_STAT, {
                                statAmount:(("+" + activateXML.@amount) + " "),
                                statName:new LineBuilder().setParams(TextKey.STATUS_BAR_MANA_POINTS)
                            }));
                            break;
                        case ActivationType.MAGIC_NOVA:
                            this.effects.push(new Effect(TextKey.PARTY_FILL, {effect:new AppendingLineBuilder().pushParams(TextKey.MP_WITHIN_SQRS, {
                                    amount:activateXML.@amount,
                                    range:activateXML.@range
                                }, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                            break;
                        case ActivationType.TELEPORT:
                            this.effects.push(new Effect(TextKey.BLANK, {data:new LineBuilder().setParams(TextKey.TELEPORT_TO_TARGET)}));
                            break;
                        case ActivationType.BULLET_NOVA:
                            this.getSpell(activateXML, compareXML);
                            break;
                        case ActivationType.BULLET_CREATE:
                            this.getBulletCreate(activateXML, compareXML);
                            break;
                        case ActivationType.VAMPIRE_BLAST:
                            this.getSkull(activateXML, compareXML);
                            break;
                        case ActivationType.TRAP:
                            this.getTrap(activateXML, compareXML);
                            break;
                        case ActivationType.STASIS_BLAST:
                            this.effects.push(new Effect(TextKey.STASIS_GROUP, {stasis:new AppendingLineBuilder().pushParams(TextKey.SEC_COUNT, {duration:activateXML.@duration}, TooltipHelper.getOpenTag(TooltipHelper.NO_DIFF_COLOR), TooltipHelper.getCloseTag())}));
                            break;
                        case ActivationType.DECOY:
                            this.getDecoy(activateXML, compareXML);
                            break;
                        case ActivationType.LIGHTNING:
                            this.getLightning(activateXML, compareXML);
                            break;
                        case ActivationType.POISON_GRENADE:
                            this.getPoison(activateXML, compareXML);
                            break;
                        case ActivationType.REMOVE_NEG_COND:
                            this.effects.push(new Effect(TextKey.REMOVES_NEGATIVE, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
                            break;
                        case ActivationType.REMOVE_NEG_COND_SELF:
                            this.effects.push(new Effect(TextKey.REMOVES_NEGATIVE, {}).setColor(TooltipHelper.NO_DIFF_COLOR));
                            break;
                        case ActivationType.GENERIC_ACTIVATE:
                            if (activateXML.hasOwnProperty("@ignoreOnTooltip")) break;
                            effectColor = 16777103;
                            if (this.curItemXML != null){
                                current = this.getEffectTag(this.curItemXML, activateXML.@effect);
                                if (current != null){
                                    rNew = Number(activateXML.@range);
                                    rCurrent = Number(current.@range);
                                    dNew = Number(activateXML.@duration);
                                    dCurrent = Number(current.@duration);
                                    comparer = ((rNew - rCurrent) + (dNew - dCurrent));
                                    if (comparer > 0){
                                        effectColor = 0xFF00;
                                    }
                                    else {
                                        if (comparer < 0){
                                            effectColor = 0xFF0000;
                                        }
                                    }
                                }
                            }
                            tokens = {
                                range:activateXML.@range,
                                effect:activateXML.@effect,
                                duration:activateXML.@duration
                            }
                            template = "Within {range} sqrs {effect} for {duration} seconds";
                            if (activateXML.@target != "enemy"){
                                this.effects.push(new Effect(TextKey.PARTY_EFFECT, {effect:LineBuilder.returnStringReplace(template, tokens)}).setReplacementsColor(effectColor));
                            }
                            else {
                                this.effects.push(new Effect(TextKey.ENEMY_EFFECT, {effect:LineBuilder.returnStringReplace(template, tokens)}).setReplacementsColor(effectColor));
                            }
                            break;
                        case ActivationType.STAT_BOOST_AURA:
                            effectColor2 = 16777103;
                            if (this.curItemXML != null){
                                current2 = this.getStatTag(this.curItemXML, activateXML.@stat);
                                if (current2 != null){
                                    rNew2 = Number(activateXML.@range);
                                    rCurrent2 = Number(current2.@range);
                                    dNew2 = Number(activateXML.@duration);
                                    dCurrent2 = Number(current2.@duration);
                                    aNew2 = Number(activateXML.@amount);
                                    aCurrent2 = Number(current2.@amount);
                                    comparer2 = (((rNew2 - rCurrent2) + (dNew2 - dCurrent2)) + (aNew2 - aCurrent2));
                                    if (comparer2 > 0){
                                        effectColor2 = 0xFF00;
                                    }
                                    else {
                                        if (comparer2 < 0){
                                            effectColor2 = 0xFF0000;
                                        }
                                    }
                                }
                            }
                            stat = int(activateXML.@stat);
                            statStr = LineBuilder.getLocalizedString2(StatData.statToName(stat));
                            tokens2 = {
                                range:activateXML.@range,
                                stat:statStr,
                                amount:activateXML.@amount,
                                duration:activateXML.@duration
                            }
                            template2 = "Within {range} sqrs increase {stat} by {amount} for {duration} seconds";
                            this.effects.push(new Effect(TextKey.PARTY_EFFECT, {effect:LineBuilder.returnStringReplace(template2, tokens2)}).setReplacementsColor(effectColor2));
                            break;
                        case ActivationType.INCREMENT_STAT:
                            stat = int(activateXML.@stat);
                            amt = int(activateXML.@amount);
                            replaceParams = {};
                            if (((!((stat == StatData.HP_STAT))) && (!((stat == StatData.MP_STAT))))){
                                val = TextKey.PERMANENTLY_INCREASES;
                                replaceParams["statName"] = new LineBuilder().setParams(StatData.statToName(stat));
                                this.effects.push(new Effect(val, replaceParams).setColor(16777103));
                                break;
                            }
                            val = TextKey.BLANK;
                            alb = new AppendingLineBuilder().setDelimiter(" ");
                            alb.pushParams(TextKey.BLANK, {data:new StaticStringBuilder(("+" + amt))});
                            alb.pushParams(StatData.statToName(stat));
                            replaceParams["data"] = alb;
                            this.effects.push(new Effect(val, replaceParams));
                            break;
                        case ActivationType.BOOST_RANGE:
                            break;
                    }
                }
            }
        }

        private function getSpell(_arg1:XML, _arg2:XML=null):void{
            var _local3:ComPair = new ComPair(_arg1, _arg2, "numShots", 20);
            var _local4:String = this.colorUntiered("Spell: ");
            _local4 = (_local4 + "{numShots} Shots");
            this.effects.push(new Effect(_local4, {numShots:TooltipHelper.compare(_local3.a, _local3.b)}));
        }

        private function getBulletCreate(_arg1:XML, _arg2:XML=null):void{
            var _local3:ComPair = new ComPair(_arg1, _arg2, "numShots", 3);
            var _local4:ComPair = new ComPair(_arg1, _arg2, "offsetAngle", 90);
            var _local5:ComPair = new ComPair(_arg1, _arg2, "minDistance", 0);
            var _local6:ComPair = new ComPair(_arg1, _arg2, "maxDistance", 4.4);
            var _local7:String = this.colorUntiered("Wakizashi: ");
            _local7 = (_local7 + "{numShots} shots at {angle}\n");
            if (_local5.a){
                _local7 = (_local7 + "Min Cast Range: {minDistance}\n");
            }
            _local7 = (_local7 + "Max Cast Range: {maxDistance}");
            this.effects.push(new Effect(_local7, {
                numShots:TooltipHelper.compare(_local3.a, _local3.b),
                angle:TooltipHelper.getPlural(_local4.a, "degree"),
                minDistance:TooltipHelper.compareAndGetPlural(_local5.a, _local5.b, "square", false),
                maxDistance:TooltipHelper.compareAndGetPlural(_local6.a, _local6.b, "square")
            }));
        }

        private function getSkull(_arg1:XML, _arg2:XML=null):void{
            var _local3:int = (((this.player)!=null) ? this.player.wisdom_ : 10);
            var _local4:int = this.GetIntArgument(_arg1, "wisPerRad", 10);
            var _local5:Number = this.GetFloatArgument(_arg1, "incrRad", 0.5);
            var _local6:int = this.GetIntArgument(_arg1, "wisDamageBase", 0);
            var _local7:int = this.GetIntArgument(_arg1, "wisMin", 50);
            var _local8:int = Math.max(0, (_local3 - _local7));
            var _local9:int = ((_local6 / 10) * _local8);
            var _local10:Number = MathUtil.round((int((_local8 / _local4)) * _local5), 2);
            var _local11:ComPair = new ComPair(_arg1, _arg2, "totalDamage");
            _local11.add(_local9);
            var _local12:ComPair = new ComPair(_arg1, _arg2, "radius");
            var _local13:ComPair = new ComPair(_arg1, _arg2, "healRange", 5);
            _local13.add(_local10);
            var _local14:ComPair = new ComPair(_arg1, _arg2, "heal");
            var _local15:ComPair = new ComPair(_arg1, _arg2, "ignoreDef", 0);
            var _local16:int = this.GetIntArgument(_arg1, "hitsForSelfPuri", -1);
            var _local17:int = this.GetIntArgument(_arg1, "hitsForGroupPuri", -1);
            var _local18:String = this.colorUntiered("Skull: ");
            _local18 = (_local18 + (("{damage}" + this.colorWisBonus(_local9)) + " damage\n"));
            _local18 = (_local18 + "within {radius} squares\n");
            if (_local14.a){
                _local18 = (_local18 + "Steals {heal} HP");
            }
            if (((_local14.a) && (_local15.a))){
                _local18 = (_local18 + " and ignores {ignoreDef} defense");
            }
            else {
                if (_local15.a){
                    _local18 = (_local18 + "Ignores {ignoreDef} defense");
                }
            }
            if (_local14.a){
                _local18 = (_local18 + (("\nHeals allies within {healRange}" + this.colorWisBonus(_local10)) + " squares"));
            }
            if (_local16 != -1){
                _local18 = (_local18 + "\n{hitsSelf}: Removes negative conditions on self");
            }
            if (_local16 != -1){
                _local18 = (_local18 + "\n{hitsGroup}: Removes negative conditions on group");
            }
            this.effects.push(new Effect(_local18, {
                damage:TooltipHelper.compare(_local11.a, _local11.b),
                radius:TooltipHelper.compare(_local12.a, _local12.b),
                heal:TooltipHelper.compare(_local14.a, _local14.b),
                ignoreDef:TooltipHelper.compare(_local15.a, _local15.b),
                healRange:TooltipHelper.compare(MathUtil.round(_local13.a, 2), MathUtil.round(_local13.b, 2)),
                hitsSelf:TooltipHelper.getPlural(_local16, "Hit"),
                hitsGroup:TooltipHelper.getPlural(_local17, "Hit")
            }));
            this.AddConditionToEffects(_arg1, _arg2, "Nothing", 2.5);
        }

        private function getTrap(_arg1:XML, _arg2:XML=null):void{
            var _local3:ComPair = new ComPair(_arg1, _arg2, "totalDamage");
            var _local4:ComPair = new ComPair(_arg1, _arg2, "radius");
            var _local5:ComPair = new ComPair(_arg1, _arg2, "duration", 20);
            var _local6:ComPair = new ComPair(_arg1, _arg2, "throwTime", 1);
            var _local7:ComPair = new ComPair(_arg1, _arg2, "sensitivity", 0.5);
            var _local8:Number = MathUtil.round((_local4.a * _local7.a), 2);
            var _local9:Number = MathUtil.round((_local4.b * _local7.b), 2);
            var _local10:String = this.colorUntiered("Trap: ");
            _local10 = (_local10 + "{damage} damage within {radius} squares");
            this.effects.push(new Effect(_local10, {
                damage:TooltipHelper.compare(_local3.a, _local3.b),
                radius:TooltipHelper.compare(_local4.a, _local4.b)
            }));
            this.AddConditionToEffects(_arg1, _arg2, "Slowed", 5);
            this.effects.push(new Effect("{throwTime} to arm for {duration} ", {
                throwTime:TooltipHelper.compareAndGetPlural(_local6.a, _local6.b, "second", false),
                duration:TooltipHelper.compareAndGetPlural(_local5.a, _local5.b, "second")
            }));
            this.effects.push(new Effect("Triggers within {triggerRadius} squares", {triggerRadius:TooltipHelper.compare(_local8, _local9)}));
        }

        private function getLightning(_arg1:XML, _arg2:XML=null):void{
            var _local15:String;
            var _local3:int = (((this.player)!=null) ? this.player.wisdom_ : 10);
            var _local4:ComPair = new ComPair(_arg1, _arg2, "decrDamage", 0);
            var _local5:int = this.GetIntArgument(_arg1, "wisPerTarget", 10);
            var _local6:int = this.GetIntArgument(_arg1, "wisDamageBase", _local4.a);
            var _local7:int = this.GetIntArgument(_arg1, "wisMin", 50);
            var _local8:int = Math.max(0, (_local3 - _local7));
            var _local9:int = (_local8 / _local5);
            var _local10:int = ((_local6 / 10) * _local8);
            var _local11:ComPair = new ComPair(_arg1, _arg2, "maxTargets");
            _local11.add(_local9);
            var _local12:ComPair = new ComPair(_arg1, _arg2, "totalDamage");
            _local12.add(_local10);
            var _local13:String = this.colorUntiered("Lightning: ");
            _local13 = (_local13 + (("{targets}" + this.colorWisBonus(_local9)) + " targets\n"));
            _local13 = (_local13 + (("{damage}" + this.colorWisBonus(_local10)) + " damage"));
            var _local14:Boolean;
            if (_local4.a){
                if (_local4.a < 0){
                    _local14 = true;
                }
                _local15 = "reduced";
                if (_local14){
                    _local15 = TooltipHelper.wrapInFontTag("increased", ("#" + TooltipHelper.NO_DIFF_COLOR.toString(16)));
                }
                _local13 = (_local13 + ((", " + _local15) + " by \n{decrDamage} for each subsequent target"));
            }
            this.effects.push(new Effect(_local13, {
                targets:TooltipHelper.compare(_local11.a, _local11.b),
                damage:TooltipHelper.compare(_local12.a, _local12.b),
                decrDamage:TooltipHelper.compare(_local4.a, _local4.b, false, "", _local14)
            }));
            this.AddConditionToEffects(_arg1, _arg2, "Nothing", 5);
        }

        private function getDecoy(_arg1:XML, _arg2:XML=null):void{
            var _local3:ComPair = new ComPair(_arg1, _arg2, "duration");
            var _local4:ComPair = new ComPair(_arg1, _arg2, "angleOffset", 0);
            var _local5:ComPair = new ComPair(_arg1, _arg2, "speed", 1);
            var _local6:ComPair = new ComPair(_arg1, _arg2, "distance", 8);
            var _local7:Number = MathUtil.round((_local6.a / (_local5.a * 5)), 2);
            var _local8:Number = MathUtil.round((_local6.b / (_local5.b * 5)), 2);
            var _local9:ComPair = new ComPair(_arg1, _arg2, "numShots", 0);
            var _local10:String = this.colorUntiered("Decoy: ");
            _local10 = (_local10 + "{duration}");
            if (_local4.a){
                _local10 = (_local10 + " at {angleOffset}");
            }
            _local10 = (_local10 + "\n");
            if (_local5.a == 0){
                _local10 = (_local10 + "Decoy does not move");
            }
            else {
                _local10 = (_local10 + "{distance} in {travelTime}");
            }
            if (_local9.a){
                _local10 = (_local10 + "\nShots: {numShots}");
            }
            this.effects.push(new Effect(_local10, {
                duration:TooltipHelper.compareAndGetPlural(_local3.a, _local3.b, "second"),
                angleOffset:TooltipHelper.compareAndGetPlural(_local4.a, _local4.b, "degree"),
                distance:TooltipHelper.compareAndGetPlural(_local6.a, _local6.b, "square"),
                travelTime:TooltipHelper.compareAndGetPlural(_local7, _local8, "second"),
                numShots:TooltipHelper.compare(_local9.a, _local9.b)
            }));
        }

        private function getPoison(_arg1:XML, _arg2:XML=null):void{
            var _local3:ComPair = new ComPair(_arg1, _arg2, "totalDamage");
            var _local4:ComPair = new ComPair(_arg1, _arg2, "radius");
            var _local5:ComPair = new ComPair(_arg1, _arg2, "duration");
            var _local6:ComPair = new ComPair(_arg1, _arg2, "throwTime", 1);
            var _local7:ComPair = new ComPair(_arg1, _arg2, "impactDamage", 0);
            var _local8:Number = (_local3.a - _local7.a);
            var _local9:Number = (_local3.b - _local7.b);
            var _local10:String = this.colorUntiered("Poison: ");
            _local10 = (_local10 + "{totalDamage} damage");
            if (_local7.a){
                _local10 = (_local10 + " ({impactDamage} on impact)");
            }
            _local10 = (_local10 + " within {radius}");
            _local10 = (_local10 + " over {duration}");
            this.effects.push(new Effect(_local10, {
                totalDamage:TooltipHelper.compare(_local3.a, _local3.b, true, "", false, !(this.sameActivateEffect)),
                radius:TooltipHelper.compareAndGetPlural(_local4.a, _local4.b, "square", true, !(this.sameActivateEffect)),
                impactDamage:TooltipHelper.compare(_local7.a, _local7.b, true, "", false, !(this.sameActivateEffect)),
                duration:TooltipHelper.compareAndGetPlural(_local5.a, _local5.b, "second", false, !(this.sameActivateEffect))
            }));
            this.AddConditionToEffects(_arg1, _arg2, "Nothing", 5);
            this.sameActivateEffect = true;
        }

        private function AddConditionToEffects(_arg1:XML, _arg2:XML, _arg3:String="Nothing", _arg4:Number=5):void{
            var _local6:ComPair;
            var _local7:String;
            var _local5:String = ((_arg1.hasOwnProperty("@condEffect")) ? _arg1.@condEffect : _arg3);
            if (_local5 != "Nothing"){
                _local6 = new ComPair(_arg1, _arg2, "condDuration", _arg4);
                if (_arg2){
                    _local7 = ((_arg2.hasOwnProperty("@condEffect")) ? _arg2.@condEffect : _arg3);
                    if (_local7 == "Nothing"){
                        _local6.b = 0;
                    }
                }
                this.effects.push(new Effect("Inflicts {condition} for {duration} ", {
                    condition:_local5,
                    duration:TooltipHelper.compareAndGetPlural(_local6.a, _local6.b, "second")
                }));
            }
        }

        private function GetIntArgument(_arg1:XML, _arg2:String, _arg3:int=0):int{
            return (((_arg1.hasOwnProperty(("@" + _arg2))) ? _arg1.@[_arg2] : _arg3));
        }

        private function GetFloatArgument(_arg1:XML, _arg2:String, _arg3:Number=0):Number{
            return (((_arg1.hasOwnProperty(("@" + _arg2))) ? _arg1.@[_arg2] : _arg3));
        }

        private function GetStringArgument(_arg1:XML, _arg2:String, _arg3:String=""):String{
            return (((_arg1.hasOwnProperty(("@" + _arg2))) ? _arg1.@[_arg2] : _arg3));
        }

        private function colorWisBonus(_arg1:Number):String{
            if (_arg1){
                return (TooltipHelper.wrapInFontTag(((" (+" + _arg1) + ")"), ("#" + TooltipHelper.WIS_BONUS_COLOR.toString(16))));
            }
            return ("");
        }

        private function colorUntiered(_arg1:String):String{
            var _local2:Boolean = this.objectXML.hasOwnProperty("Tier");
            var _local3:Boolean = this.objectXML.hasOwnProperty("@setType");
            if (_local3){
                return (TooltipHelper.wrapInFontTag(_arg1, ("#" + TooltipHelper.SET_COLOR.toString(16))));
            }
            if (!_local2){
                return (TooltipHelper.wrapInFontTag(_arg1, ("#" + TooltipHelper.UNTIERED_COLOR.toString(16))));
            }
            return (_arg1);
        }

        private function getEffectTag(_arg1:XML, _arg2:String):XML{
            var matches:XMLList;
            var tag:XML;
            var xml:XML = _arg1;
            var effectValue:String = _arg2;
            matches = xml.Activate.(text() == ActivationType.GENERIC_ACTIVATE);
            for each (tag in matches) {
                if (tag.@effect == effectValue){
                    return (tag);
                }
            }
            return (null);
        }

        private function getStatTag(_arg1:XML, _arg2:String):XML{
            var matches:XMLList;
            var tag:XML;
            var xml:XML = _arg1;
            var statValue:String = _arg2;
            matches = xml.Activate.(text() == ActivationType.STAT_BOOST_AURA);
            for each (tag in matches) {
                if (tag.@stat == statValue){
                    return (tag);
                }
            }
            return (null);
        }

        private function addActivateOnEquipTagsToEffectsList():void{
            var _local1:XML;
            var _local2:Boolean = true;
            for each (_local1 in this.objectXML.ActivateOnEquip) {
                if (_local2){
                    this.effects.push(new Effect(TextKey.ON_EQUIP, ""));
                    _local2 = false;
                }
                if (_local1.toString() == "IncrementStat"){
                    this.effects.push(new Effect(TextKey.INCREMENT_STAT, this.getComparedStatText(_local1)).setReplacementsColor(this.getComparedStatColor(_local1)));
                }
            }
        }

        private function getComparedStatText(_arg1:XML):Object{
            var _local2:int = int(_arg1.@stat);
            var _local3:int = int(_arg1.@amount);
            return ({
                statAmount:(this.prefix(_local3) + " "),
                statName:new LineBuilder().setParams(StatData.statToName(_local2))
            });
        }

        private function prefix(_arg1:int):String{
            var _local2:String = (((_arg1)>-1) ? "+" : "");
            return ((_local2 + _arg1));
        }

        private function getComparedStatColor(_arg1:XML):uint{
            var match:XML;
            var otherAmount:int;
            var activateXML:XML = _arg1;
            var stat:int = int(activateXML.@stat);
            var amount:int = int(activateXML.@amount);
            var textColor:uint = ((this.playerCanUse) ? TooltipHelper.BETTER_COLOR : TooltipHelper.NO_DIFF_COLOR);
            var otherMatches:XMLList;
            if (this.curItemXML != null){
                otherMatches = this.curItemXML.ActivateOnEquip.(@stat == stat);
            }
            if (((!((otherMatches == null))) && ((otherMatches.length() == 1)))){
                match = XML(otherMatches[0]);
                otherAmount = int(match.@amount);
                textColor = TooltipHelper.getTextColor((amount - otherAmount));
            }
            if (amount < 0){
                textColor = 0xFF0000;
            }
            return (textColor);
        }

        private function addEquipmentItemRestrictions():void{
            if (this.objectXML.hasOwnProperty("PetFood")){
                this.restrictions.push(new Restriction("Used to feed your pet in the pet yard", 0xB3B3B3, false));
            }
            else {
                if (this.objectXML.hasOwnProperty("Treasure") == false){
                    this.restrictions.push(new Restriction(TextKey.EQUIP_TO_USE, 0xB3B3B3, false));
                    if (((this.isInventoryFull) || ((this.inventoryOwnerType == InventoryOwnerTypes.CURRENT_PLAYER)))){
                        this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_EQUIP, 0xB3B3B3, false));
                    }
                    else {
                        this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_TAKE, 0xB3B3B3, false));
                    }
                }
            }
        }

        private function addAbilityItemRestrictions():void{
            this.restrictions.push(new Restriction(TextKey.KEYCODE_TO_USE, 0xFFFFFF, false));
        }

        private function addConsumableItemRestrictions():void{
            this.restrictions.push(new Restriction(TextKey.CONSUMED_WITH_USE, 0xB3B3B3, false));
            if (((this.isInventoryFull) || ((this.inventoryOwnerType == InventoryOwnerTypes.CURRENT_PLAYER)))){
                this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_OR_SHIFT_CLICK_TO_USE, 0xFFFFFF, false));
            }
            else {
                this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_TAKE_SHIFT_CLICK_USE, 0xFFFFFF, false));
            }
        }

        private function addReusableItemRestrictions():void{
            this.restrictions.push(new Restriction(TextKey.CAN_BE_USED_MULTIPLE_TIMES, 0xB3B3B3, false));
            this.restrictions.push(new Restriction(TextKey.DOUBLE_CLICK_OR_SHIFT_CLICK_TO_USE, 0xFFFFFF, false));
        }

        private function makeRestrictionList():void{
            var _local2:XML;
            var _local3:Boolean;
            var _local4:int;
            var _local5:int;
            this.restrictions = new Vector.<Restriction>();
            if (((((this.objectXML.hasOwnProperty("VaultItem")) && (!((this.invType == -1))))) && (!((this.invType == ObjectLibrary.idToType_["Vault Chest"]))))){
                this.restrictions.push(new Restriction(TextKey.STORE_IN_VAULT, 16549442, true));
            }
            if (this.objectXML.hasOwnProperty("Soulbound")){
                this.restrictions.push(new Restriction(TextKey.ITEM_SOULBOUND, 0xB3B3B3, false));
            }
            if (this.playerCanUse){
                if (this.objectXML.hasOwnProperty("Usable")){
                    this.addAbilityItemRestrictions();
                    this.addEquipmentItemRestrictions();
                }
                else {
                    if (this.objectXML.hasOwnProperty("Consumable")){
                        if (this.objectXML.hasOwnProperty("Potion")){
                            this.restrictions.push(new Restriction("Potion", 0xB3B3B3, false));
                        }
                        this.addConsumableItemRestrictions();
                    }
                    else {
                        if (this.objectXML.hasOwnProperty("InvUse")){
                            this.addReusableItemRestrictions();
                        }
                        else {
                            this.addEquipmentItemRestrictions();
                        }
                    }
                }
            }
            else {
                if (this.player != null){
                    this.restrictions.push(new Restriction(TextKey.NOT_USABLE_BY, 16549442, true));
                }
            }
            var _local1:Vector.<String> = ObjectLibrary.usableBy(this.objectType);
            if (_local1 != null){
                this.restrictions.push(new Restriction(TextKey.USABLE_BY, 0xB3B3B3, false));
            }
            for each (_local2 in this.objectXML.EquipRequirement) {
                _local3 = ObjectLibrary.playerMeetsRequirement(_local2, this.player);
                if (_local2.toString() == "Stat"){
                    _local4 = int(_local2.@stat);
                    _local5 = int(_local2.@value);
                    this.restrictions.push(new Restriction(((("Requires " + StatData.statToName(_local4)) + " of ") + _local5), ((_local3) ? 0xB3B3B3 : 16549442), ((_local3) ? false : true)));
                }
            }
        }

        private function makeLineTwo():void{
            this.line2 = new LineBreakDesign((MAX_WIDTH - 12), 0);
            addChild(this.line2);
        }

        private function makeLineThree():void{
            this.line3 = new LineBreakDesign((MAX_WIDTH - 12), 0);
            addChild(this.line3);
        }

        private function makeRestrictionText():void{
            if (this.restrictions.length != 0){
                this.restrictionsText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth((MAX_WIDTH - 4)).setIndent(-10).setLeftMargin(10).setWordWrap(true).setHTML(true);
                this.restrictionsText.setStringBuilder(this.buildRestrictionsLineBuilder());
                this.restrictionsText.filters = FilterUtil.getStandardDropShadowFilter();
                waiter.push(this.restrictionsText.textChanged);
                addChild(this.restrictionsText);
            }
        }

        private function makeSetInfoText():void{
            if (this.setInfo.length != 0){
                this.setInfoText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth((MAX_WIDTH - 4)).setIndent(-10).setLeftMargin(10).setWordWrap(true).setHTML(true);
                this.setInfoText.setStringBuilder(this.getSetBonusStringBuilder());
                this.setInfoText.filters = FilterUtil.getStandardDropShadowFilter();
                waiter.push(this.setInfoText.textChanged);
                addChild(this.setInfoText);
                this.makeLineThree();
            }
        }

        private function getSetBonusStringBuilder():AppendingLineBuilder{
            var _local1:AppendingLineBuilder = new AppendingLineBuilder();
            this.appendEffects(this.setInfo, _local1);
            return (_local1);
        }

        private function buildRestrictionsLineBuilder():StringBuilder{
            var _local2:Restriction;
            var _local3:String;
            var _local4:String;
            var _local5:String;
            var _local1:AppendingLineBuilder = new AppendingLineBuilder();
            for each (_local2 in this.restrictions) {
                _local3 = ((_local2.bold_) ? "<b>" : "");
                _local3 = _local3.concat((('<font color="#' + _local2.color_.toString(16)) + '">'));
                _local4 = "</font>";
                _local4 = _local4.concat(((_local2.bold_) ? "</b>" : ""));
                _local5 = ((this.player) ? ObjectLibrary.typeToDisplayId_[this.player.objectType_] : "");
                _local1.pushParams(_local2.text_, {
                    unUsableClass:_local5,
                    usableClasses:this.getUsableClasses(),
                    keyCode:KeyCodes.CharCodeStrings[Parameters.data_.useSpecial]
                }, _local3, _local4);
            }
            return (_local1);
        }

        private function getUsableClasses():StringBuilder{
            var _local3:String;
            var _local1:Vector.<String> = ObjectLibrary.usableBy(this.objectType);
            var _local2:AppendingLineBuilder = new AppendingLineBuilder();
            _local2.setDelimiter(", ");
            for each (_local3 in _local1) {
                _local2.pushParams(_local3);
            }
            return (_local2);
        }

        private function addDescriptionText():void{
            this.descText = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3).setTextWidth(MAX_WIDTH).setWordWrap(true);
            if (this.descriptionOverride){
                this.descText.setStringBuilder(new StaticStringBuilder(this.descriptionOverride));
            }
            else {
                if (((((ObjectLibrary.usePatchedData) && (this.objectPatchXML))) && (this.objectPatchXML.hasOwnProperty("Description")))){
                    this.descText.setStringBuilder(new LineBuilder().setParams(String(this.objectPatchXML.Description)));
                }
                else {
                    this.descText.setStringBuilder(new LineBuilder().setParams(String(this.objectXML.Description)));
                }
            }
            this.descText.filters = FilterUtil.getStandardDropShadowFilter();
            waiter.push(this.descText.textChanged);
            addChild(this.descText);
        }

        override protected function alignUI():void{
            this.titleText.x = (this.icon.width + 4);
            this.titleText.y = ((this.icon.height / 2) - (this.titleText.height / 2));
            if (this.tierText){
                this.tierText.y = ((this.icon.height / 2) - (this.tierText.height / 2));
                this.tierText.x = (MAX_WIDTH - 30);
            }
            this.descText.x = 4;
            this.descText.y = (this.icon.height + 2);
            if (contains(this.line1)){
                this.line1.x = 8;
                this.line1.y = ((this.descText.y + this.descText.height) + 8);
                this.effectsText.x = 4;
                this.effectsText.y = (this.line1.y + 8);
            }
            else {
                this.line1.y = (this.descText.y + this.descText.height);
                this.effectsText.y = this.line1.y;
            }
            if (this.setInfoText){
                this.line3.x = 8;
                this.line3.y = ((this.effectsText.y + this.effectsText.height) + 8);
                this.setInfoText.x = 4;
                this.setInfoText.y = (this.line3.y + 8);
                this.line2.x = 8;
                this.line2.y = ((this.setInfoText.y + this.setInfoText.height) + 8);
            }
            else {
                this.line2.x = 8;
                this.line2.y = ((this.effectsText.y + this.effectsText.height) + 8);
            }
            var _local1:uint = (this.line2.y + 8);
            if (this.restrictionsText){
                this.restrictionsText.x = 4;
                this.restrictionsText.y = _local1;
                _local1 = (_local1 + this.restrictionsText.height);
            }
            if (this.powerText){
                if (contains(this.powerText)){
                    this.powerText.x = 4;
                    this.powerText.y = _local1;
                    _local1 = (_local1 + this.powerText.height);
                }
            }
            if (this.supporterPointsText){
                if (contains(this.supporterPointsText)){
                    this.supporterPointsText.x = 4;
                    this.supporterPointsText.y = _local1;
                }
            }
        }

        private function buildCategorySpecificText():void{
            if (this.curItemXML != null){
                this.comparisonResults = this.slotTypeToTextBuilder.getComparisonResults(this.objectXML, this.curItemXML);
            }
            else {
                this.comparisonResults = new SlotComparisonResult();
            }
        }

        private function handleWisMod():void{
            var _local3:XML;
            var _local4:XML;
            var _local5:String;
            var _local6:String;
            if (this.player == null){
                return;
            }
            var _local1:Number = this.player.wisdom_;
            if (_local1 < 30){
                return;
            }
            var _local2:Vector.<XML> = new Vector.<XML>();
            if (this.curItemXML != null){
                this.curItemXML = this.curItemXML.copy();
                _local2.push(this.curItemXML);
            }
            if (this.objectXML != null){
                this.objectXML = this.objectXML.copy();
                _local2.push(this.objectXML);
            }
            for each (_local4 in _local2) {
                for each (_local3 in _local4.Activate) {
                    _local5 = _local3.toString();
                    if (_local3.@effect != "Stasis"){
                        _local6 = _local3.@useWisMod;
                        if (!(((((((_local6 == "")) || ((_local6 == "false")))) || ((_local6 == "0")))) || ((_local3.@effect == "Stasis")))){
                            switch (_local5){
                                case ActivationType.HEAL_NOVA:
                                    _local3.@amount = this.modifyWisModStat(_local3.@amount, 0);
                                    _local3.@range = this.modifyWisModStat(_local3.@range);
                                    _local3.@damage = this.modifyWisModStat(_local3.@damage, 0);
                                    break;
                                case ActivationType.COND_EFFECT_AURA:
                                    _local3.@duration = this.modifyWisModStat(_local3.@duration);
                                    _local3.@range = this.modifyWisModStat(_local3.@range);
                                    break;
                                case ActivationType.COND_EFFECT_SELF:
                                    _local3.@duration = this.modifyWisModStat(_local3.@duration);
                                    break;
                                case ActivationType.STAT_BOOST_AURA:
                                    _local3.@amount = this.modifyWisModStat(_local3.@amount, 0);
                                    _local3.@duration = this.modifyWisModStat(_local3.@duration);
                                    _local3.@range = this.modifyWisModStat(_local3.@range);
                                    break;
                                case ActivationType.GENERIC_ACTIVATE:
                                    _local3.@duration = this.modifyWisModStat(_local3.@duration);
                                    _local3.@range = this.modifyWisModStat(_local3.@range);
                                    break;
                            }
                        }
                    }
                }
            }
        }

        private function modifyWisModStat(_arg1:String, _arg2:Number=1):String{
            var _local5:Number;
            var _local6:int;
            var _local7:Number;
            var _local3 = "-1";
            var _local4:Number = this.player.wisdom_;
            if (_local4 < 30){
                _local3 = _arg1;
            }
            else {
                _local5 = Number(_arg1);
                _local6 = (((_local5)<0) ? -1 : 1);
                _local7 = (((_local5 * _local4) / 150) + (_local5 * _local6));
                _local7 = (Math.floor((_local7 * Math.pow(10, _arg2))) / Math.pow(10, _arg2));
                if ((_local7 - (int(_local7) * _local6)) >= ((1 / Math.pow(10, _arg2)) * _local6)){
                    _local3 = _local7.toFixed(1);
                }
                else {
                    _local3 = _local7.toFixed(0);
                }
            }
            return (_local3);
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

class ComPair {

    public var a:Number;
    public var b:Number;

    public function ComPair(_arg1:XML, _arg2:XML, _arg3:String, _arg4:Number=0){
        this.a = (this.b = ((_arg1.hasOwnProperty(("@" + _arg3))) ? _arg1.@[_arg3] : _arg4));
        if (_arg2){
            this.b = ((_arg2.hasOwnProperty(("@" + _arg3))) ? _arg2.@[_arg3] : _arg4);
        }
    }

    public function add(_arg1:Number):void{
        this.a = (this.a + _arg1);
        this.b = (this.b + _arg1);
    }


}
class ComPairTag {

    public var a:Number;
    public var b:Number;

    public function ComPairTag(_arg1:XML, _arg2:XML, _arg3:String, _arg4:Number=0){
        this.a = (this.b = ((_arg1.hasOwnProperty(_arg3)) ? _arg1[_arg3] : _arg4));
        if (_arg2){
            this.b = ((_arg2.hasOwnProperty(_arg3)) ? _arg2[_arg3] : _arg4);
        }
    }

    public function add(_arg1:Number):void{
        this.a = (this.a + _arg1);
        this.b = (this.b + _arg1);
    }


}
class ComPairTagBool {

    public var a:Boolean;
    public var b:Boolean;

    public function ComPairTagBool(_arg1:XML, _arg2:XML, _arg3:String, _arg4:Boolean=false){
        this.a = (this.b = ((_arg1.hasOwnProperty(_arg3)) ? true : _arg4));
        if (_arg2){
            this.b = ((_arg2.hasOwnProperty(_arg3)) ? true : _arg4);
        }
    }

}
class Effect {

    public var name_:String;
    public var valueReplacements_:Object;
    public var replacementColor_:uint = 16777103;
    public var color_:uint = 0xB3B3B3;

    public function Effect(_arg1:String, _arg2:Object){
        this.name_ = _arg1;
        this.valueReplacements_ = _arg2;
    }

    public function setColor(_arg1:uint):Effect{
        this.color_ = _arg1;
        return (this);
    }

    public function setReplacementsColor(_arg1:uint):Effect{
        this.replacementColor_ = _arg1;
        return (this);
    }

    public function getValueReplacementsWithColor():Object{
        var _local4:String;
        var _local5:LineBuilder;
        var _local1:Object = {};
        var _local2 = "";
        var _local3 = "";
        if (this.replacementColor_){
            _local2 = (('</font><font color="#' + this.replacementColor_.toString(16)) + '">');
            _local3 = (('</font><font color="#' + this.color_.toString(16)) + '">');
        }
        for (_local4 in this.valueReplacements_) {
            if ((this.valueReplacements_[_local4] is AppendingLineBuilder)){
                _local1[_local4] = this.valueReplacements_[_local4];
            }
            else {
                if ((this.valueReplacements_[_local4] is LineBuilder)){
                    _local5 = (this.valueReplacements_[_local4] as LineBuilder);
                    _local5.setPrefix(_local2).setPostfix(_local3);
                    _local1[_local4] = _local5;
                }
                else {
                    _local1[_local4] = ((_local2 + this.valueReplacements_[_local4]) + _local3);
                }
            }
        }
        return (_local1);
    }


}
class Restriction {

    public var text_:String;
    public var color_:uint;
    public var bold_:Boolean;

    public function Restriction(_arg1:String, _arg2:uint, _arg3:Boolean){
        this.text_ = _arg1;
        this.color_ = _arg2;
        this.bold_ = _arg3;
    }

}

