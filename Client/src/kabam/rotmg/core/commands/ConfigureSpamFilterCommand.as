// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.core.commands.ConfigureSpamFilterCommand

package kabam.rotmg.core.commands{
import kabam.lib.console.signals.ConsoleLogSignal;

import robotlegs.bender.bundles.mvcs.Command;
    import kabam.rotmg.chat.control.SpamFilter;

    public class ConfigureSpamFilterCommand extends Command {

        [Inject]
        public var data:XML;
        [Inject]
        public var spamFilter:SpamFilter;
        [Inject]
        public var log:ConsoleLogSignal;

        override public function execute():void{
            if(this.data != ""){
                this.spamFilter.setPatterns(this.data.FilterList.split(/\n/g));
            }else{
                this.log.dispatch("Unable to set FilterList from app/init.");
            }
        }

    }
}//package kabam.rotmg.core.commands

