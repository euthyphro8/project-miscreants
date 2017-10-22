package {
	
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	
	import Events.LOADING_EVENT;
	import Extended.*;
	import starling.events.*;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class MATCH_MENU_SCREEN extends Sprite {
		
		private var Start_Message:E_TEXT;
		private var Modifier_Message:E_TEXT;
		
		private var Start_Button:E_BUTTON;
		private var Modifier_One_Button:E_BUTTON;
		private var Modifier_Two_Button:E_BUTTON;
		private var Modifier_Three_Button:E_BUTTON;
		private var Modifier_Four_Button:E_BUTTON;
		
		public function MATCH_MENU_SCREEN(game:GAME, assets:AssetManager) {
			var config:XML = assets.getXml("Game");
			
			Start_Message = new E_TEXT(assets, config.Menu.Start_Message);
			Start_Button = new E_BUTTON(assets, config.Game.Start_Button);
			Modifier_One_Button = new E_BUTTON(assets, config.Game.Modifier_One_Button);
			Modifier_Two_Button = new E_BUTTON(assets, config.Game.Modifier_Two_Button);
			Modifier_Three_Button = new E_BUTTON(assets, config.Game.Modifier_Three_Button);
			Modifier_Four_Button = new E_BUTTON(assets, config.Game.Modifier_Four_Button);
			
			Start_Message = new E_TEXT(config.Game.Start_Message);
			Modifier_Message = new E_TEXT(config.Game.Modifier_Message);
			
			addChild(Start_Button);
			addChild(Modifier_One_Button);
			addChild(Modifier_Two_Button);
			addChild(Modifier_Three_Button);
			addChild(Modifier_Four_Button);
			
			Start_Button.addEventListener(BUTTON.EVENT_TOUCHED, StartButton);
			Modifier_One_Button.addEventListener(BUTTON.EVENT_TOUCHED, ModifierButton(1));
			Modifier_Two_Button.addEventListener(BUTTON.EVENT_TOUCHED, ModifierButton(2));
			Modifier_Three_Button.addEventListener(BUTTON.EVENT_TOUCHED, ModifierButton(3));
			Modifier_Four_Button.addEventListener(BUTTON.EVENT_TOUCHED, ModifierButton(4));
			
		}
		
		private function StartButton() {
			//John will buy you a milkshake
		}
		private function ModifierButton(modifier:int) {
			
		}
	}
}