package 
{
	
	import starling.core.Starling;
	import Extended.E_BUTTON;
	import starling.display.MovieClip;
	import starling.utils.AssetManager;	
	import starling.textures.Texture;
	import Extended.*;
	
	public class ENTITY extends DISPLAY
	{
		
		public var Entity_Button:E_BUTTON;
		public var Anim:MovieClip;
		
		public function ENTITY(assets:AssetManager) 
		{
			var config:XML = assets.getXml("Game");
			Start_Dance_Anim(assets, "default_");
			Entity_Button = (new E_BUTTON(assets, config.Tier.ChibiCoin));
			Add_Children([Entity_Button]);
			
		}
		
		
		private function Start_Dance_Anim(assets:AssetManager, type:String):void 
		{
			var frames:Vector.<Texture> = assets.getTextures("dancing_" + type);
			Anim = new MovieClip(frames, 10);
			Anim.loop = true;
			Anim.x = x - (Anim.width / 2);
			Anim.y = y - (Anim.height / 2);
			
			Anim.scale = 0.3;
			//Set Color if possible
			Add_Children([Anim]);
			Starling.juggler.add(Anim);
			Anim.play();
		}
		
		
		
		public function RemoveEntity():void{
			this.removeFromParent();
		}
	}

}