// ---------------------------------------
//	Casino Game Maker, Inc.
// ---------------------------------------

package {
	import Events.LOADING_EVENT;
	import Extended.*;
	import starling.events.*;
	import starling.utils.AssetManager;
	import starling.core.Starling;

	public class GAME extends DISPLAY {
		
		private var _Asset_Loader:AssetLoader;
		private var _Assets:AssetManager;
		private var _Config:XML;
		private var _Math_Config:XML;
		private var _Directory:String;

		public function GAME(directory:String){
			_Directory = directory + "/";
			_Asset_Loader = new AssetLoader(Directory, Asset_Loader_Handler);
			Asset_Loader.Add_Directory(Directory);
			Asset_Loader.Start();
		}

		private function Asset_Loader_Handler(ratio:Number):void{
			var Loading_Event:LOADING_EVENT = new LOADING_EVENT(LOADING_EVENT.EVENT_LOADING_STATUS);
			Loading_Event.Percentage = ratio;
			dispatchEvent(Loading_Event);
			
			if(ratio < 1) return;
			_Assets	= Asset_Loader.Get_Assets();
			_Config	= Assets.getXml("Game");
			_Math_Config = Assets.getXml("Math");
			
			this.addEventListener(Event.ENTER_FRAME, Enter_Frame_Handler);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey_Down);
		}

		private function Enter_Frame_Handler():void{
		}
		
		private function onKey_Down():void{
		}
		
		//Getters 
		public function get Asset_Loader():AssetLoader{
			return _Asset_Loader;
		}
		public function get Assets():AssetManager{
			return _Assets;
		}
		public function get Config():XML{
			return _Config;
		}
		public function get Math_Config():XML{
			return _Math_Config;
		}
		public function get Directory():String{
			return _Directory;
		}
	}
}


