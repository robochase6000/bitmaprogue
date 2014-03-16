///////////////////////////////////////////////////
//	MersenneTwister
//	CREATED: 2009-08-28.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.utils
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	import com.chasedelanguillette.utils.NumberUtils;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class MersenneTwister
	{
		
		public static const SEED_MAX:int = Math.pow(2, 32);
		
		//============================================
		//	INSTANCED VERSION
		//============================================

		private var _MT:Array = new Array();
		private var _y:Number, _z:Number = 0;
		private var _step:Number = 0;
		
		public function MersenneTwister(seed:Number):void
		{
			_MT[0] = seed;
			for (var i:int = 1; i < 623; i++)
			{
				_MT[i] = ((0x10dcd * _MT[i-1]) + 1) & 0xFFFFFFF;
			}
		};
		
		public function get step():Number{
			return _step;
		}
		
		public function nExtractNumber(i:Number):Number
		{
			_y = _MT[i];
			_y ^= (_y>>11);
			_y ^= (_y<<7) & 0x9d2c5680;
			_y ^= (_y<<15) & 0xefc60000;
			_y ^= (_y>>18);
			return _y;
		};
		
		public function nGenerateRandomNumber():Number
		{
			_step++;
			if ( _z >= 623 )
			{
				vGenerateNumbers();
			}
			return nExtractNumber(_z++);
		};
		
		private function vGenerateNumbers():void
		{
			_z = 0;
			for (var i:int = 0; i < 623; i++)
			{
				_y = 0x80000000 & _MT[i] + 0x7FFFFFFF & (_MT[(i+1) %624]);
				if ((y % 2) == 0)
				{
					_MT[i] = _MT[(i+397) %624]^(_y>>1);
				}
				else
				{
					_MT[i] = _MT[(i + 397) % 624] ^ (_y>>1) ^ 0x9908B0DF;
				}
			}
		};
		
		//============================================
		//	STATIC VERSION
		//============================================

		public static function nGenerateRandomFloatFromInstance(oMersenneTwisterInstance:MersenneTwister):Number
		{
			return oMersenneTwisterInstance.nGenerateRandomNumber() / 0x7FFFFFFF;
		};
		
		private static var MT:Array = new Array();
		private static var y:Number, z:Number = 0;
		
		public static function initializeGenerator(seed:Number):void
		{
			MT[0] = seed;
			for (var i:int = 1; i < 623; i++)
			{
				MT[i] = ((0x10dcd * MT[i-1]) + 1) & 0xFFFFFFF
			}
		};
		
		private static function generateNumbers():void
		{
			z = 0;
			for (var i:int = 0; i < 623; i++)
			{
				y = 0x80000000 & MT[i] + 0x7FFFFFFF & (MT[(i+1) %624]);
				if ((y % 2) == 0)
				{
					MT[i] = MT[(i+397) %624]^(y>>1);
				}
				else
				{
					MT[i] = MT[(i + 397) % 624] ^ (y>>1) ^ 0x9908B0DF;
				}
			}
		}
		
		public static function extractNumber(i:Number):Number
		{
			y = MT[i];
			y ^= (y>>11);
			y ^= (y<<7) & 0x9d2c5680;
			y ^= (y<<15) & 0xefc60000;
			y ^= (y>>18);
			return y;
		};
		
		public static function generateRandomNumber():Number
		{
			if ( z >= 623 )
			{
				generateNumbers();
			}
			return extractNumber(z++);
		};	
	}
}