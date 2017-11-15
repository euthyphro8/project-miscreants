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
		public var Entities:Vector.<ENTITY>;
		public var Anims:Vector.<MovieClip>;
		public var Game:MATCH_GAME_SCREEN;
		public var Number_Of_Ents:int = 12;
		public var Button_Sounds:Vector.<SOUND>;
		//public var Button_Sound:SOUND;
		
		
		public function ENTITY_DISPLAY(game:MATCH_GAME_SCREEN, assets:AssetManager, x:int, y:int) 
		{
			var config:XML = assets.getXml("Game");
			Anims = new Vector.<MovieClip>;
		//	this.Set_Position(x + 50, y + 50);
			this.Assets = assets;
			Game = game;
			
			//Button_Sound = new SOUND(assets.getSound("button_sound_0"));
			Button_Sounds = new <SOUND>[];
			for (var i:int = 0; i < 6; i++){
			Button_Sounds[i] = new SOUND(assets.getSound("button_sound_" + i));
			}
			
			Entities = new Vector.<ENTITY>;
			for (i = 0; i < Number_Of_Ents; i++) {
				Entities[i] = new ENTITY(assets);
				//Entities[i].Entity_Button = (new E_BUTTON(assets, config.Tier.ChibiCoin));
				//Entities[i].Set_Position(i * 50, 50*(Math.random()*10));
				Entities[i].Set_Position(i*100,100*(Math.random()*4));
				//Entities[i].scale = (100. / 500);
				Entities[i].Entity_Button.addEventListener(BUTTON.EVENT_TOUCHED, Entity_Button_Event(Entities[i]));
				Add_Children([Entities[i]]);
			}
		}
		
		
		public function Entity_Button_Event(ent:ENTITY):Function
		{
			return function():void
			{
				//reveal current entity_tier and fill in a bubble
				Button_Sounds[(int)(Math.random() * 6)].Start();
				//Button_Sound.Start();
				ent.RemoveEntity();
				Game.Pass_Pick();
				Start_Puff_Anim("default_", ent.x, ent.y);
			};
		}
		
		
		private function Start_Puff_Anim(type:String, x:int, y:int):void 
		{
			var frames:Vector.<Texture> = Assets.getTextures("puff_" + type);
			var anim:MovieClip = new MovieClip(frames, 10);
			Anims.push(anim);
			anim.scale = 0.6;
			anim.x = x - (anim.width / 2);
			anim.y = y - (anim.height / 2);
			anim.loop = false;
			//Set Color if possible
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
					removeChild(anim);
					
					Starling.juggler.remove(anim);
					Anims.removeAt(i);
					i--;
				}
			}
		}
	}

}