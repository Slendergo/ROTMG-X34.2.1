// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.stage3D.shaders.VertextShader

package kabam.rotmg.stage3D.shaders{
    import com.adobe.utils.AGALMiniAssembler;
    import flash.utils.ByteArray;
    import flash.display3D.Context3DProgramType;

    public class VertextShader extends AGALMiniAssembler {

        private var vertexProgram:ByteArray;

        public function VertextShader(){
            var _local1:AGALMiniAssembler = new AGALMiniAssembler();
            _local1.assemble(Context3DProgramType.VERTEX, (("m44 op, va0, vc0\n" + "add vt1, va1, vc4\n") + "mov v0, vt1"));
            this.vertexProgram = _local1.agalcode;
        }

        public function getVertexProgram():ByteArray{
            return (this.vertexProgram);
        }


    }
}//package kabam.rotmg.stage3D.shaders

