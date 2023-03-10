// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//com.company.assembleegameclient.mapeditor.MEObjectNameCommand

package com.company.assembleegameclient.mapeditor{
    import com.company.assembleegameclient.editor.Command;

    public class MEObjectNameCommand extends Command {

        private var map_:MEMap;
        private var x_:int;
        private var y_:int;
        private var oldName_:String;
        private var newName_:String;

        public function MEObjectNameCommand(_arg1:MEMap, _arg2:int, _arg3:int, _arg4:String, _arg5:String){
            this.map_ = _arg1;
            this.x_ = _arg2;
            this.y_ = _arg3;
            this.oldName_ = _arg4;
            this.newName_ = _arg5;
        }

        override public function execute():void{
            this.map_.modifyObjectName(this.x_, this.y_, this.newName_);
        }

        override public function unexecute():void{
            this.map_.modifyObjectName(this.x_, this.y_, this.oldName_);
        }


    }
}//package com.company.assembleegameclient.mapeditor

