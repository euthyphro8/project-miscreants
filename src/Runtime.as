package {

    import flash.display.Sprite;
    import starling.core.Starling;

    [SWF(width="600", height="600", frameRate="60", backgroundColor="#ffffff")]
    public class Runtime extends Sprite {
        private var _starling:Starling;

        public function Runtime() {
            _starling = new Starling(Game, stage);
            _starling.start();

        }
    }
}
