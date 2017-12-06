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
		
		
		public function TIER_DISPLAY(assets:AssetManager, x:int, y:int, tier_name:String, tier_num:int) 
		{
			var config:XML = assets.getXml("Game");
			Display_Width = 320;
			Display_Height = 180;
			
			Set_Position(x, y);
			
			
			Tier_Text = new E_TEXT(config.Tier.TierText);
			Tier_Amount = new E_TEXT(config.Tier.TierAmount);
			Tier_Text.Set_Position((int)(Display_Width / 2), (int)(Display_Height *.8));
			Tier_Amount.Set_Position((int)(Display_Width / 2), (int)(Display_Height * .65));
			
			Tier_Text.Font_Size = 25;
			Tier_Text.Text_Format.color = 0;
			Tier_Text.Text = "Tier: " + tier_name;
			
			Tier_Amount.Font_Size = 25;
			Tier_Amount.Text = "0";
			Tier_Amount.Text_Format.color = 0;
			
			//Start_Button = new E_BUTTON(assets, config.Menu.Start_Button);
			Tier_Background	= new E_IMAGE(assets, config.Tier.Background);
			
			Pick_Slot_One = new E_IMAGE(assets, config.Tier.ChibiDefault);
			Pick_Slot_Two = new E_IMAGE(assets, config.Tier.ChibiDefault);
			Pick_Slot_Three = new E_IMAGE(assets, config.Tier.ChibiDefault);
			
			Pick_Slot_One.Set_Position((int)(Display_Width*.1), (int)(Display_Height*.1));
			Pick_Slot_Two.Set_Position((int)(Display_Width*.4), (int)(Display_Height*.1));
			Pick_Slot_Three.Set_Position((int)(Display_Width*.7), (int)(Display_Height*.1));
			
			Tier_Background.width = Display_Width;
			Tier_Background.height = Display_Height;
			
				
			Add_Children([Tier_Background, Pick_Slot_One,Pick_Slot_Two,Pick_Slot_Three,Tier_Text,Tier_Amount]);
		
		}
		
	}

}