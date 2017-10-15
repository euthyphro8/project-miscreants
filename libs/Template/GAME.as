// ---------------------------------------
//	Casino Game Maker, Inc.
// ---------------------------------------

package
{
	import Events.LOADING_EVENT;
	import Extended.*;
	import starling.events.*;
	import starling.utils.AssetManager;
	import starling.core.Starling;
	import Roulette.ROULETTE_BETS;

	public class GAME extends DISPLAY
	{
		private var Language_Button:E_BUTTON;
		private var Background_Image:E_IMAGE;
		private var Flag_Image:E_IMAGE;
		private var Arrow_Image:E_IMAGE;
		private var Instruction_Area:E_TEXT;
		private var Random_Number:int;
		private var Win_Amount:int;
		private var Button_Sound:SOUND;
		
		private var Random_Numbers:RNG;
		private var Wincheck:WINCHECK;
		
		private var _Asset_Loader:ASSET_LOADER;
		private var _Assets:AssetManager;
		private var _Config:XML;
		private var _Math_Config:XML;
		private var _Directory:String;
		private var _Locality:LOCALITY;

		public function GAME(directory:String)
		{
			_Directory = directory + "/";

			_Asset_Loader = new ASSET_LOADER(Directory, Asset_Loader_Handler);
			Asset_Loader.Add_Directory(Directory);
			Asset_Loader.Start();
		}

		private function Asset_Loader_Handler(ratio:Number):void
		{
			var Loading_Event:LOADING_EVENT = new LOADING_EVENT(LOADING_EVENT.EVENT_LOADING_STATUS);
			Loading_Event.Percentage = ratio;
			dispatchEvent(Loading_Event);

			if(ratio < 1) return;

			//Assets are what we use to get sounds, images, animations...
			_Assets			= Asset_Loader.Get_Assets();
			
			//The config file is where all the information for our text areas, image, and other variables are stored.
			_Config			= Assets.getXml("Game");
			
			//The math config is where the information about win check will be stored. 
			_Math_Config 	= Assets.getXml("Math");
			
			//Locality stores information about strings and different languages. 
			_Locality 		= new LOCALITY(Assets.getXml("Locality"));
			Locality.addEventListener(LOCALITY.EVENT_LANGUAGE_CHANGED, Locality_Handler);
			
			//Random Numbers will allow you to get random numbers from the core. 
			Random_Numbers	= new RNG();
			Random_Numbers.addEventListener(RNG.EVENT_COMPLETE, Update_Random_Number);
			
			Random_Number	= 0;
			Win_Amount		= 0;
			
			//Example of how to check for a win. 
			Wincheck		= new WINCHECK(this);
			
			//Example sound. 
			Button_Sound	= new SOUND(Assets.getSound("Button_Sound"));
			
			//Example images.  
			Background_Image	= new E_IMAGE(Assets, Config.Game.Background);
			Flag_Image			= new E_IMAGE(Assets, Config.Game.Flag_Image);
			Arrow_Image			= new E_IMAGE(Assets, Config.Game.Arrow_Image);
			//The DISPLAY class has many different animation and movement properties that you can use. 
			Arrow_Image.Start_Pulse(15, .2);
			
			//Example or a text area. 
			Instruction_Area			= new E_TEXT(Config.Game.Instruction_Area);
			
			//Example button and listener. 
			Language_Button				= new E_BUTTON(Assets, Config.Game.Language_Button);
			Language_Button.addEventListener(BUTTON.EVENT_TOUCHED, Change_Language);
			
			//When you have an image, animation, text field, etc. you need to make sure that you add the child to the stage or else it won't show up. 
			Add_Children([	Background_Image, Language_Button, Flag_Image, Arrow_Image, Instruction_Area	]);
			
			//Listeners
			this.addEventListener(Event.ENTER_FRAME, Enter_Frame_Handler);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey_Down);
			
			Locality_Handler();
		}
		
		public function Locality_Handler():void
		{
			//Update text when language changes. 
			Language_Button.Text 	= Locality.Get_Item("Language_Button");
		}

		private function Enter_Frame_Handler():void
		{
			//Constantly update the instruction area with the random number. 
			Instruction_Area.Text	= Locality.Get_Item("Instruction_Message") + "\n\n" + Random_Number + "\t\tWin Amount: " + Win_Amount;
		}
		
		public function onKey_Down(keyEvent:KeyboardEvent):void
		{
			//Request a new random number when a key has been pressed. 
			Random_Numbers.Request([36]);
		}
		
		private function Change_Language():void
		{
			//Language button handler. 
			Button_Sound.Start();
			Locality.Next_Language();
			
			//This is another one of those awesome methods from the DISPLAY class. 
			Flag_Image.Flip(Assets.getTexture(Locality.Language + "_Flag"), 500, Flag_Image.x, Flag_Image.y);
		}
		
		private function Update_Random_Number():void
		{
			//Change the random number to the newest one. 
			Random_Number = Random_Numbers.Results[0];
			
			//Creating temporary bets on the random number that we just got. 
			var temp_bets:ROULETTE_BETS = new ROULETTE_BETS();
			temp_bets.Set_Wager("STRAIGHT_UP", Random_Number, 100);
			
			//Process the win. 11 is the best number, so I'm forcing it to be the winning number everytime. 
			Win_Amount = Wincheck.Process_Win(11, temp_bets);
		}
		
		
		
		
		//Getters 
		public function get Asset_Loader():ASSET_LOADER
		{
			return _Asset_Loader;
		}
		
		public function get Assets():AssetManager
		{
			return _Assets;
		}
		
		public function get Config():XML		
		{
			return _Config;
		}
		
		public function get Math_Config():XML
		{
			return _Math_Config;
		}
		
		public function get Directory():String
		{
			return _Directory;
		}
		
		public function get Locality():LOCALITY
		{
			return _Locality;
		}
	}
}


