package 
{
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import Extended.*;
	
	public class MATCH_WIN_SCREEN extends DISPLAY 
	{
		
		public var Title:E_TEXT;
		public var Background_Image:E_IMAGE;
		public var puff:MovieClip;
		public var Firework:FIREWORK;
		
		public function MATCH_WIN_SCREEN(assets:AssetManager) 
		{
			var config:XML = assets.getXml("Game");
			
			Title = new E_TEXT(config.Win.Title);
			Background_Image= new E_IMAGE(assets, config.Win.Background);
			
			Title.Start_Flash(800, 400);
			Title.Font_Size = 100;
			
			
			Title.Text_Format.color = 0xFF0000;
			
			Add_Children([ Background_Image, Title]);
			
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
				}	
			}
			else 
			{
				Firework = generateFirework();
				addChild(Firework);
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