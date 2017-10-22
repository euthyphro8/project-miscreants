// ---------------------------------------
//	Casino Game Maker, Inc.
// ---------------------------------------

package {
	import Events.LOADING_EVENT;
	import Extended.*;
	import starling.events.*;
	import starling.utils.AssetManager;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class GAME extends DISPLAY {
		
		private var _Asset_Loader:AssetLoader;
		private var _Assets:AssetManager;
		private var _Config:XML;
		private var _Math_Config:XML;
		private var _Directory:String;
		
		
		private var Menu:MATCH_MENU_SCREEN
		private var Game:MATCH_GAME_SCREEN
		private var Win:MATCH_WIN_SCREEN
		
		public static var $state:int;
		
		public function GAME(directory:String) {
			_Directory = directory + "/";
			_Asset_Loader = new AssetLoader(Directory, Asset_Loader_Handler);
			Asset_Loader.Add_Directory(Directory);
			Asset_Loader.Start();
		}

		private function Asset_Loader_Handler(ratio:Number):void {
			var Loading_Event:LOADING_EVENT = new LOADING_EVENT(LOADING_EVENT.EVENT_LOADING_STATUS);
			Loading_Event.Percentage = ratio;
			dispatchEvent(Loading_Event);
			
			if(ratio < 1) return;
			_Assets	= Asset_Loader.Get_Assets();
			_Config	= Assets.getXml("Game");
			_Math_Config = Assets.getXml("Math");
			
			Menu = new MATCH_MENU_SCREEN(this, _Assets);
			//Game = new MATCH_GAME_SCREEN();
			//Win = new MATCH_WIN_SCREEN();
			
			Add_Children([Menu]);//, Game, Win]);
			
			this.addEventListener(Event.ENTER_FRAME, Enter_Frame_Handler);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey_Down);
		}

		private function Enter_Frame_Handler():void {
		}
		
		private function onKey_Down(keyEvent:KeyboardEvent):void {
			
		}
		
		
		
		//Getters 
		public function get Asset_Loader():AssetLoader {
			return _Asset_Loader;
		}
		public function get Assets():AssetManager {
			return _Assets;
		}
		public function get Config():XML {
			return _Config;
		}
		public function get Math_Config():XML {
			return _Math_Config;
		}
		public function get Directory():String {
			return _Directory;
		}
	}
}


