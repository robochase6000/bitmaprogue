package com.chasedelanguillette.utils
{
	import flash.display.BitmapData;
	
	public class BitmapDataUtils
	{
		public static function bresenham( output:BitmapData, x0: int, y0: int, x1: int, y1: int, value: int ): void
		{
			var error: int;

			var dx: int = x1 - x0;
			var dy: int = y1 - y0;

			var yi: int = 1;

			if( dx < dy )
			{
				//-- swap end points
				x0 ^= x1; x1 ^= x0; x0 ^= x1;
				y0 ^= y1; y1 ^= y0; y0 ^= y1;
			}

			if( dx < 0 )
			{
				dx = -dx; yi = -yi;
			}

			if( dy < 0 )
			{
				dy = -dy; yi = -yi;
			}

			if( dy > dx )
			{
				error = -( dy >> 1 );

				for( ; y1 < y0+1 ; y1++ )
				{
					output.setPixel32( x1, y1, value );
					error += dx;
					if( error > 0 )
					{
						x1 += yi;
						error -= dy;
					}
				}
			}
			else
			{
				error = -( dx >> 1 );

				for( ; x0 < x1+1 ; x0++ )
				{
					output.setPixel32( x0, y0, value );
					error += dy;
					if( error > 0 )
					{
						y0 += yi;
						error -= dx;
					}
				}
			}
		}
		
		/**
		* @param outputFunction set custom function to use for outputting yr pixels.  should be outputFunction(x, y, color)
		*/
		public static function bresenhamCustomOutput( output:BitmapData, x0: int, y0: int, x1: int, y1: int, value: int, outputFunction:Function ): void
		{
			var error: int;

			var dx: int = x1 - x0;
			var dy: int = y1 - y0;

			var yi: int = 1;

			if( dx < dy )
			{
				//-- swap end points
				x0 ^= x1; x1 ^= x0; x0 ^= x1;
				y0 ^= y1; y1 ^= y0; y0 ^= y1;
			}

			if( dx < 0 )
			{
				dx = -dx; yi = -yi;
			}

			if( dy < 0 )
			{
				dy = -dy; yi = -yi;
			}

			if( dy > dx )
			{
				error = -( dy >> 1 );

				for( ; y1 < y0+1 ; y1++ )
				{
					//output.setPixel32( x1, y1, value );
					outputFunction(x1, y1, value);
					error += dx;
					if( error > 0 )
					{
						x1 += yi;
						error -= dy;
					}
				}
			}
			else
			{
				error = -( dx >> 1 );

				for( ; x0 < x1+1 ; x0++ )
				{
					//output.setPixel32( x0, y0, value );
					outputFunction(x0, y0, value);
					
					error += dy;
					if( error > 0 )
					{
						y0 += yi;
						error -= dx;
					}
				}
			}
		}
		
		public function returnRGB(r:uint, g:uint, b:uint):uint
		{
			var rgb:uint = 0;
			rgb += (r << 16);
			rgb += (g << 8);
			rgb += (b);
			return rgb;
		}
		
		public function returnARGB(a:uint, r:uint, g:uint, b:uint):uint
		{
			var argb:uint = 0;
			argb += (a << 24);
			argb += (r << 16);
			argb += (g << 8);
			argb += (b);
			return argb;
		}
	}
}