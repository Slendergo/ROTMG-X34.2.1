// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.screens.charrects.CharacterRectList

package com.company.assembleegameclient.screens.charrects{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.assets.services.CharacterFactory;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import kabam.rotmg.classes.model.CharacterClass;
    import com.company.assembleegameclient.appengine.CharacterStats;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.core.StaticInjectorContext;
    import org.swiftsuspenders.Injector;
    import kabam.rotmg.classes.model.CharacterSkin;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.events.Event;

    public class CharacterRectList extends Sprite {

        public var newCharacter:Signal;
        public var buyCharacterSlot:Signal;
        private var classes:ClassesModel;
        private var model:PlayerModel;
        private var assetFactory:CharacterFactory;
        private var yOffset:int;
        private var accountName:String;
        private var numberOfSavedCharacters:int;

        public function CharacterRectList(){
            this.init();
        }

        private function init():void{
            var _local1:String;
            this.createInjections();
            this.createSignals();
            this.accountName = this.model.getName();
            this.yOffset = 4;
            this.createSavedCharacters();
            this.createAvailableCharSlots();
            this.createBuyRect();
        }

        private function createAvailableCharSlots():void{
            var _local2:int;
            var _local3:CreateNewCharacterRect;
            if (this.model.hasAvailableCharSlot()){
                _local2 = 0;
                while (_local2 < this.model.getAvailableCharSlots()) {
                    _local3 = new CreateNewCharacterRect(this.model);
                    _local3.addEventListener(MouseEvent.MOUSE_DOWN, this.onNewChar);
                    _local3.y = this.yOffset;
                    addChild(_local3);
                    this.yOffset = (this.yOffset + (CharacterRect.HEIGHT + 4));
                    _local2++;
                }
            }
        }

        private function createSavedCharacters():void{
            var _local2:SavedCharacter;
            var _local3:CharacterClass;
            var _local4:CharacterStats;
            var _local5:CurrentCharacterRect;
            var _local1:Vector.<SavedCharacter> = this.model.getSavedCharacters();
            this.numberOfSavedCharacters = _local1.length;
            for each (_local2 in _local1) {
                _local3 = this.classes.getCharacterClass(_local2.objectType());
                _local4 = this.model.getCharStats()[_local2.objectType()];
                _local5 = new CurrentCharacterRect(this.accountName, _local3, _local2, _local4);
                if (Parameters.skinTypes16.indexOf(_local2.skinType()) != -1){
                    _local5.setIcon(this.getIcon(_local2, 50));
                }
                else {
                    _local5.setIcon(this.getIcon(_local2, 100));
                }
                _local5.y = this.yOffset;
                addChild(_local5);
                this.yOffset = (this.yOffset + (CharacterRect.HEIGHT + 4));
            }
        }

        private function createSignals():void{
            this.newCharacter = new Signal();
            this.buyCharacterSlot = new Signal();
        }

        private function createInjections():void{
            var _local1:Injector = StaticInjectorContext.getInjector();
            this.classes = _local1.getInstance(ClassesModel);
            this.model = _local1.getInstance(PlayerModel);
            this.assetFactory = _local1.getInstance(CharacterFactory);
        }

        private function createBuyRect():void{
            var _local1:BuyCharacterRect = new BuyCharacterRect(this.model);
            _local1.addEventListener(MouseEvent.MOUSE_DOWN, this.onBuyCharSlot);
            _local1.y = this.yOffset;
            addChild(_local1);
        }

        private function getIcon(_arg1:SavedCharacter, _arg2:int=100):DisplayObject{
            var _local3:CharacterClass = this.classes.getCharacterClass(_arg1.objectType());
            var _local4:CharacterSkin = ((_local3.skins.getSkin(_arg1.skinType())) || (_local3.skins.getDefaultSkin()));
            var _local5:BitmapData = this.assetFactory.makeIcon(_local4.template, _arg2, _arg1.tex1(), _arg1.tex2());
            return (new Bitmap(_local5));
        }

        private function onNewChar(_arg1:Event):void{
            this.newCharacter.dispatch();
        }

        private function onBuyCharSlot(_arg1:Event):void{
            this.buyCharacterSlot.dispatch(this.model.getNextCharSlotPrice());
        }


    }
}//package com.company.assembleegameclient.screens.charrects

