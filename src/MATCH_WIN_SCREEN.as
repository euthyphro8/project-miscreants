package 
{
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import Extended.*;
	
	public class MATCH_WIN_SCREEN extends DISPLAY 
	{
		
		public var Congrats:E_TEXT;
		public var Payout:E_TEXT;
		public var Background_Image:E_IMAGE;
		public var Puff:MovieClip;
		public var Firework:FIREWORK;
		public var Firework_Sound:SOUND;
		public var Background_Music:SOUND;
		
		public function MATCH_WIN_SCREEN(assets:AssetManager) 
		{
			var config:XML = assets.getXml("Game");
			var text_color:int = 0x1CB261;
			
			Background_Image= new E_IMAGE(assets, config.Win.Background);
			
			Congrats = new E_TEXT(config.Win.Congrats);
			
			Congrats.Start_Flash(800, 400);
			Congrats.Font_Size = 80;
			Congrats.Text_Format.color = text_color;
			
			
			Payout = new E_TEXT(config.Win.Payout);
			
			Payout.Font_Size = 150;
			Payout.Text_Format.color = text_color;
			
			
			Firework_Sound = new SOUND(assets.getSound("firework_sound"));
			Firework_Sound.Volume = 100;
			Background_Music = new SOUND(assets.getSound("background_music"));
			Background_Music.Volume = 50;
			
			
			Add_Children([ Background_Image, Congrats, Payout ]);
		}
		
		
		
		public function Update():void 
		{
			if (Firework) 
			{
				Firework.Update(1.0 / 60.0);
				if (!Firework.Alive) 
				{
					removeChild(Firework);
					Firework = generateFirework();
					addChild(Firework);
					Firework_Sound.Start();
					
				}	
			}
			else 
			{
				Firework = generateFirework();
				addChild(Firework);
				Firework_Sound.Start();
			}
			
		}
	
		public function generateFirework():FIREWORK
		{
			var x:Number = CONFIG::VIEWPORT_WIDTH * (0.8) + (Math.random() * 50 - 100);
			var y:Number = CONFIG::VIEWPORT_HEIGHT * (0.3) + (Math.random() * 50 - 100);
			var col:uint = (Math.random() * 4294967000) + 255;
			var texture:Texture = Texture.fromColor(3, 3, col, 1.0);
			//(x:Number, y:Number, speed:Number, life:Number, texture:Texture, size:int) 
			return new FIREWORK(x, y, 3, 0.3, texture, 1000);
		}
	}
}