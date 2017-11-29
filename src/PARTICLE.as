package 
{
	import starling.display.Canvas;
	import starling.textures.Texture;
	
	public class PARTICLE
	{
		public var Life:Number;
		public var Pixel:IMAGE;
		public var xx:Number;
		public var yy:Number;
		public function PARTICLE(x:Number, y:Number, xx:Number, yy:Number, texture:Texture, life:Number)
		{
			Pixel = new IMAGE(texture);
			this.xx = xx;
			this.yy = yy;
			Life = life;
		}
	}

}