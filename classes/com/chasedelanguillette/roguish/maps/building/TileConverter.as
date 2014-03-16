///////////////////////////////////////////////////
//	TileConverter
//	CREATED: 2009-09-03.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.maps.building
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.maps.FloorMap;
	import com.chasedelanguillette.Bits;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.utils.getTimer;
	
	public class TileConverter extends Object
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public static const FLOOR_NONE:int 		= 0;
		public static const FLOOR_N:int			= Bits.BIT_01;
		public static const FLOOR_S:int			= Bits.BIT_02;
		public static const FLOOR_W:int			= Bits.BIT_03;
		public static const FLOOR_E:int			= Bits.BIT_04;

		public static const FLOOR_NE:int		= FLOOR_N | FLOOR_E;
		public static const FLOOR_NW:int		= FLOOR_N | FLOOR_W;
		public static const FLOOR_SE:int		= FLOOR_S | FLOOR_E;
		public static const FLOOR_SW:int		= FLOOR_S | FLOOR_W;

		public static const FLOOR_NSW:int		= FLOOR_N | FLOOR_S | FLOOR_W;
		public static const FLOOR_NSE:int		= FLOOR_N | FLOOR_S | FLOOR_E;
		public static const FLOOR_NEW:int		= FLOOR_N | FLOOR_E | FLOOR_W;
		public static const FLOOR_SEW:int		= FLOOR_S | FLOOR_E | FLOOR_W;
		
		public static const FLOOR_NSEW:int		= FLOOR_N | FLOOR_S | FLOOR_E | FLOOR_W;
		public static const FLOOR_NS:int		= FLOOR_N | FLOOR_S;
		public static const FLOOR_EW:int		= FLOOR_E | FLOOR_W;
		
		
		public static function bNeighborIsFloor(tx:int, ty:int, dirx:int, diry:int, map:Array):Boolean
		{
			var nx:int = tx + dirx;
			var ny:int = ty + diry;
			var n:int = -1;
			
			if ( nx >= 0 && nx < map[0].length - 1 && ny >= 0 && ny < map.length - 1 )
			{
				// valid neighbor
				n = map[ny][nx];
				switch (n)
				{
					case 1 :
						return true;
					break;
					default:
						return false;
					break;
				}
			}
			return false;
		}
		
		public static function vConvertMap(oFloorMap:FloorMap):void
		{
			var startTime:int;
			var endTime:int;
			startTime = getTimer();
			
			
			var w:int = oFloorMap.tiles[0].length;
			var h:int = oFloorMap.tiles.length
			
			for (var i:int = 0; i < h; i++)
			{
				for (var j:int = 0; j < w; j++)
				{
					var t:int = oFloorMap.tiles[i][j];
					
					// Thu Sep  3 13:00:53 CDT 2009 CMD TODO: if i and j are in a valid range!!!!
					switch(t)
					{
						case 1:// Thu Sep  3 12:38:58 CDT 2009 CMD TODO: map floor tile to constant
							
						break;
						case 3:
							// figure out how many neighbors are floors!
							var nNeighborsThatAreFloors:int = FLOOR_NONE;
							
							if ( bNeighborIsFloor(j, i, 0, -1, oFloorMap.tiles) )
							{
								nNeighborsThatAreFloors |= FLOOR_N;
							}
							if ( bNeighborIsFloor(j, i, 0, 1, oFloorMap.tiles) )
							{
								nNeighborsThatAreFloors |= FLOOR_S;	
							}
							if ( bNeighborIsFloor(j, i, 1, 0, oFloorMap.tiles) )
							{
								nNeighborsThatAreFloors |= FLOOR_E;
							}
							if ( bNeighborIsFloor(j, i, -1, 0, oFloorMap.tiles) )
							{
								nNeighborsThatAreFloors |= FLOOR_W;
							}
							
							switch (nNeighborsThatAreFloors)
							{
								// sealed
								case FLOOR_NSEW:
									oFloorMap.tiles[i][j] = t + 0;
								break;
								
								// cluster
								case FLOOR_NW:
									oFloorMap.tiles[i][j] = t + 1;
								break;
								case FLOOR_N:
									oFloorMap.tiles[i][j] = t + 2;
								break;
								case FLOOR_NE:
									oFloorMap.tiles[i][j] = t + 3;
								break;
								case FLOOR_W:
									oFloorMap.tiles[i][j] = t + 4;
								break;
								case FLOOR_NONE:
									oFloorMap.tiles[i][j] = t + 5;
								break;
								case FLOOR_E:
									oFloorMap.tiles[i][j] = t + 6;
								break;
								case FLOOR_SW:
									oFloorMap.tiles[i][j] = t + 7;
								break;
								case FLOOR_S:
									oFloorMap.tiles[i][j] = t + 8;
								break;
								case FLOOR_SE:
									oFloorMap.tiles[i][j] = t + 9;
								break;
								
								// parallels
								case FLOOR_EW:
									oFloorMap.tiles[i][j] = t + 10;
								break;
								case FLOOR_NS:
									oFloorMap.tiles[i][j] = t + 11;
								break;
								
								
								// 3 walls
								case FLOOR_NEW:
									oFloorMap.tiles[i][j] = t + 12;
								break;
								case FLOOR_NSE:
									oFloorMap.tiles[i][j] = t + 13;
								break;
								case FLOOR_SEW:
									oFloorMap.tiles[i][j] = t + 14;
								break;
								case FLOOR_NSW:
									oFloorMap.tiles[i][j] = t + 15;
								break;
							}
						break;
						
					}
				}
			}
			
			endTime = getTimer();
			trace("TileConverter.as::oGenerateFloorMap() -> tiles converted in " + (endTime - startTime) + " ms.");
			
		}

		
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