///////////////////////////////////////////////////
//	Directions
//	CREATED: 2009-09-29.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.defines
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.Bits;
	import com.chasedelanguillette.geom.SimplePoint;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class Directions
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		/*
		case Directions.SOUTH:

		break;
		case Directions.SOUTH_EAST:

		break;
		case Directions.EAST:

		break;
		case Directions.NORTH_EAST:

		break;
		case Directions.NORTH:

		break;
		case Directions.NORTH_WEST:

		break;
		case Directions.WEST:

		break;
		case Directions.SOUTH_WEST:

		break;
		
		*/
		
		public static const SOUTH:int = 0;
		public static const SOUTH_EAST:int = 1;
		public static const EAST:int = 2;
		public static const NORTH_EAST:int = 3;
		public static const NORTH:int = 4;
		public static const NORTH_WEST:int = 5;
		public static const WEST:int = 6;
		public static const SOUTH_WEST:int = 7;
		public static const TOTAL:int = 8;
		
		public static const M_FLOOR_NONE:int 		= 0;
		public static const M_FLOOR_N:int			= Bits.BIT_01;
		public static const M_FLOOR_S:int			= Bits.BIT_02;
		public static const M_FLOOR_W:int			= Bits.BIT_03;
		public static const M_FLOOR_E:int			= Bits.BIT_04;

		public static const M_FLOOR_NE:int		= Directions.M_FLOOR_N | Directions.M_FLOOR_E;
		public static const M_FLOOR_NW:int		= Directions.M_FLOOR_N | Directions.M_FLOOR_W;
		public static const M_FLOOR_SE:int		= Directions.M_FLOOR_S | Directions.M_FLOOR_E;
		public static const M_FLOOR_SW:int		= Directions.M_FLOOR_S | Directions.M_FLOOR_W;
		
		public static const M_FLOOR_NSW:int		= Directions.M_FLOOR_N | Directions.M_FLOOR_S | Directions.M_FLOOR_W;
		public static const M_FLOOR_NSE:int		= Directions.M_FLOOR_N | Directions.M_FLOOR_S | Directions.M_FLOOR_E;
		public static const M_FLOOR_NEW:int		= Directions.M_FLOOR_N | Directions.M_FLOOR_E | Directions.M_FLOOR_W;
		public static const M_FLOOR_SEW:int		= Directions.M_FLOOR_S | Directions.M_FLOOR_E | Directions.M_FLOOR_W;

		public static const M_FLOOR_NSEW:int	= Directions.M_FLOOR_N | Directions.M_FLOOR_S | Directions.M_FLOOR_E | Directions.M_FLOOR_W;
		public static const M_FLOOR_NS:int		= Directions.M_FLOOR_N | Directions.M_FLOOR_S;  
		public static const M_FLOOR_EW:int		= Directions.M_FLOOR_E | Directions.M_FLOOR_W;
		
		public static const M_DIAGONALS:int 	= Directions.M_FLOOR_NE | Directions.M_FLOOR_NW | Directions.M_FLOOR_SE | Directions.M_FLOOR_SW;;
		
		public static const M_OMNI_DIRECTIONAL:int = Directions.M_FLOOR_NSEW | Directions.M_DIAGONALS;
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public static function nRemoveDirectionFromMask(nDirectionId:int, nMask:int):int
		{
			var nDirectionAsMask:int =  nGetBitmaskFromDirection(nDirectionId);
			nMask ^= ~nDirectionAsMask;
			return nMask;
		}
		
		public static function nBuildDirectionMask(changex:int, changey:int):int
		{
			var dir:int = Directions.M_FLOOR_NONE;
			if ( changex > 0 )
			{
				dir |= M_FLOOR_E;
			}
			else if ( changex < 0 )
			{
				dir |= M_FLOOR_W;
			}
			
			if ( changey > 0 )
			{
				dir |= M_FLOOR_S;
			}
			else if (changey < 0)
			{
				dir |= M_FLOOR_N;
			}
			return dir
		};
		
		public static function nGetBitmaskFromDirection(nDirection:int):int
		{
			switch(nDirection)
			{
				case NORTH:		
					return Directions.M_FLOOR_N;
				break;
				case SOUTH:		
					return Directions.M_FLOOR_S;
				break;
				case WEST:		
					return Directions.M_FLOOR_W;
				break;
				case EAST:
					return Directions.M_FLOOR_E;
				break;
				case NORTH_EAST:
					return Directions.M_FLOOR_NE;
				break;
				case NORTH_WEST:
					return Directions.M_FLOOR_NW;
				break;
				case SOUTH_EAST:
					return Directions.M_FLOOR_SE;
				break;
				case SOUTH_WEST:		
					return Directions.M_FLOOR_SW;
				break;
			}
			return -1;
		}
		
		public static function nGetEnumeratedDirectionFromMask(nDirection:int):int
		{
			switch(nDirection)
			{
				case M_FLOOR_N:		
					return Directions.NORTH;
				break;
				case M_FLOOR_S:		
					return Directions.SOUTH;
				break;
				case M_FLOOR_W:		
					return Directions.WEST;
				break;
				case M_FLOOR_E:
					return Directions.EAST;
				break;
				case M_FLOOR_NE:
					return Directions.NORTH_EAST;
				break;
				case M_FLOOR_NW:
					return Directions.NORTH_WEST;
				break;
				case M_FLOOR_SE:
					return Directions.SOUTH_EAST;
				break;
				case M_FLOOR_SW:		
					return Directions.SOUTH_WEST;
				break;
			}
			return -1;
		}
		
		public static function oGetOffsetsFromDirection(nDirection:int):SimplePoint
		{
			var m:SimplePoint = new SimplePoint(0,0);
			switch(nDirection)
			{
				case Directions.SOUTH:
					m.y = 1;
				break;
				case Directions.SOUTH_EAST:
					m.x = 1;
					m.y = -1;
				break;
				case Directions.EAST:
					m.x = 1;
				break;
				case Directions.NORTH_EAST:
					m.x = 1;
					m.y = -1
				break;
				case Directions.NORTH:
					m.y = -1
				break;
				case Directions.NORTH_WEST:
					m.x = -1
					m.y = -1
				break;
				case Directions.WEST:
					m.x = -1
				break;
				case Directions.SOUTH_WEST:
					m.x = -1
					m.y = 1
				break;
			}
			return m;
		};
		
		public static function nGetNewDirection_RotateClockwise(nDirection:int, nAngle:int):int
		{
			switch(nDirection)
			{
				case Directions.SOUTH:
					switch(nAngle)
					{
						case 45 :
							return Directions.SOUTH_WEST
						break;
						case 90 :
							return Directions.WEST
						break;
						case 135 :
							return Directions.NORTH_WEST
						break;
						case 180 :
							return Directions.NORTH
						break;
						case 225 :
							return Directions.NORTH_EAST
						break;
						case 270 :
							return Directions.EAST
						break;
						case 315 :
							return Directions.SOUTH_EAST
						break;
					}
				break;
				case Directions.SOUTH_EAST:
					switch(nAngle)
					{
						case 45 :
							return Directions.SOUTH
						break;
						case 90 :
							return Directions.SOUTH_WEST
						break;
						case 135 :
							return Directions.WEST
						break;
						case 180 :
							return Directions.NORTH_WEST
						break;
						case 225 :
							return Directions.NORTH
						break;
						case 270 :
							return Directions.NORTH_EAST
						break;
						case 315 :
							return Directions.EAST
						break;
					}
				break;
				case Directions.EAST:
					switch(nAngle)
					{
						case 45 :
							return Directions.SOUTH_EAST
						break;
						case 90 :
							return Directions.SOUTH
						break;
						case 135 :
							return Directions.SOUTH_WEST
						break;
						case 180 :
							return Directions.WEST
						break;
						case 225 :
							return Directions.NORTH_WEST
						break;
						case 270 :
							return Directions.NORTH
						break;
						case 315 :
							return Directions.NORTH_EAST
						break;
					}
				break;
				case Directions.NORTH_EAST:
					switch(nAngle)
					{
						case 45 :
							return Directions.EAST
						break;
						case 90 :
							return Directions.SOUTH_EAST
						break;
						case 135 :
							return Directions.SOUTH
						break;
						case 180 :
							return Directions.SOUTH_WEST
						break;
						case 225 :
							return Directions.WEST
						break;
						case 270 :
							return Directions.NORTH_WEST
						break;
						case 315 :
							return Directions.NORTH
						break;
					}
				break;
				case Directions.NORTH:
					switch(nAngle)
					{
						case 45 :
							return Directions.NORTH_EAST
						break;
						case 90 :
							return Directions.EAST
						break;
						case 135 :
							return Directions.SOUTH_EAST
						break;
						case 180 :
							return Directions.SOUTH
						break;
						case 225 :
							return Directions.SOUTH_WEST
						break;
						case 270 :
							return Directions.WEST
						break;
						case 315 :
							return Directions.NORTH_WEST
						break;
					}
				break;
				case Directions.NORTH_WEST:
					switch(nAngle)
					{
						case 45 :
							return Directions.NORTH
						break;
						case 90 :
							return Directions.NORTH_EAST
						break;
						case 135 :
							return Directions.EAST
						break;
						case 180 :
							return Directions.SOUTH_EAST
						break;
						case 225 :
							return Directions.SOUTH
						break;
						case 270 :
							return Directions.SOUTH_WEST
						break;
						case 315 :
							return Directions.WEST
						break;
					}
				break;
				case Directions.WEST:
					switch(nAngle)
					{
						case 45 :
							return Directions.NORTH_WEST
						break;
						case 90 :
							return Directions.NORTH
						break;
						case 135 :
							return Directions.NORTH_EAST
						break;
						case 180 :
							return Directions.EAST
						break;
						case 225 :
							return Directions.SOUTH_EAST
						break;
						case 270 :
							return Directions.SOUTH
						break;
						case 315 :
							return Directions.SOUTH_WEST
						break;
					}
				break;
				case Directions.SOUTH_WEST:
					switch(nAngle)
					{
						case 45 :
							return Directions.WEST
						break;
						case 90 :
							return Directions.NORTH_WEST
						break;
						case 135 :
							return Directions.NORTH
						break;
						case 180 :
							return Directions.NORTH_EAST
						break;
						case 225 :
							return Directions.EAST
						break;
						case 270 :
							return Directions.SOUTH_EAST
						break;
						case 315 :
							return Directions.SOUTH
						break;
					}
				break;
			}
			return nDirection;
		}

		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function Directions():void
		{
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		
		
		//////////////////////////////////////////////
		//
		//	GETTERS
		//
		//////////////////////////////////////////////
		
		
		
		//////////////////////////////////////////////
		//
		//	SETTERS
		//
		//////////////////////////////////////////////
		
		
		
		//////////////////////////////////////////////
		//
		//	EVENT HANDLERS
		//
		//////////////////////////////////////////////
		
		
		
		//////////////////////////////////////////////
		//
		//	PRIVATE METHODS
		//
		//////////////////////////////////////////////
		
		
	}
}