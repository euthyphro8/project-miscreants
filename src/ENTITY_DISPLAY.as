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
		
		//Background height is 720 (total height) - 180 (tier height)
		//Scaled 'dance floor zone' height is  207 = (adjusted background height / background heigt) * regular 'dance zone' height
		//Therefore the top of the 'dance floor zone' is 720 - 180 - 207 = 333
		public function ENTITY_DISPLAY(game:MATCH_GAME_SCREEN, assets:AssetManager, x:int, y:int) 
		{
			Assets = assets;
			Game = game;
			var config:XML = assets.getXml("Game");
			//For a standard normal dist
			var gauss:MARSAGLIA = new MARSAGLIA();
			gauss.seed(Math.random() * 16807);
			Anims = new Vector.<MovieClip>;
			Entities = new Vector.<ENTITY>;
			Button_Sounds = new <SOUND>[];
			
			for (var i:int = 0; i < 6; i++)
				Button_Sounds[i] = new SOUND(assets.getSound("button_sound_" + i));
			
			//For a pit of padding
			var hMargin:int = 30;
			var vMargin:int = 38 + 15
			//In order to uniformly distribute over the x range but randomly distribute over y
			var step:int = (int)((CONFIG::SCREEN_WIDTH - (2 * hMargin)) / Number_Of_Ents);
			//Height of the 'dance floor zone'
			var height:int = 207;
			//Min being top of the zone since zero is at the very top
			var yMin:int = CONFIG::SCREEN_HEIGHT - 180 - 207;
			//Add half of width of entity initially
			var x:int = hMargin + 37;
			var y:int = 0;
			for(i = 0; i < Number_Of_Ents; i++) {
				var e:ENTITY = new ENTITY(assets);
				Entities[i] = e;
				var rand:Number = Clamp((gauss.standardNormal() * 3) + 3, 0.0, 6.0);
				y =(rand * height / 6.0) + yMin - vMargin;
				Entities[i].Set_Position(x, y);
				x += step;
			
				trace("[ENTITY_DISPLAY] Entity placed at (" + x + ", " + y + ")");
				Entities[i].Entity_Button.addEventListener(BUTTON.EVENT_TOUCHED, Entity_Button_Event(Entities[i]));
				Add_Children([Entities[i]]);
			}
		}
		
		public function Clamp(value:Number, min:Number, max:Number):Number
		{
			if (value < min) return min;
			if (value > max) return max;
			return value;
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
				//Don't remove so we'll have more puffs in the final exit animation
				//Entities.removeAt(Entities.indexOf(ent));
			};
		}
		public function Remove_All():void
		{
			//For each (hidden or shown) remove from list and generate a anim puff where it was.
			while (Entities.length > 0)
			{
				Start_Puff_Anim("default_", Entities[0].x, Entities[0].y);
				Entities[0].RemoveEntity();
				Entities.removeAt(0);
			}
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
