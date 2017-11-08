// ---------------------------------------
//	Team Miscreants
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
		private var Assets:AssetManager;
		private var Config:XML;
		private var Math_Config:XML;
		private var Directory:String;
		
		
		private var Menu:MATCH_MENU_SCREEN
		private var Game:MATCH_GAME_SCREEN
		private var Win:MATCH_WIN_SCREEN
		
		public static var Screen_State:int;
		public static var Has_State_Changed:Boolean;
		
		public function GAME(directory:String) 
		{
			Directory = directory + "/";
			_Asset_Loader = new AssetLoader(Directory, Asset_Loader_Handler);
			_Asset_Loader.Add_Directory(Directory);
			_Asset_Loader.Start();
		}

		private function Asset_Loader_Handler(ratio:Number):void 
		{
			var Loading_Event:LOADING_EVENT = new LOADING_EVENT(LOADING_EVENT.EVENT_LOADING_STATUS);
			Loading_Event.Percentage = ratio;
			dispatchEvent(Loading_Event);
			
			if(ratio < 1) return;
			Assets	= _Asset_Loader.Get_Assets();
			Config	= Assets.getXml("Game");
			Math_Config = Assets.getXml("Math");
			
			Menu = new MATCH_MENU_SCREEN(Assets);
			Game = new MATCH_GAME_SCREEN(Assets);
			Win = new MATCH_WIN_SCREEN(Assets);
			
			Add_Children([Menu, Game, Win]);
			
			Screen_State = 1;
			Set_State();
			
			this.addEventListener(Event.ENTER_FRAME, Update);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey_Down);
		}

		private function Update():void 
		{
			if (Has_State_Changed) 
			{
				Set_State();
				trace("[GAME] Changing State: " + Screen_State);
				Has_State_Changed = false;
			}
		}
		
		private function onKey_Down(keyEvent:KeyboardEvent):void 
		{
			
		}
		
		public function Set_State():void 
		{
			if (Screen_State == 0) 
			{
				//Exit
			}
			else if (Screen_State == 1) 
			{
				//Menu Screen
				Game.Hide();
				Win.Hide();
				Menu.Show();
			}
			else if (Screen_State == 2) 
			{
				//Game Screen
				
				//Get predetermined winning tier from menu and pass it to game
				Game.Generate_Entity_Picks(Menu.Winning_Tier);
				
				Menu.Hide();
				Win.Hide();
				Game.Show();
			}
			else if (Screen_State == 3) 
			{
				//Win Screen
				Menu.Hide();
				Game.Hide();
				Win.Show();
				Win.puff.play();
				Starling.juggler.add(Win.puff);
			}
		}
		
		public function get Asset_Loader():AssetLoader 
		{
			return _Asset_Loader;
		}
		
		
	}
}