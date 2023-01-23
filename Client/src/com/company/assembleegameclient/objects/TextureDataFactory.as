// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.objects.TextureDataFactory

package com.company.assembleegameclient.objects{
    public class TextureDataFactory {


        public function create(_arg1:XML):TextureData{
            return (new TextureDataConcrete(_arg1));
        }


    }
}//package com.company.assembleegameclient.objects

