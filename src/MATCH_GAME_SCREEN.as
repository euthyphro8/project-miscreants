package  {
	import Extended.E_BUTTON;
	import Extended.E_IMAGE;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class MATCH_GAME_SCREEN extends DISPLAY 
	{
		
		private var Assets:AssetManager;
		private var one:TIER_DISPLAY;
		private var two:TIER_DISPLAY;
		private var three:TIER_DISPLAY;
		private var four:TIER_DISPLAY;
		
		private var background:E_IMAGE;
		private var Menu_Button:E_BUTTON;
		private var Win_Button:E_BUTTON;
		private var entity_manager:ENTITY_DISPLAY;
		
		private var Pick_Order:Vector.<int>;
		
		public function MATCH_GAME_SCREEN(assets:AssetManager) 
		{
			Assets = assets;
			var config:XML = assets.getXml("Game");
			
			// ----------------------TODO: reference XML for payout values ------------------------
			one = new TIER_DISPLAY(assets, 0, 540, "One",(String)(1000));
			two = new TIER_DISPLAY(assets, 320, 540, "Two",(String)(2000));
			three = new TIER_DISPLAY(assets, 640, 540, "Three",(String)(3000));
			four = new TIER_DISPLAY(assets, 960, 540, "Four",(String)(4000));
			
			background = new E_IMAGE(assets, config.Menu.Background);
			Menu_Button = new E_BUTTON(assets, config.Game.Menu_Button);
			Win_Button = new E_BUTTON(assets, config.Game.Win_Button);
			
			
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
			
			
			Menu_Button.Text_Format.color = 0;
			Win_Button.Text_Format.color = 0;
			
			entity_manager = new ENTITY_DISPLAY(this, assets, 0, 0);
			
			Add_Children([background, one, two, three, four, entity_manager ]);//, Menu_Button, Win_Button]);
			
			Menu_Button.addEventListener(BUTTON.EVENT_RELEASED, Menu_Button_Event);
			Win_Button.addEventListener(BUTTON.EVENT_RELEASED, Win_Button_Event);
			
		}
		
		/**
		 * Generates a list of picks based on the predetermined winning tier that must be passed to this func.
		 * @param	winning_Tier
		 */
		public function Generate_Entity_Picks(winning_Tier:int):void 
		{
			//--------------DEBUGGING: FIX XML PROBLEM-----------------------//
			trace("[MATCH_GAME_SCREEN] Winning tier is: " + winning_Tier);
			if (winning_Tier == 0) winning_Tier = 3;
			//---------------END DEBUGGING------------------------------------//
			var maxPicks:int = 3;
			var numPicks:int = Math.floor(Math.random() * (((maxPicks - 1) * 4) - (maxPicks - 1))) + (maxPicks - 1);
			var pool:Vector.<int> = new <int>[numPicks];
			for (var i:int = 0; i < (maxPicks - 1); i++)
			{
				pool.push(winning_Tier);
			}
			trace("NumPicks: " + numPicks);
			var freq:Array = new Array(0, 0, 0, 0);
			for (i = 0; i < numPicks - (maxPicks - 1); i++)
			{
				var pick:int = winning_Tier;
				while (pick == winning_Tier)
				{
					pick = Math.floor(Math.random() * 4) + 1;
					trace("i, pick: " + i + ", " + pick);
					if (freq[pick - 1] == (maxPicks - 1))
						pick = winning_Tier;
				}
				freq[pick - 1] += 1;
				pool.push(pick);
			}
			Pick_Order = new <int>[];
			Pick_Order.push(winning_Tier);
			for (i = 0; i < numPicks; i++ ) {
				var index:int = Math.floor(Math.random() * pool.length);
				Pick_Order.push(pool.removeAt(index));
			}
			
			
		}
		
		public function Pass_Pick():void 
		{
			//get which tier to act upon depending on the list of predetermined picks
			var tier:int = Pick_Order.pop();
			var display:TIER_DISPLAY;
			if (tier == 1)
				display = one;
			else if (tier == 2)
				display = two;
			else if (tier == 3)
				display = three;
			else if (tier == 4)
				display = four;
			else {
				display = one;
				trace("[MATCH_GAME_SCREEN] Unhandeled tier number " +  tier + ", setting to one.");
			}
			if (display.Number_Of_Selected == 0) {
				display.Number_Of_Selected++;
				display.Pick_Slot_One.Flip(Assets.getTexture("Circle_Selected"), 500, display.Pick_Slot_One.x, display.Pick_Slot_One.y, 1.0/5.0, true);
			}else if (display.Number_Of_Selected == 1) {
				display.Number_Of_Selected++;
				display.Pick_Slot_Two.Flip(Assets.getTexture("Circle_Selected"), 500, display.Pick_Slot_Two.x, display.Pick_Slot_Two.y, 1.0/5.0, true);
			}else if (display.Number_Of_Selected == 2) {
			//--------------------TODO: Configure Win Animation Pre:Win Screen!!---------------------------//
				display.Number_Of_Selected++;
				display.Pick_Slot_Three.Flip(Assets.getTexture("Circle_Selected"), 500, display.Pick_Slot_Three.x, display.Pick_Slot_Three.y, 1.0 / 5.0, true);
				GAME.Screen_State = 3;
				GAME.Has_State_Changed = true;
			}
		}
		
		private function Menu_Button_Event():void 
		{
			GAME.Screen_State = 1;
			GAME.Has_State_Changed = true;
		}
		private function Win_Button_Event():void 
		{
			GAME.Screen_State = 3;
			GAME.Has_State_Changed = true;
		}
		
	}

}