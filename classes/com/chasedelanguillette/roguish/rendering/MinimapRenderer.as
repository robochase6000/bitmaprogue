///////////////////////////////////////////////////
//	MinimapRenderer
//	CREATED: 2009-10-02.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.rendering
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.defines.RenderDefines;
	import com.chasedelanguillette.roguish.maps.FloorMap;
	import com.chasedelanguillette.roguish.characters.Mobile;// Tue Nov  3 23:10:58 CST 2009 CMD TODO: change path!
	
	import com.chasedelanguillette.geom.SimpleRectangle;
	import com.chasedelanguillette.geom.SimplePoint;
	import com.chasedelanguillette.roguish.defines.Directions;
	
	
	
	import com.chasedelanguillette.roguish.objects.physicalObjects.PhysicalObject;
	import com.chasedelanguillette.roguish.objects.physicalObjects.living.LivingObject;
		
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class MinimapRenderer
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
		private var _oFloorMap:FloorMap;
		
		// MINIMAP BITMAP RENDERING
		private var _nMinimapScale:int 						= RenderDefines.MINIMAP_SCALE;
		private var _nMiniMapFillColor:uint 				= RenderDefines.MINIMAP_COLOR;//0xaa000000;
		private var _nMonsterColor:uint 					= RenderDefines.MINIMAP_MONSTER_COLOR;//0xffff0000;
		private var _nHeroColor:uint 						= RenderDefines.MINIMAP_HERO_COLOR;//0xffffffff;
		private var _nItemColor:uint						= RenderDefines.MINIMAP_ITEM_COLOR;
		
		private var _bmpdTileData:BitmapData;
		private var _bmpdSpriteData:BitmapData;
		
		private var _bmpTiles:Bitmap;		
		private var _bmpSprites:Bitmap;
		
		private var _oCopyPoint:Point = new Point(0,0);
		private var _oFillRectangle:Rectangle;
		private var _oBlipRectangle = new Rectangle(0,0,_nMinimapScale,_nMinimapScale);
		
		private var _nHeroFramesOn:int = 20;
		private var _nHeroFramesTotal:int = 30;
		private var _nHeroCurrentFrame:int = 0;
		
		
		private var _nMinimapTransparentFillColor:uint = 0x00000000;
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function MinimapRenderer(floorMap:FloorMap):void
		{
			_oFloorMap = floorMap;
			
			// make a bitmap minimap!
			var w:int = _oFloorMap.tiles[0].length * _nMinimapScale;
			var h:int = _oFloorMap.tiles.length * _nMinimapScale;

			
			// init bitmap datas!
			_bmpdTileData = new BitmapData(w, h, true, _nMinimapTransparentFillColor);
			_bmpdSpriteData = new BitmapData(w, h, true, _nMinimapTransparentFillColor);
			
			_bmpSprites = new Bitmap(_bmpdSpriteData);
			_bmpTiles = new Bitmap(_bmpdTileData);
			
			_oFillRectangle = new Rectangle(0, 0, w, h);
			
			vDrawTiles();
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		
		public function get bmpSprites():Bitmap
		{
			return _bmpSprites;
		};
		
		public function get bmpMiniMap():Bitmap{
			return _bmpTiles;
		}
		
		public function vUpdate():void
		{
			vClearCanvas();
			vDrawItems();
			vDrawMonsters();
		}
		
		public function vClearCanvas():void
		{
			//_bmpdMiniMap.fillRect(_oFillRectangle, 0x00000000);
			_bmpdSpriteData.fillRect(_oFillRectangle, 0x00000000);
		};
		
		public function vDrawTiles():void
		{
			//_oGameContainer.addChild(_bmpMiniMap);
			//_bmpMiniMap.x = (InitSystem.nStageWidth - _bmpdMiniMap.width) / 2;
			//_bmpMiniMap.y = (InitSystem.nStageHeight - _bmpdMiniMap.height) / 2;
						
			_oBlipRectangle.width = _nMinimapScale;
			_oBlipRectangle.height = _nMinimapScale;
			
			for (var i:int = 0; i < _oFloorMap.tiles.length * _nMinimapScale; i += 1 * _nMinimapScale)
			{
				for (var j:int = 0; j < _oFloorMap.tiles[0].length * _nMinimapScale; j += 1 * _nMinimapScale)
				{
					if ( _oFloorMap.tiles[i / _nMinimapScale][j / _nMinimapScale] == 1 ) {
						_oBlipRectangle.x = j;
						_oBlipRectangle.y = i;
						
						_bmpdTileData.fillRect(_oBlipRectangle, _nMiniMapFillColor);
					}
				}
			}
			
			if ( RenderDefines.MINIMAP_RENDER_WALLS ) renderWalls();
			
		};
		
		public function renderWalls():void
		{
			var minimapRegion:SimpleRectangle = new SimpleRectangle(0,0,_bmpdTileData.width,_bmpdTileData.height);
			var directionOffset:SimplePoint;
			var target:SimplePoint;
			
			for (var by:int = 0; by < _bmpdTileData.height; by++)
			{
				for (var bx:int = 0; bx < _bmpdTileData.width; bx++)
				{
					var nDirectionsChecked:int = 0;
					var bDone:Boolean = false;
					var bIsWall:Boolean = false;
					
					while(!bDone && nDirectionsChecked < Directions.TOTAL)
					{
						directionOffset = Directions.oGetOffsetsFromDirection(nDirectionsChecked);
						target = new SimplePoint(bx + directionOffset.x, by + directionOffset.y)
						
						if ( SimpleRectangle.containsPoint(minimapRegion, target) )
						{
							var pixel:uint = _bmpdTileData.getPixel(target.x, target.y);
							
							if ( pixel == _nMinimapTransparentFillColor )
							{
								bIsWall = true;
								bDone = true;
							}
							
						}
						
						nDirectionsChecked++;
					}
					
					if (bIsWall)
					{
						_bmpdTileData.setPixel(bx, by, RenderDefines.MINIMAP_WALL_COLOR);
					}
				}
			}
		}
		
		public function vDrawItems():void
		{
			//
			
			if (_oFloorMap.items != null)
			{
				_oBlipRectangle.width = _nMinimapScale - 2;
				_oBlipRectangle.height = _nMinimapScale - 2;
				for (var i:int = 0; i < _oFloorMap.items.length; i++)
				{
					var oItem:PhysicalObject = _oFloorMap.items[i] as PhysicalObject;
					var nFillColor:uint = _nItemColor;
					
					var tx:int = (oItem.oDimensions.x * _nMinimapScale) + 1;
					var ty:int = (oItem.oDimensions.y * _nMinimapScale) + 1;
					
					_oBlipRectangle.x = tx;
					_oBlipRectangle.y = ty;
					
					_bmpdSpriteData.fillRect(_oBlipRectangle, nFillColor);
					
					// free up the mobile reference for garbage collection
					oItem = null;
				}
				
			}
		};
		
		public function vDrawMonsters():void
		{
			//
			
			if (_oFloorMap.monsters != null)
			{
				_oBlipRectangle.width = _nMinimapScale - 2;
				_oBlipRectangle.height = _nMinimapScale - 2;
				for (var i:int = 0; i < _oFloorMap.monsters.length; i++)
				{
					var m:LivingObject = _oFloorMap.monsters[i] as LivingObject;
					var nFillColor:uint = _nMonsterColor;
					
					// for now
					if ( m.bIsFocused )
					{
						nFillColor = _nHeroColor;
						_nHeroCurrentFrame++;
						if ( _nHeroCurrentFrame > _nHeroFramesTotal ) _nHeroCurrentFrame = 0;
						if ( _nHeroCurrentFrame > _nHeroFramesOn ) nFillColor = 0x00000000;
					}
					
					var tx:int = (m.oDimensions.x * _nMinimapScale) + 1;
					var ty:int = (m.oDimensions.y * _nMinimapScale) + 1;
					
					_oBlipRectangle.x = tx;
					_oBlipRectangle.y = ty;
					
					_bmpdSpriteData.fillRect(_oBlipRectangle, nFillColor);
					
					// free up the mobile reference for garbage collection
					m = null;
				}
				
			}
		}

		
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