package {

    import starling.display.Sprite;
    import starling.display.Image;
    import starling.display.Sprite3D;
    import starling.textures.Texture;

    public class Manager extends Sprite {

        [Embed(source='/circle.png')]


        public static const Circle:Class;

        public function Manager() {
            var tCircle:Texture = Texture.fromEmbeddedAsset(Circle);
            var iCircle:Image = new Image(tCircle);
            iCircle.x = 20;
            iCircle.y = 20;

            addChild(iCircle);

            var tCircle:Texture = Texture.fromEmbeddedAsset(Circle);
            var iCircle:Image = new Image(tCircle);
            iCircle.x = 200;
            iCircle.y = 200;

            addChild(iCircle);
        }
    }
}
