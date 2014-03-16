///////////////////////////////////////////////////
//	TileDefines
//	CREATED: 2009-08-16.
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
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class TileDefines
	{
		public static const TILE_ROOM:int 			= 0;
		public static const TILE_HALL:int 			= 1;
		public static const TILE_SECRET_HALL:int 	= 2;
		public static const TILE_WALL:int 			= 3;
		public static const TILE_WATER:int 			= 4;
		public static const TILE_SECRET_ROOM:int 	= 5;
		
		public static const tileType_0:Object	= {type:TILE_ROOM, 			desc:"Room", 			color:0xaa0000};
		public static const tileType_1:Object 	= {type:TILE_HALL, 			desc:"Hall",			color:0xffffff};
		public static const tileType_2:Object 	= {type:TILE_SECRET_HALL, 	desc:"Secret Hall",		color:0x666666};
		public static const tileType_3:Object	= {type:TILE_WALL, 			desc:"Wall",			color:0x333333};
		public static const tileType_4:Object 	= {type:TILE_WATER, 		desc:"Water",			color:0x0000cc};
		public static const tileType_5:Object 	= {type:TILE_SECRET_ROOM, 	desc:"Secret Room",		color:0x00cc00};
		public static const tileTypes:Array 	= [tileType_0, tileType_1, tileType_2, tileType_3, tileType_4, tileType_5];
		
	}
}