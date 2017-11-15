package 
{
	import Extended.E_BUTTON;
	import Extended.E_IMAGE;
	import Extended.E_TEXT;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import Extended.*;
	
	public class MATCH_INFO_SCREEN extends DISPLAY
	{
		private var Info:E_TEXT;
		private var Title:E_TEXT;
		private var Begin:E_BUTTON;
		private var Background:E_IMAGE;
		
		
		public function MATCH_INFO_SCREEN(assets:AssetManager) 
		{
			var config:XML = assets.getXml("Game");
			
			Title = new E_TEXT(config.Info.Title);
			Info = new E_TEXT(config.Info.Info_Button);
			Begin = new E_BUTTON(assets, config.Info.Begin);
			Background= new E_IMAGE(assets, config.Info.Background);
			
			Title.Text_Format.color = 0;
			Title.Text_Format.size = 35;
			
			Info.Text_Format.color = 0;
			Info.Text_Format.size = 35;
			
			Begin.Text_Format.color = 0;
			Begin.Text_Format.size = 35;			
			
			Add_Children([Background, Title, Info, Begin]);
			Begin.addEventListener(BUTTON.EVENT_RELEASED, BeginGame);
			
		}
		
		public function BeginGame():void 
		{
			Begin.Text = "Resume";
			GAME.Screen_State = 3;
			GAME.Has_State_Changed = true;
		}
		
		
	}

}