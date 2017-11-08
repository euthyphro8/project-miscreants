package  {
	
	
	 
	import Extended.*;
	import starling.utils.AssetManager;
	
	
	
	public class TIER_DISPLAY extends DISPLAY 
	{
		
		public var Display_Width:int;
		public var Display_Height:int;
		public var Number_Of_Selected:int;
		
		public var Tier_Background:E_IMAGE;
		public var Pick_Slot_One:E_IMAGE;
		public var Pick_Slot_Two:E_IMAGE;
		public var Pick_Slot_Three:E_IMAGE;
		
		public var Tier_Text:E_TEXT;
		public var Tier_Amount:E_TEXT;
		
		
		public function TIER_DISPLAY(assets:AssetManager, x:int, y:int, tier_name:String, tier_amount:String) 
		{
			var config:XML = assets.getXml("Game");
			Display_Width = 320;
			Display_Height = 180;
			
			Set_Position(x, y);
			
			
			Tier_Text = new E_TEXT(config.Tier.TierText);
			Tier_Amount = new E_TEXT(config.Tier.TierAmount);
			Tier_Text.Set_Position((int)(Display_Width / 2), (int)(Display_Height *.7));
			Tier_Amount.Set_Position((int)(Display_Width / 2), (int)(Display_Height * .9));
			
			Tier_Text.Font_Size = 25;
			Tier_Text.Text_Format.color = 0;
			Tier_Text.Text = "Tier: " + tier_name;
			
			Tier_Amount.Font_Size = 25;
			Tier_Amount.Text = tier_amount;
			Tier_Amount.Text_Format.color = 0;
			
			//Start_Button = new E_BUTTON(assets, config.Menu.Start_Button);
			Tier_Background	= new E_IMAGE(assets, config.Tier.Jiggly);
			Pick_Slot_One = new E_IMAGE(assets, config.Tier.FirstBubble);
			Pick_Slot_Two = new E_IMAGE(assets, config.Tier.SecondBubble);
			Pick_Slot_Three = new E_IMAGE(assets, config.Tier.ThirdBubble);
			Pick_Slot_One.Set_Position(5, 5);
			Pick_Slot_Two.Set_Position(100+10, 5);
			Pick_Slot_Three.Set_Position(2*100+15, 5);
			
			Pick_Slot_One.scale = (100./500);
			Pick_Slot_Two.scale = (100./500);
			Pick_Slot_Three.scale = (100./500);
			Tier_Background.width = Display_Width;
			Tier_Background.height = Display_Height;
			
			
			
			Add_Children([Tier_Background, Pick_Slot_One,Pick_Slot_Two,Pick_Slot_Three,Tier_Text,Tier_Amount]);
		
			
		}
		
	}

}