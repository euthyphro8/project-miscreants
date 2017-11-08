package 
{
	import Extended.*;
	import flash.events.TouchEvent;
	import starling.utils.AssetManager;
	
	
	public class ENTITY_DISPLAY extends DISPLAY
	{
		
		public var Button_Init:int;
		public var Entity_Buttons:Vector.<E_BUTTON>;
		public var Game:MATCH_GAME_SCREEN;
		public var Number_Of_Ents:int = 12;
		public var Button_Sounds:Vector.<SOUND>;
		//public var Button_Sound:SOUND;
		
		
		public function ENTITY_DISPLAY(game:MATCH_GAME_SCREEN, assets:AssetManager, x:int, y:int) 
		{
			var config:XML = assets.getXml("Game");
			this.Set_Position(x+50, y+50);
			Game = game;
			
			//Button_Sound = new SOUND(assets.getSound("button_sound_0"));
			Button_Sounds = new <SOUND>[];
			for (var i:int = 0; i < 6; i++){
			Button_Sounds[i] = new SOUND(assets.getSound("button_sound_" + i));
			}
			
			Entity_Buttons = new <E_BUTTON>[];
			for (var i:int = 0; i < Number_Of_Ents; i++) {
				Entity_Buttons[i] = (new E_BUTTON(assets, config.Entity.Entity_Button));
				//Entity_Buttons[i].Set_Position(i * 50, 50*(Math.random()*10));
				Entity_Buttons[i].Set_Position(i*100,100*(Math.random()*4));
				Entity_Buttons[i].scale = (100. / 500);
				Entity_Buttons[i].addEventListener(BUTTON.EVENT_TOUCHED, Entity_Button_Event(Entity_Buttons[i]));
				Add_Children([Entity_Buttons[i]]);
			}
		}
		
		
		public function Entity_Button_Event(b:E_BUTTON):Function
		{
			return function():void
			{
				//reveal current entity_tier and fill in a bubble
				Button_Sounds[(int)(Math.random() * 6)].Start();
				//Button_Sound.Start();
				b.Hide();
				Game.Pass_Pick();
			};
		}
	}

}