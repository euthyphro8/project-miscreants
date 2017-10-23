package  {
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author Josh Hess
	 */
	public class MATCH_GAME_SCREEN extends DISPLAY {
		
		private var one:TIER_DISPLAY;
		
		public function MATCH_GAME_SCREEN(assets:AssetManager) {
			var config:XML = assets.getXml("Game");
			
			
			one = new TIER_DISPLAY(assets);
			
			
		}
		
	}

}