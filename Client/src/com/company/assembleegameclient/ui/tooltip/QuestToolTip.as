// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.ui.tooltip.QuestToolTip

package com.company.assembleegameclient.ui.tooltip{
    import com.company.assembleegameclient.objects.GameObject;
    import com.company.assembleegameclient.ui.GameObjectListItem;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.filters.DropShadowFilter;

    public class QuestToolTip extends ToolTip {

        private var gameObject:GameObject;
        public var enemyGOLI_:GameObjectListItem;

        public function QuestToolTip(_arg1:GameObject){
            super(6036765, 1, 16549442, 1, false);
            this.gameObject = _arg1;
            this.init();
        }

        private function init():void{
            var _local1:TextFieldDisplayConcrete;
            _local1 = new TextFieldDisplayConcrete().setSize(22).setColor(16549442).setBold(true);
            _local1.setStringBuilder(new LineBuilder().setParams("Bounty!"));
            _local1.filters = [new DropShadowFilter(0, 0, 0)];
            _local1.x = 0;
            _local1.y = 0;
            waiter.push(_local1.textChanged);
            addChild(_local1);
            this.enemyGOLI_ = new GameObjectListItem(0xFFFFFF, true, this.gameObject);
            this.enemyGOLI_.x = 0;
            this.enemyGOLI_.y = 32;
            waiter.push(this.enemyGOLI_.textReady);
            addChild(this.enemyGOLI_);
            filters = [];
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

