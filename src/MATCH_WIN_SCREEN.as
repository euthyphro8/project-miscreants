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
		
		public function MATCH_WIN_SCREEN(assets:AssetManager) 
		{
			var config:XML = assets.getXml("Game");
			
			
			
			var frames:Vector.<Texture> = assets.getTextures("puff_default_");
			puff = new MovieClip(frames, 10);
			
			
			
			Title = new E_TEXT(config.Win.Title);
			
			Title.Start_Flash(800, 400);
			Title.Font_Size = 100;
			
			Background_Image= new E_IMAGE(assets, config.Win.Background);
			
			Add_Children([ Background_Image, Title, puff]);
			
			
			
		}
	}
}