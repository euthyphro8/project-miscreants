package  {
	
	import Extended.E_BUTTON;
	import Extended.E_IMAGE;
	import flash.display.MovieClip;
	import flash.display3D.textures.Texture;
	import starling.display.Sprite;
	import starling.display.MovieClip;
	import starling.utils.AssetManager;
	import starling.core.Starling;
	
	public class MATCH_GAME_SCREEN extends DISPLAY 
	{
		
		private var Assets:AssetManager;
		private var Tier_One:TIER_DISPLAY;
		private var Tier_Two:TIER_DISPLAY;
		private var Tier_Three:TIER_DISPLAY;
		private var Tier_Four:TIER_DISPLAY;
		
		private var Background:E_IMAGE;
		private var Menu_Button:E_BUTTON;
		private var Win_Button:E_BUTTON;
		private var Help_Button:E_BUTTON;
		private var Entity_Display:ENTITY_DISPLAY;
		
		private var Pick_Order:Vector.<int>;
		
		public function MATCH_GAME_SCREEN(assets:AssetManager) 
		{
			Assets = assets;
			var config:XML = assets.getXml("Game");
			
			
			// ----------------------TODO: reference XML for payout values ------------------------
			Tier_One = new TIER_DISPLAY(assets, 0, 540, "God", 1);
			Tier_Two = new TIER_DISPLAY(assets, 320, 540, "King", 2);
			Tier_Three = new TIER_DISPLAY(assets, 640, 540, "Lord", 3);
			Tier_Four = new TIER_DISPLAY(assets, 960, 540, "Peasant", 4);
			
			Entity_Display = new ENTITY_DISPLAY(this, assets, 0, 0);
			Background = new E_IMAGE(assets, config.Game.Background);
			Menu_Button = new E_BUTTON(assets, config.Game.Menu_Button);
			Win_Button = new E_BUTTON(assets, config.Game.Win_Button);
			Help_Button = new E_BUTTON(assets, config.Game.Help_Button);
			
			
			Background.width = CONFIG::VIEWPORT_WIDTH;
			Background.height = CONFIG::VIEWPORT_HEIGHT;
			
			Menu_Button._Button.width = 170;
			Menu_Button._Button.height = 60;
			Menu_Button._Button.x += 69;
			Menu_Button._Button.y += 25;
			Menu_Button._Button.textFormat.size = 35;

			Win_Button._Button.width = 170;
			Win_Button._Button.height = 60;
			Win_Button._Button.x += 69;
			Win_Button._Button.y += 25;
			Win_Button._Button.textFormat.size = 35;
			
			Help_Button._Button.width = 50;
			Help_Button._Button.height = 50;
			Help_Button._Button.x += 150;
			Help_Button._Button.y += 50;
			Help_Button._Button.textFormat.size = 45;
			
			Menu_Button.Text_Format.color = 0;
			Win_Button.Text_Format.color = 0;
			Help_Button.Text_Format.color = 0;
			
			
			Add_Children([Background, Tier_One, Tier_Two, Tier_Three, Tier_Four, Entity_Display , Help_Button]);//, Menu_Button, Win_Button]);
			
			Menu_Button.addEventListener(BUTTON.EVENT_RELEASED, Menu_Button_Event);
			Help_Button.addEventListener(BUTTON.EVENT_RELEASED, Help_Button_Event);
			Win_Button.addEventListener(BUTTON.EVENT_RELEASED, Win_Button_Event);
			
		}
		
		public function Set_Payouts(p1:int, p2:int, p3:int, p4:int):void 
		{
			Tier_One.Tier_Amount.Text = String(p1);
			Tier_Two.Tier_Amount.Text = String(p2);
			Tier_Three.Tier_Amount.Text = String(p3);
			Tier_Four.Tier_Amount.Text = String(p4);
		}
		
		/**
		 * Generates a list of picks based on the predetermined winning tier that must be passed to this func.
		 * @param	winning_Tier
		 */
		public function Generate_Entity_Picks(winning_Tier:int):void 
		{
			trace("[MATCH_GAME_SCREEN] Winning tier is: " + winning_Tier);
			//Just in case there is an error with the winning tier generation
			if (winning_Tier == 0) winning_Tier = 3;
			
			//Number of picks it takes to win any given tier
			var maxPicks:int = 3;
			
			//Number of picks we will pick out for them (not including the final 'win' pick)
			//We make sure the max number of picks is no more than the total tiers times 
			var numPicks:int = Math.floor(Math.random() * (((maxPicks - 1) * 4) - (maxPicks - 1))) + (maxPicks + 1);
			trace("[MATCH_GAME_SCREEN] Number of Picks: " + numPicks);
			
			//The pool of picks that we will randomly draw from
			var pool:Vector.<int> = new <int>[numPicks];
			
			//To make sure the winning tier has at least 3 picks in the list 
			//Two here to be ordered randomly and the final one added later to be last in the list
			for (var i:int = 0; i < (maxPicks - 1); i++)
				pool.push(winning_Tier);
				
			//We initialize a frequency array to allow us to check that no tier is added more than 
			//twice to verify our chosen winning tier will be the actual winning tier
			var freq:Array = new Array(0, 0, 0, 0);
			for (i = 0; i < numPicks - (maxPicks); i++)
			{
				var pick:int = winning_Tier;
				
				//Since we've already added two winnnig picks we want to keep generating until it's not the winning tier
				while (pick == winning_Tier)
				{
					pick = Math.floor(Math.random() * 4) + 1;
					
					//We also check to verify we haven't already added two of the pick we've chosen
					if (freq[pick - 1] == (maxPicks - 1))
						pick = winning_Tier;
				}
				trace("[MATCH_GAME_SCREEN] Added to pick pool: " + pick)
				
				//Once we're satisfied with the pick we add it and record it with our frequency array
				freq[pick - 1] += 1;
				pool.push(pick);
			}
			
			//Now to generate the actual order
			Pick_Order = new <int>[];
			
			//First push the winning tier so it will be the last on picked
			Pick_Order.push(winning_Tier);
			for (i = 0; i < numPicks; i++ ) {
				
				//We then randomly pick from our pool and push it into our pick order list
				var index:int = Math.floor(Math.random() * pool.length);
				var picked:int = pool[index];
				trace("[MATCH_GAME_SCREEN] Pick: " + picked + " at " + index + ", with pool length " + pool.length);
				
				//Once we've picked it we must remove it from our picks pool so we don't add any duplicates
				pool.removeAt(index);
				Pick_Order.push(picked);
			}
			
			
		}
		
		public function Pass_Pick():void 
		{	
			//Get which tier to act upon depending on the list of predetermined picks
			var tier:int = Pick_Order.pop();
			var display:TIER_DISPLAY;
			var chibi:String;
			if (tier == 1) 
			{
				display = Tier_One;
				chibi = "RedChibi";
			}
			else if (tier == 2) 
			{
				display = Tier_Two;
				chibi = "PurpleChibi";
			}
			else if (tier == 3)
			{
				display = Tier_Three;
				chibi = "GreenChibi";
			}
			else if (tier == 4)
			{
				display = Tier_Four;
				chibi = "YellowChibi";
			}
			else 
			{
				display = Tier_One;
				chibi = "RedChibi";
				trace("[MATCH_GAME_SCREEN] Unhandeled tier number " +  tier + ", setting to one.");
			}
			if (display.Number_Of_Selected == 0) 
			{
				display.Number_Of_Selected++;
				display.Pick_Slot_One.Flip(Assets.getTexture(chibi), 500, display.Pick_Slot_One.x, display.Pick_Slot_One.y, 1, true);
			}
			else if (display.Number_Of_Selected == 1) 
			{
				display.Number_Of_Selected++;
				display.Pick_Slot_Two.Flip(Assets.getTexture(chibi), 500, display.Pick_Slot_Two.x, display.Pick_Slot_Two.y, 1, true);
			}
			else if (display.Number_Of_Selected == 2) 
			{
				display.Number_Of_Selected++;
				display.Pick_Slot_Three.Flip(Assets.getTexture(chibi), 500, display.Pick_Slot_Three.x, display.Pick_Slot_Three.y, 1, true);
				Win_Game();
			}
		}
		private function Win_Game():void 
		{
			Starling.juggler.delayCall(
						function():void { 
							GAME.Screen_State = GAME.WIN_STATE;
							GAME.Has_State_Changed = true; 
						}, 3.0);
			Entity_Display.Remove_All();
				
		}
		private function Menu_Button_Event():void 
		{
			GAME.Screen_State = GAME.MENU_STATE;
			GAME.Has_State_Changed = true;
		}
		private function Win_Button_Event():void 
		{	
			GAME.Screen_State = GAME.WIN_STATE;
			GAME.Has_State_Changed = true;
		}
		private function Help_Button_Event():void 
		{
			GAME.Screen_State = GAME.INFO_STATE;
			GAME.Has_State_Changed = true;
		}
		
		public function Update():void
		{
			Entity_Display.Update();
		}	
	}
}