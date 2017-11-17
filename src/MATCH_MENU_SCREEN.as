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
		
		public var Background_Music:SOUND;
		
		public var Winning_Tier:int;
		
		public var Assets:AssetManager;
		
		public function MATCH_MENU_SCREEN(assets:AssetManager) 
		{
			var config:XML = assets.getXml("Game");
			
			this.Assets = assets;
			
			Title = new E_TEXT(config.Menu.Title);
			//Start_Message = new E_TEXT(config.Menu.Start_Message);
			Modifier_Message = new E_TEXT(config.Menu.Modifier_Message);
			
			
			Background_Image	= new E_IMAGE(assets, config.Menu.Background);
			
			Start_Button = new E_BUTTON(assets, config.Menu.Start_Button);
			Modifier_One_Button = new E_BUTTON(assets, config.Menu.Modifier_One_Button);
			Modifier_Two_Button = new E_BUTTON(assets, config.Menu.Modifier_Two_Button);
			Modifier_Three_Button = new E_BUTTON(assets, config.Menu.Modifier_Three_Button);
			Modifier_Four_Button = new E_BUTTON(assets, config.Menu.Modifier_Four_Button);
			
			Modifier_One_Button._Button.width = 200;
			Modifier_One_Button._Button.height = 70;
			Modifier_One_Button._Button.x += 69;
			Modifier_One_Button._Button.y += 25;
			Modifier_One_Button._Button.textFormat.size = 35;
			
			Modifier_Two_Button._Button.width = 200;
			Modifier_Two_Button._Button.height = 70;
			Modifier_Two_Button._Button.x += 69;
			Modifier_Two_Button._Button.y += 25;
			Modifier_Two_Button._Button.textFormat.size = 35;
			
			Modifier_Three_Button._Button.width = 200;
			Modifier_Three_Button._Button.height = 70;
			Modifier_Three_Button._Button.x += 69;
			Modifier_Three_Button._Button.y += 25;
			Modifier_Three_Button._Button.textFormat.size = 35;
			
			Modifier_Four_Button._Button.width = 200;
			Modifier_Four_Button._Button.height = 70;
			Modifier_Four_Button._Button.x += 69;
			Modifier_Four_Button._Button.y += 25;
			Modifier_Four_Button._Button.textFormat.size = 35;
			
			Title.Text_Format.color = 0;
			//Title.Text_Format.size = 35;
			
			Title.Start_Flash(800, 400);
			Title.Font_Size = 100;
			
			Modifier_Message.Text_Format.color = 0;
			Modifier_Message.Text_Format.size = 35;
			
			Start_Button.Text_Format.color = 0;
			Start_Button.Text_Format.size = 35;
			
			Modifier_One_Button.Text_Format.color = 0;
			Modifier_Two_Button.Text_Format.color = 0;
			Modifier_Three_Button.Text_Format.color = 0;
			Modifier_Four_Button.Text_Format.color = 0;
			
			
			
			//maybe this should go somewhere else...
			Background_Music = new SOUND(Assets.getSound("background_music"));
			//Background_Music.Start();
			Background_Music.Play_Forever();
			
			
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
				var math:XML = Assets.getXml("Math");
				var pick:int, T1:int, T2:int, T3:int, T4:int, node:XMLList, pool:int;
				if (Modifier == 1) {
					node = math.Easy;
				}else if (Modifier == 2) {
					node = math.Medium;
				}else if (Modifier == 3) {
					node = math.Hard;
				}else if (Modifier == 4) {
					node = math.GOD_MODE;
				}
				T1 = int(node.@T1Freq);
				T2 = int(node.@T2Freq);
				T3 = int(node.@T3Freq);
				T4 = int(node.@T4Freq);
				pick = Math.floor((Math.random() * (pool)));
				
				trace("[MATCH_MENU_SCREEN] Modifier: " + Modifier);
				trace("[MATCH_MENU_SCREEN] Pool, Pick: " + pool + ", " + pick);
				trace("[MATCH_MENU_SCREEN] T1, T2, T3, T4: " + T1 + ", " + T2+ ", " + T3+ ", " + T4);
				
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
				GAME.Screen_State = GAME.INFO_STATE;
				GAME.Has_State_Changed = true;
			}
		}
		private function SetModifierOne():void 
		{
			Modifier = 1;
			Modifier_One_Button.Texture = Assets.getTexture("Button_Selected");
			Modifier_Two_Button.Texture = Assets.getTexture("Button");
			Modifier_Three_Button.Texture = Assets.getTexture("Button");
			Modifier_Four_Button.Texture = Assets.getTexture("Button");
		}
		private function SetModifierTwo():void 
		{
			Modifier = 2;
			Modifier_One_Button.Texture = Assets.getTexture("Button");
			Modifier_Two_Button.Texture = Assets.getTexture("Button_Selected");
			Modifier_Three_Button.Texture = Assets.getTexture("Button");
			Modifier_Four_Button.Texture = Assets.getTexture("Button");
		}
		private function SetModifierThree():void 
		{
			Modifier = 3;
			Modifier_One_Button.Texture = Assets.getTexture("Button");
			Modifier_Two_Button.Texture = Assets.getTexture("Button");
			Modifier_Three_Button.Texture = Assets.getTexture("Button_Selected");
			Modifier_Four_Button.Texture = Assets.getTexture("Button");
		}
		private function SetModifierFour():void 
		{
			Modifier = 4;
			Modifier_One_Button.Texture = Assets.getTexture("Button");
			Modifier_Two_Button.Texture = Assets.getTexture("Button");
			Modifier_Three_Button.Texture = Assets.getTexture("Button");
			Modifier_Four_Button.Texture = Assets.getTexture("Button_Selected");
		}
	}
}