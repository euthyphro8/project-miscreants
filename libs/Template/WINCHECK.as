// ---------------------------------------
//	Casino Game Maker, Inc.
// ---------------------------------------

package
{
	import Roulette.ROULETTE_BETS;
	
	public class WINCHECK
	{		
		private var Win:int;
		private var RNG:int;
		private var Par_Sheet:XML;
		private var Game:GAME;
		
		public function WINCHECK(game:GAME)
		{
			Game 		= game;
			Par_Sheet 	= Game.Assets.getXml("Math");
		}
		
		public function Process_Win(rng:int, wagers:ROULETTE_BETS):int
		{
			Win = 0;
			RNG = rng;
			var len:uint = uint(Par_Sheet.Percentage.Pays.Pay.length());
			
			for(var i:uint = 0; i < len; i++)
			{
				var num:Array 		= Par_Sheet.Percentage.Pays.Pay[i].@Numbers.split(",");
				var num_len:uint 	= num.length;
				
				for(var j:uint = 0; j < num_len; j++)
				{
					var wager_amount:uint = wagers.Get_Wager(Par_Sheet.Percentage.Pays.Pay[i].@Type, Par_Sheet.Percentage.Pays.Pay[i].@ID);
					if((num[j] == RNG) && (wager_amount > 0))
					{
						Win += wager_amount * uint(Par_Sheet.Percentage.Pays.Pay[i].@Mulitiplier);
					}
				}
			}
			
			return Win;
		}
		
		public function Get_Win():int
		{
			return Win;
		}
	}
}