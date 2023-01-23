// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.lib.net.impl.MethodHandlerProxy

package kabam.lib.net.impl{
    import kabam.lib.net.api.*;

    public class MethodHandlerProxy implements MessageHandlerProxy {

        private var method:Function;


        public function setMethod(_arg1:Function):MethodHandlerProxy{
            this.method = _arg1;
            return (this);
        }

        public function getMethod():Function{
            return (this.method);
        }


    }
}//package kabam.lib.net.impl

