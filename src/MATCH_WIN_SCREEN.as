package 
{
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import Extended.*;
	
	public class MATCH_WIN_SCREEN extends DISPLAY 
	{
		
		public var Title:E_TEXT;
		public var Title2:E_TEXT;
		public var Background_Image:E_IMAGE;
		public var puff:MovieClip;
		
		public function MATCH_WIN_SCREEN(assets:AssetManager) 
		{
			var config:XML = assets.getXml("Game");
			
			Title = new E_TEXT(config.Win.Title);
			Title2 = new E_TEXT(config.Win.Title);
			
			Title.Start_Flash(800, 400);
			Title2.Start_Flash(800, 400);
			
			Title.Font_Size = 100;
			Title2.Borders_Visible = true;
			
			
			Title.Text_Format.color = 0xFF0000;
			Title2.Text_Format.color = 0xFF0BA0;
			
			Background_Image= new E_IMAGE(assets, config.Win.Background);
			
			Add_Children([ Background_Image, Title, Title2]);
			
		}
	}
}