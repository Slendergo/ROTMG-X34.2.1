// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//io.decagames.rotmg.pets.components.petItem.PetItemBackground

package io.decagames.rotmg.pets.components.petItem{
    import flash.display.Sprite;
    import flash.display.GraphicsSolidFill;
    import flash.display.GraphicsPath;
    import flash.display.IGraphicsData;
    import com.company.util.GraphicsUtil;

    public class PetItemBackground extends Sprite {

        public function PetItemBackground(_arg1:int, _arg2:Array, _arg3:uint, _arg4:Number){
            var _local5:GraphicsSolidFill = new GraphicsSolidFill(_arg3, _arg4);
            var _local6:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
            var _local7:Vector.<IGraphicsData> = new <IGraphicsData>[_local5, _local6, GraphicsUtil.END_FILL];
            GraphicsUtil.drawCutEdgeRect(0, 0, _arg1, _arg1, (_arg1 / 12), _arg2, _local6);
            graphics.drawGraphicsData(_local7);
        }

    }
}//package io.decagames.rotmg.pets.components.petItem

