package {

    import starling.display.Sprite;
    import starling.display.Image;
//    import starling.display.Sprite3D;
    import starling.textures.Texture;

    public class Manager extends Sprite {

        [Embed(source="/circle.png")]
        public static const Circle:Class;

        var _state:Number;
        var _menu:Menu
        var _game:Game;
        var _win:Win;

        public function Manager() {
            _state = 1;
            _menu = new Menu();
            _game = new Game();
            _win = new Win();
        }
        public function setState(newState:Number) {
            if (newState == 0 || newState == 1 || newState == 2 || newState == 3) {
                _state = newState;
            }else {
                trace("Error: Invalid state!");
            }

        }

        public function update() {

        }
    }
}
