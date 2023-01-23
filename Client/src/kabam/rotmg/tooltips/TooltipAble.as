// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.tooltips.TooltipAble

package kabam.rotmg.tooltips{
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;

    public interface TooltipAble {

        function setShowToolTipSignal(_arg1:ShowTooltipSignal):void;
        function getShowToolTip():ShowTooltipSignal;
        function setHideToolTipsSignal(_arg1:HideTooltipsSignal):void;
        function getHideToolTips():HideTooltipsSignal;

    }
}//package kabam.rotmg.tooltips

