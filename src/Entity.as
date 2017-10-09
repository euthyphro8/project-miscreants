package {

import starling.textures.Texture;

public class Entity {



    var position:Vector.<Number>;
    var velocity:Vector.<Number>;

    public var img:Texture;

    public function Entity(textureLocation:String, x:Number, y:Number, xx:Number, yy:Number) {
        position = new <Number>[x,y];
        velocity = new <Number>[xx,yy];
    }
}
}
