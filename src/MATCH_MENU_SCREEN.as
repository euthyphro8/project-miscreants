package {
	
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	
	import Events.LOADING_EVENT;
	import Extended.*;
	import starling.events.*;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class MATCH_MENU_SCREEN extends DISPLAY 
	{
		
		private static const MODIFIER_MESSAGE:String			= "Difficulty: ";
		private static const MODIFIER_ONE_MESSAGE:String 		= "Easy";
		private static const MODIFIER_TWO_MESSAGE:String 		= "Medium";
		private static const MODIFIER_THREE_MESSAGE:String 		= "Hard";
		private static const MODIFIER_FOUR_MESSAGE:String 		= "God Mode";
		
		public var Modifier:int;
		
		public var Title:E_TEXT;
		public var Start_Message:E_TEXT;
		public var Modifier_Message:E_TEXT;
		
		public var Background_Image:E_IMAGE;
		
		public var Start_Button:E_BUTTON;
		public var Modifier_One_Button:E_BUTTON;
		public var Modifier_Two_Button:E_BUTTON;
		public var Modifier_Three_Button:E_BUTTON;
		public var Modifier_Four_Button:E_BUTTON;
		
		public var Probabilities:XML;
		public var Winning_Tier:int;
		
		public function MATCH_MENU_SCREEN(assets:AssetManager) 
		{
			var config:XML = assets.getXml("Game");
			Probabilities = assets.getXml("Math");
			
			Title = new E_TEXT(config.Menu.Title);
			//Start_Message = new E_TEXT(config.Menu.Start_Message);
			Modifier_Message = new E_TEXT(config.Menu.Modifier_Message);
			
			Title.Start_Flash(800, 400);
			Title.Font_Size = 100;
			
			Background_Image	= new E_IMAGE(assets, config.Menu.Background);
			
			Start_Button = new E_BUTTON(assets, config.Menu.Start_Button);
			Modifier_One_Button = new E_BUTTON(assets, config.Menu.Modifier_One_Button);
			Modifier_Two_Button = new E_BUTTON(assets, config.Menu.Modifier_Two_Button);
			Modifier_Three_Button = new E_BUTTON(assets, config.Menu.Modifier_Three_Button);
			Modifier_Four_Button = new E_BUTTON(assets, config.Menu.Modifier_Four_Button);
			
			Modifier_One_Button._Button.width = 170;
			Modifier_One_Button._Button.height = 60;
			Modifier_One_Button._Button.x += 69;
			Modifier_One_Button._Button.y += 25;
			Modifier_One_Button._Button.textFormat.size = 35;
			
			Modifier_Two_Button._Button.width = 170;
			Modifier_Two_Button._Button.height = 60;
			Modifier_Two_Button._Button.x += 69;
			Modifier_Two_Button._Button.y += 25;
			Modifier_Two_Button._Button.textFormat.size = 35;
			
			Modifier_Three_Button._Button.width = 170;
			Modifier_Three_Button._Button.height = 60;
			Modifier_Three_Button._Button.x += 69;
			Modifier_Three_Button._Button.y += 25;
			Modifier_Three_Button._Button.textFormat.size = 35;
			
			Modifier_Four_Button._Button.width = 170;
			Modifier_Four_Button._Button.height = 60;
			Modifier_Four_Button._Button.x += 69;
			Modifier_Four_Button._Button.y += 25;
			Modifier_Four_Button._Button.textFormat.size = 35;
			
			Title.Text_Format.color = 0;
			Start_Button.Text_Format.color = 0;
			Modifier_Message.Text_Format.color = 0;
			Modifier_One_Button.Text_Format.color = 0;
			Modifier_Two_Button.Text_Format.color = 0;
			Modifier_Three_Button.Text_Format.color = 0;
			Modifier_Four_Button.Text_Format.color = 0;
			
			Add_Children([ Background_Image, Title, Modifier_Message, Start_Button, Modifier_One_Button, Modifier_Two_Button, Modifier_Three_Button, Modifier_Four_Button ]);
			
			Start_Button.addEventListener(BUTTON.EVENT_RELEASED, StartButton);
			Modifier_One_Button.addEventListener(BUTTON.EVENT_TOUCHED, SetModifierOne);
			Modifier_Two_Button.addEventListener(BUTTON.EVENT_TOUCHED, SetModifierTwo);
			Modifier_Three_Button.addEventListener(BUTTON.EVENT_TOUCHED, SetModifierThree);
			Modifier_Four_Button.addEventListener(BUTTON.EVENT_TOUCHED, SetModifierFour);
			
		}
		
		private function StartButton():void 
		{
			if (Modifier > 0 && Modifier <= 4) 
			{	
				var pick:int, T1:int, T2:int, T3:int, T4:int, node:XMLList;
				var pool:int;
				if (Modifier == 1) {
					node = Probabilities.Easy;
				}else if (Modifier == 2) {
					node = Probabilities.Engine.Medium;
				}else if (Modifier == 3) {
					node = Probabilities.Probability.Hard;
				}else if (Modifier == 4) {
					node = Probabilities.Probability.GOD_MODE;
				}				
				pool = int(node.@Pool);
				T1 = int(node.@T1Freq);
				T2 = int(node.@T2Freq);
				T3 = int(node.@T3Freq);
				T4 = int(node.@T4Freq);
				pick = Math.floor((Math.random() * (pool)));
				
				trace("Modifier: " + Modifier);
				trace("Pool, Pick: " + pool + ", " + pick);
				trace("T1, T2, T3, T4: " + T1 + ", " + T2+ ", " + T3+ ", " + T4);
				
				if (pick >= 0 && pick < T1) {
					Winning_Tier = 1;
				}else if (pick >= T1 && pick < T1 + T2) {
					Winning_Tier = 2;
				}else if (pick >= T1 + T2 && pick < T1 + T2 + T3) {
					Winning_Tier = 3;
				}else if (pick >= T1 + T2 + T3 && pick < T1 + T2 + T3 + T4) {
					Winning_Tier = 4;
				}else {
					trace("[MATCH_MENU_SCREEN] There was an error picking the tier! None have been seleced.");
				}
				GAME.Screen_State = 2;
				GAME.Has_State_Changed = true;
			}
		}
		private function SetModifierOne():void 
		{
			Modifier_Message.Text = MODIFIER_MESSAGE + MODIFIER_ONE_MESSAGE;
			Modifier = 1;
		}
		private function SetModifierTwo():void 
		{
			Modifier_Message.Text = MODIFIER_MESSAGE + MODIFIER_TWO_MESSAGE;
			Modifier = 2;
		}
		private function SetModifierThree():void 
		{
			Modifier_Message.Text = MODIFIER_MESSAGE + MODIFIER_THREE_MESSAGE;
			Modifier = 3;
		}
		private function SetModifierFour():void 
		{
			Modifier_Message.Text = MODIFIER_MESSAGE + MODIFIER_FOUR_MESSAGE;
			Modifier = 4;
		}
	}
}