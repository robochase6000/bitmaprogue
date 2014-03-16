///////////////////////////////////////////////////
//	RenderDefines
//	CREATED: 2009-08-11.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.defines
{	
	public class RenderDefines
	{
		
		/// BITMAP RENDERING DEFS
		public static const BITMAP_RENDERING_ENABLED:Boolean = true;
		
		public static const TILE_WIDTH:int = 32;
		public static const TILE_HEIGHT:int = 32;
		
		
		public static const MINIMAP_SCALE:int = 6;// each tile in the minimap will be this many pixels big.
		public static const MINIMAP_COLOR:uint = 0xcc003333;
		public static const MINIMAP_RENDER_WALLS:Boolean = false;
		public static const MINIMAP_WALL_COLOR:uint = 0xFFaaaaaa;
		
		public static const MINIMAP_MONSTER_COLOR:uint = 0xffaa0000;
		public static const MINIMAP_HERO_COLOR:uint = 0xffffffff;
		public static const MINIMAP_ITEM_COLOR:uint = 0xff00aaaa;
		
		
		/// VECTOR DEFS
		public static const VECTOR_MINIMAP_TILE_WIDTH:int = 4;
		public static const VECTOR_MINIMAP_TILE_HEIGHT:int = 4;
		public static const VECTOR_MINIMAP_TILE_SPACING:int = 0;
		
		public static const VECTOR_MAP_TILE_WIDTH:int = 4;
		public static const VECTOR_MAP_TILE_HEIGHT:int = 4;
		
		
		public static const RENDER_LAYER_TILES:int = 0;
		public static const RENDER_LAYER_TRAPS:int = 1;
		public static const RENDER_LAYER_ITEMS:int = 2;
		public static const RENDER_LAYER_MONSTERS:int = 4;
		public static const RENDER_LAYER_TOTAL:int = 5;
		
	}
}