package {
	
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	
	import Events.LOADING_EVENT;
	import Extended.*;
	import starling.events.*;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class MATCH_MENU_SCREEN extends DISPLAY {
		
		public var Start_Message:E_TEXT;
		public var Modifier_Message:E_TEXT;
		
		public var Background_Image:E_IMAGE;
		
		public var Start_Button:E_BUTTON;
		public var Modifier_One_Button:E_BUTTON;
		public var Modifier_Two_Button:E_BUTTON;
		public var Modifier_Three_Button:E_BUTTON;
		public var Modifier_Four_Button:E_BUTTON;
		
		public function MATCH_MENU_SCREEN(assets:AssetManager) {
			var config:XML = assets.getXml("Game");
			
			Start_Message = new E_TEXT(config.Menu.Start_Message);
			Modifier_Message = new E_TEXT(config.Menu.Modifier_Message);
			
			
			Background_Image	= new E_IMAGE(assets, config.Menu.Background);
			
			
			Start_Button = new E_BUTTON(assets, config.Menu.Start_Button);
			Modifier_One_Button = new E_BUTTON(assets, config.Menu.Modifier_One_Button);
			Modifier_Two_Button = new E_BUTTON(assets, config.Menu.Modifier_Two_Button);
			Modifier_Three_Button = new E_BUTTON(assets, config.Menu.Modifier_Three_Button);
			Modifier_Four_Button = new E_BUTTON(assets, config.Menu.Modifier_Four_Button);
			
			
			Start_Message.Text = "Hedo Every-nyan";
			
			
			Start_Button.Text = "Start Button";
			Modifier_One_Button.Text = "x1";	
			Modifier_Two_Button.Text = "x2";
			Modifier_Three_Button.Text = "x3";
			Modifier_Four_Button.Text = "x4";		
			
			
			//For some reason must be added on same line or else text doesn't seem to work
			Add_Children([ Background_Image, Start_Message, Modifier_Message, Start_Button, Modifier_One_Button, Modifier_Two_Button, Modifier_Three_Button, Modifier_Four_Button ]);
			
			
			Start_Button.addEventListener(BUTTON.EVENT_TOUCHED, StartButton);
			Modifier_One_Button.addEventListener(BUTTON.EVENT_TOUCHED, SetModifierOne);
			Modifier_Two_Button.addEventListener(BUTTON.EVENT_TOUCHED, SetModifierTwo);
			Modifier_Three_Button.addEventListener(BUTTON.EVENT_TOUCHED, SetModifierThree);
			Modifier_Four_Button.addEventListener(BUTTON.EVENT_TOUCHED, SetModifierFour);
			
			
			
			
		}
		
		private function StartButton():void {
			
		}
		private function SetModifierOne():void {
			Modifier_Message.Text = "One";
		}
		private function SetModifierTwo():void {
			Modifier_Message.Text = "Two";
		}
		private function SetModifierThree():void {
			Modifier_Message.Text = "Three";
		}
		private function SetModifierFour():void {
			Modifier_Message.Text = "Four";
		}
	}
}