// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.map.partyoverlay.QuestArrow

package com.company.assembleegameclient.map.partyoverlay{
    import com.greensock.TimelineMax;
    import kabam.rotmg.game.model.QuestModel;
    import kabam.rotmg.core.StaticInjectorContext;
    import com.company.assembleegameclient.map.Map;
    import flash.utils.getTimer;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.ui.tooltip.QuestToolTip;
    import com.company.assembleegameclient.parameters.Parameters;
    import com.company.assembleegameclient.ui.tooltip.PortraitToolTip;
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import com.company.assembleegameclient.map.Quest;
    import com.company.assembleegameclient.objects.Character;
    import com.greensock.TweenMax;
    import com.greensock.easing.Expo;
    import com.company.assembleegameclient.map.Camera;

    public class QuestArrow extends GameObjectArrow {

        private var questArrowTween:TimelineMax;
        private var questModel:QuestModel;

        public function QuestArrow(_arg1:Map){
            super(16352321, 12919330, true);
            map_ = _arg1;
            this.questModel = StaticInjectorContext.getInjector().getInstance(QuestModel);
        }

        public function refreshToolTip():void{
            if (this.questArrowTween.isActive()){
                this.questArrowTween.pause(0);
                this.scaleX = 1;
                this.scaleY = 1;
            };
            setToolTip(this.getToolTip(go_, getTimer()));
        }

        override protected function onMouseOver(_arg1:MouseEvent):void{
            super.onMouseOver(_arg1);
            this.refreshToolTip();
        }

        override protected function onMouseOut(_arg1:MouseEvent):void{
            super.onMouseOut(_arg1);
            this.refreshToolTip();
        }

        private function getToolTip(_arg1:GameObject, _arg2:int):ToolTip{
            if ((((_arg1 == null)) || ((_arg1.texture_ == null)))){
                return (null);
            };
            if (this.shouldShowFullQuest(_arg2)){
                return (new QuestToolTip(go_));
            };
            if (Parameters.data_.showQuestPortraits){
                return (new PortraitToolTip(_arg1));
            };
            return (null);
        }

        private function shouldShowFullQuest(_arg1:int):Boolean{
            var _local2:Quest = map_.quest_;
            return (((mouseOver_) || (_local2.isNew(_arg1))));
        }

        override public function draw(_arg1:int, _arg2:Camera):void{
            var _local4:Character;
            var _local5:String;
            var _local6:Boolean;
            var _local7:Boolean;
            var _local3:GameObject = map_.quest_.getObject(_arg1);
            if (((_local3) && ((_local3 is Character)))){
                _local4 = (_local3 as Character);
                _local5 = _local4.getName();
                if (_local5 != this.questModel.currentQuestHero){
                    this.questModel.currentQuestHero = _local5;
                };
            };
            if (_local3 != go_){
                setGameObject(_local3);
                setToolTip(this.getToolTip(_local3, _arg1));
                if (!this.questArrowTween){
                    this.questArrowTween = new TimelineMax();
                    this.questArrowTween.add(TweenMax.to(this, 0.15, {
                        scaleX:1.6,
                        scaleY:1.6
                    }));
                    this.questArrowTween.add(TweenMax.to(this, 0.05, {
                        scaleX:1.8,
                        scaleY:1.8
                    }));
                    this.questArrowTween.add(TweenMax.to(this, 0.3, {
                        scaleX:1,
                        scaleY:1,
                        ease:Expo.easeOut
                    }));
                }
                else {
                    this.questArrowTween.play(0);
                };
            }
            else {
                if (go_ != null){
                    _local6 = (tooltip_ is QuestToolTip);
                    _local7 = this.shouldShowFullQuest(_arg1);
                    if (_local6 != _local7){
                        setToolTip(this.getToolTip(_local3, _arg1));
                    };
                };
            };
            super.draw(_arg1, _arg2);
        }


    }
}//package com.company.assembleegameclient.map.partyoverlay

