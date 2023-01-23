﻿// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.stage3D.graphic3D.Program3DFactory

package kabam.rotmg.stage3D.graphic3D{
    import kabam.rotmg.stage3D.proxies.Program3DProxy;
    import kabam.rotmg.stage3D.shaders.VertextShader;
    import kabam.rotmg.stage3D.shaders.FragmentShaderRepeat;
    import kabam.rotmg.stage3D.shaders.FragmentShader;
    import kabam.rotmg.stage3D.proxies.Context3DProxy;

    public class Program3DFactory {

        public static const TYPE_REPEAT_ON:Boolean = true;
        public static const TYPE_REPEAT_OFF:Boolean = false;

        private static var instance:Program3DFactory;

        private var repeatProgram:Program3DProxy;
        private var noRepeatProgram:Program3DProxy;

        public function Program3DFactory(_arg1:String=""){
            if (_arg1 != "yoThisIsInternal"){
                throw (new Error("Program3DFactory is a singleton. Use Program3DFactory.getInstance()"));
            };
        }

        public static function getInstance():Program3DFactory{
            if (instance == null){
                instance = new Program3DFactory("yoThisIsInternal");
            };
            return (instance);
        }


        public function dispose():void{
            if (this.repeatProgram != null){
                this.repeatProgram.getProgram3D().dispose();
            };
            if (this.noRepeatProgram != null){
                this.noRepeatProgram.getProgram3D().dispose();
            };
            instance = null;
        }

        public function getProgram(_arg1:Context3DProxy, _arg2:Boolean):Program3DProxy{
            var _local3:Program3DProxy;
            switch (_arg2){
                case TYPE_REPEAT_ON:
                    if (this.repeatProgram == null){
                        this.repeatProgram = _arg1.createProgram();
                        this.repeatProgram.upload(new VertextShader().getVertexProgram(), new FragmentShaderRepeat().getVertexProgram());
                    };
                    _local3 = this.repeatProgram;
                    break;
                case TYPE_REPEAT_OFF:
                    if (this.noRepeatProgram == null){
                        this.noRepeatProgram = _arg1.createProgram();
                        this.noRepeatProgram.upload(new VertextShader().getVertexProgram(), new FragmentShader().getVertexProgram());
                    };
                    _local3 = this.noRepeatProgram;
                    break;
                default:
                    if (this.repeatProgram == null){
                        this.repeatProgram = _arg1.createProgram();
                        this.repeatProgram.upload(new VertextShader().getVertexProgram(), new FragmentShaderRepeat().getVertexProgram());
                    };
                    _local3 = this.repeatProgram;
            };
            return (_local3);
        }


    }
}//package kabam.rotmg.stage3D.graphic3D

