package {

    import flash.display.Sprite;
    import starling.core.Starling;

    [SWF(width="1024", height="720", frameRate="60", backgroundColor="#ffffff")]
    public class Runtime extends Sprite {
        private var _starling:Starling;

        public function Startup() {
            _starling = new Starling(Game, stage);
            _starling.start();
        }
    }
}
