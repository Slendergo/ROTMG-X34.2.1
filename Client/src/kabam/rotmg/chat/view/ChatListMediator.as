﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.chat.view.ChatListMediator

package kabam.rotmg.chat.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.chat.model.ChatModel;
    import kabam.rotmg.chat.control.ShowChatInputSignal;
    import kabam.rotmg.chat.control.ScrollListSignal;
    import kabam.rotmg.chat.control.AddChatSignal;
    import kabam.rotmg.application.api.ApplicationSetup;
    import kabam.rotmg.chat.model.ChatMessage;
    import com.company.assembleegameclient.parameters.Parameters;

    public class ChatListMediator extends Mediator {

        [Inject]
        public var view:ChatList;
        [Inject]
        public var model:ChatModel;
        [Inject]
        public var showChatInput:ShowChatInputSignal;
        [Inject]
        public var scrollList:ScrollListSignal;
        [Inject]
        public var addChat:AddChatSignal;
        [Inject]
        public var itemFactory:ChatListItemFactory;
        [Inject]
        public var setup:ApplicationSetup;


        override public function initialize():void{
            var _local1:ChatMessage;
            this.view.setup(this.model);
            for each (_local1 in this.model.chatMessages) {
                this.view.addMessage(this.itemFactory.make(_local1, true));
            };
            this.view.scrollToCurrent();
            this.showChatInput.add(this.onShowChatInput);
            this.scrollList.add(this.onScrollList);
            this.addChat.add(this.onAddChat);
            this.onAddChat(ChatMessage.make(Parameters.CLIENT_CHAT_NAME, this.getChatLabel()));
        }

        override public function destroy():void{
            this.showChatInput.remove(this.onShowChatInput);
            this.scrollList.remove(this.onScrollList);
            this.addChat.remove(this.onAddChat);
        }

        private function onShowChatInput(_arg1:Boolean, _arg2:String):void{
            this.view.y = (this.model.bounds.height - ((_arg1) ? this.model.lineHeight : 0));
        }

        private function onScrollList(_arg1:int):void{
            if (_arg1 > 0){
                this.view.pageDown();
            }
            else {
                if (_arg1 < 0){
                    this.view.pageUp();
                };
            };
        }

        private function onAddChat(_arg1:ChatMessage):void{
            this.view.addMessage(this.itemFactory.make(_arg1));
        }

        private function getChatLabel():String{
            var _local1:String = this.setup.getBuildLabel();
            _local1 = _local1.replace(/<font .+>(.+)<\/font>/g, "$1");
            return (_local1);
        }


    }
}//package kabam.rotmg.chat.view

