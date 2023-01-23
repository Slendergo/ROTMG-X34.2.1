// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.animation.FrameData

package com.company.assembleegameclient.objects.animation{
    import com.company.assembleegameclient.objects.TextureData;
    import com.company.assembleegameclient.objects.TextureDataConcrete;

    public class FrameData {

        public var time_:int;
        public var textureData_:TextureData;

        public function FrameData(_arg1:XML){
            this.time_ = int((Number(_arg1.@time) * 1000));
            this.textureData_ = new TextureDataConcrete(_arg1);
        }

    }
}//package com.company.assembleegameclient.objects.animation

