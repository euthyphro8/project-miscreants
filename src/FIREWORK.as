package 
{
	import starling.textures.Texture;
	import starling.utils.Color;
	
	
	public class FIREWORK extends DISPLAY
	{
		public var Children:Vector.<PARTICLE>;
		public var zz:Number;
		public var Alive:Boolean;
		
		public function FIREWORK(x:Number, y:Number, speed:Number, life:Number, texture:Texture, size:int) 
		{	
			this.Alive = true;
			Set_Position(x, y);
			Children = new <PARTICLE>[];
			var gauss:MARSAGLIA = new MARSAGLIA();
			gauss.seed(Math.random() * 16807);
			var min:Number = 0.25;
			for (var i:int = 0; i < size; i++) 
			{
				
				var p:PARTICLE = new PARTICLE(x, y, Increase_Abs(gauss.standardNormal() * speed, min), Increase_Abs(gauss.standardNormal() * speed, min), texture, Math.abs(gauss.standardNormal() * life));
				Children[i] = p; 
				addChild(p.Pixel);
			}
		}
		public function Increase_Abs(x:Number, amt:Number):Number {
			return x < 0 ? x - amt : x + amt;
		}
		
		public function Update(delta:Number):void
		{
		  var deathCount:int = 0;
		  for(var i:int = 0; i < Children.length; i++) {
			var p:PARTICLE = Children[i];
			if(p == null) {
				deathCount++;
				continue;
			}
			p.xx -= p.xx * 0.045;
			p.yy -= p.yy * 0.045;
			p.Pixel.x += p.xx;
			p.Pixel.y += p.yy;
			p.Pixel.y += 0.6;
			p.Life -= delta;
			if (p.Life <= 0 || (p.xx == 0 && p.yy == 0)) {
				p.Life = 0;
				removeChild(p.Pixel);
				Children[i] = null;
			}
		}
		  if (deathCount >= Children.length)// - (Children.length * 0.025)) 
		  {
			for (i = 0; i < Children.length; i++)
			{
				if (Children[i]) 
					removeChild(Children[i].Pixel);
			}
			Alive = false;
		  }
		}
		
	}
}