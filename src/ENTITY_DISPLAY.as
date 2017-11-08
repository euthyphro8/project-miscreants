package 
{
	
	import starling.display.MovieClip;
	import starling.utils.AssetManager;
	import starling.core.Starling;
	import starling.textures.Texture;
	import Extended.*;
	
	
	
	public class ENTITY_DISPLAY extends DISPLAY
	{
		
		private var Assets:AssetManager;
		public var Button_Init:int;
		public var Entity_Buttons:Vector.<E_BUTTON>;
		public var Anims:Vector.<MovieClip>;
		public var Game:MATCH_GAME_SCREEN;
		public var Number_Of_Ents:int = 12;
		
		public function ENTITY_DISPLAY(game:MATCH_GAME_SCREEN, assets:AssetManager, x:int, y:int) 
		{
			var config:XML = assets.getXml("Game");
			Anims = new Vector.<MovieClip>;
			this.Set_Position(x + 50, y + 50);
			this.Assets = assets;
			Game = game;
			
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
				b.Hide();
				Game.Pass_Pick();
				Start_Puff_Anim("default_", b.x, b.y);
			};
		}
		
		
		private function Start_Puff_Anim(type:String, x:int, y:int):void 
		{
			var frames:Vector.<Texture> = Assets.getTextures("puff_" + type);
			var anim:MovieClip = new MovieClip(frames, 10);
			Anims.push(anim);
			anim.scale = 0.5;
			anim.x = x - (anim.width / 2);
			anim.y = y - (anim.height / 2);
			anim.loop = false;
			Add_Children([anim]);
			Starling.juggler.add(anim);
			anim.play();
		}
		
		
		public function Update():void 
		{
			for (var i:int; i < Anims.length; i++)
			{
				var anim:MovieClip = Anims[i];
				if (anim.isComplete)
				{
					anim.stop();
					Starling.juggler.remove(anim);
					removeChild(anim)
					Anims.removeAt(i);
					i--;
				}
			}
		}
	}

}