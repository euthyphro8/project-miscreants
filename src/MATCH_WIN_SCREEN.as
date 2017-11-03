package 
{
	
	import starling.utils.AssetManager;
	import Extended.*;
	import starling.events.*;
	
	public class MATCH_WIN_SCREEN extends DISPLAY 
	{
		
		public var Title:E_TEXT;
		public var Background_Image:E_IMAGE;
		
		
		public function MATCH_WIN_SCREEN(assets:AssetManager) 
		{
			var config:XML = assets.getXml("Game");
			
			Title = new E_TEXT(config.Win.Title);
			
			Title.Start_Flash(800, 400);
			Title.Font_Size = 100;
			
			Background_Image= new E_IMAGE(assets, config.Win.Background);
			
			Add_Children([ Background_Image, Title]);
			
			
		}
	}
}