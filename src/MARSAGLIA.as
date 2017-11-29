package 
{
	/**
	 * @see http://blog.controul.com/2009/04/standard-normal-distribution-in-as3/
	 */
	public class MARSAGLIA 
	{		
		/**
		 *	Seeds the prng.
		 */
		private var s : int;
		public function seed ( seed : uint ) : void
		{
			s = seed > 1 ? seed % 2147483647 : 1;
		}

		/**
		 *	Returns a Number ~ U(0,1)
		 */
		public function uniform () : Number
		{
			return ( ( s = ( s * 16807 ) % 2147483647 ) / 2147483647 );
		}
		/**
		 *	Returns a Number ~ N(0,1);
		 */
		private var ready : Boolean;
		private var cache : Number;
		public function standardNormal () : Number
		{
			if ( ready )
			{				//  Return a cached result
				ready = false;		//  from a previous call
				return cache;		//  if available.
			}

			var	x : Number,		//  Repeat extracting uniform values
				y : Number,		//  in the range ( -1,1 ) until
				w : Number;		//  0 < w = x*x + y*y < 1
			do
			{
				x = ( s = ( s * 16807 ) % 2147483647 ) / 1073741823.5 - 1;
				y = ( s = ( s * 16807 ) % 2147483647 ) / 1073741823.5 - 1;
				w = x * x + y * y;
			}
			while ( w >= 1 || !w );

			w = Math.sqrt ( -2 * Math.log ( w ) / w );

			ready = true;
			cache = x * w;			//  Cache one of the outputs
			return y * w;			//  and return the other.
		}
	}

}