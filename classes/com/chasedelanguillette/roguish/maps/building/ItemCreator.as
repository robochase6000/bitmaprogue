///////////////////////////////////////////////////
//	ItemCreator
//	CREATED: 2009-08-23.
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
	import com.chasedelanguillette.roguish.editor.roomEditor.MapData;

	import com.chasedelanguillette.roguish.characters.Mobile;
	import com.chasedelanguillette.roguish.maps.FloorMap;
	import com.chasedelanguillette.roguish.maps.sections.Room;
	import com.chasedelanguillette.roguish.maps.sections.Tile;
	
	import com.chasedelanguillette.utils.ArrayUtils;
	import com.chasedelanguillette.utils.MersenneTwister;
	import com.chasedelanguillette.utils.NumberUtils;
	
	import com.chasedelanguillette.roguish.objects.physicalObjects.PhysicalObject;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	import flash.utils.getTimer;
	import flash.geom.Rectangle;
	
	
	public class ItemCreator
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
		private static var _oRandomNumberGenerator:MersenneTwister;
		
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function ItemCreator():void
		{
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public static function addItems(oFloorMap:FloorMap, oNumberGenerator:MersenneTwister, nMinimumCount:int = 0, nMaximumCount:int = 0):void
		{
			trace("ItemCreator::addItems() min " + nMinimumCount + " max: " + nMaximumCount);
			var startTime:int;
			var endTime:int;
			startTime = getTimer();
			
			_oRandomNumberGenerator = oNumberGenerator;
			
			var oMonsterPlacementResult:Object = null;
			
			var fRandom:Number = MersenneTwister.nGenerateRandomFloatFromInstance(_oRandomNumberGenerator);
			var nTotalItems:int = NumberUtils.nGetRandomNumberRange(fRandom, nMinimumCount, nMaximumCount);
			trace("ItemCreator::addItems() - > making " + nTotalItems + " items!");
			
			for (var i:int = 0; i < nTotalItems; i++)
			{
				oMonsterPlacementResult = ItemCreator.oGetRandomUnoccupiedPosition(oFloorMap)
				if (oMonsterPlacementResult != null) 
				{
					oFloorMap.addItem({type:0, tx:oMonsterPlacementResult.tx, ty:oMonsterPlacementResult.ty});
				}
			}
			
			endTime = getTimer();
			trace("ItemCreator::addItems() -> items created in " + (endTime - startTime) + " ms.");
		};
		
		private static function oGetRandomUnoccupiedPosition(oFloorMap:FloorMap):Object
		{
			var nMonsterRoomX:int = 0;
			var nMonsterRoomY:int = 0;
			var nMonsterTileX:int = 0;
			var nMonsterTileY:int = 0;
			
			// place the hero for now!
			var oRoomCoordinates:Object = oGetValidRandomRoom(oFloorMap);
			if ( oRoomCoordinates != null )
			{

				nMonsterRoomX = oRoomCoordinates.x;
				nMonsterRoomY = oRoomCoordinates.y;

				//trace("MonsterCreator::oGetRandomUnoccupiedPosition() -> able to find valid room! -> rx: " + nMonsterRoomX + " , " + nMonsterRoomY);
								
				// get a handle on the map section we're working with.
				var oMapData:MapData = oFloorMap.rooms[nMonsterRoomY][nMonsterRoomX];
				
				
				// we'll want to shuffle the array of rooms up to get us an even distribution
				oMapData.rooms = ArrayUtils.shuffleArrayWithNumberGenerator(oMapData.rooms, _oRandomNumberGenerator);
								
				var bMonsterPlaced:Boolean = false;
				var nIterations:int = 0;
				var nMaxIterations:int = 1000;
				while(!bMonsterPlaced && nIterations < nMaxIterations)
				{
					for (var i:int = 0; i < oMapData.rooms.length; i++)
					{
						//var room:Rectangle = oMapData.rooms[i];
						var room:Room = oMapData.rooms[i];
						//trace("checking room: " + room.x + ", " + room.y + "; " + room.width + ", " + room.height)
						if ( room.anUnoccupiedTiles.length > 0 )
						{
							var fRandom:Number = MersenneTwister.nGenerateRandomFloatFromInstance(_oRandomNumberGenerator);
							var nRandomIndex:int = Math.floor(fRandom * room.anUnoccupiedByItems.length);
							var nRandomTilePosition:int = room.anUnoccupiedByItems[nRandomIndex];
							room.anUnoccupiedByItems.splice(nRandomIndex, 1);
							
							var tx:int = int(nRandomTilePosition % room.width) + room.x;
							var ty:int = int(nRandomTilePosition / room.width) + room.y;
							
							//trace("Monster position found -> " + tx + ", " + ty);
							
							tx += (nMonsterRoomX * 27);
							ty += (nMonsterRoomY * 27);
							
							//trace("Monster position offset -> " + tx + ", " + ty);
							
							//trace("MonsterCreator::oGetRandomUnoccupiedPosition() oFloorMap.tiles[tx][ty]: " + oFloorMap.tiles[ty][tx]);
							
							if ( oFloorMap.tiles[ty][tx] == 1 )
							{
								nMonsterTileX = tx;
								nMonsterTileY = ty;
								bMonsterPlaced = true;
							}
							break;
						}
					}
					nIterations++
					//trace("MonsterCreator::oGetRandomUnoccupiedPosition() nIterations: " + nIterations);
				}
				
				if ( bMonsterPlaced ) return {result:true, tx:nMonsterTileX, ty:nMonsterTileY};
				return null;
			}
						
			return null;
		};
		
		// randomly searches the map for a room that is connected to the maze.
		private static function oGetValidRandomRoom(oFloorMap:FloorMap):Object
		{
			var bValidRoomFound:Boolean = false;
			var nIterations:int = 0;
			var nMaxIterations:int = 1000;
			
			var rx:int;
			var ry:int;
			
			// search for a valid room
			while(!bValidRoomFound && nIterations < nMaxIterations)
			{
				// choose a random position in the maze.
				// here, we're choosing a random MapData object from the 2d Array of other MapData
				var fRandom:Number = MersenneTwister.nGenerateRandomFloatFromInstance(_oRandomNumberGenerator);
				rx = Math.floor(fRandom * oFloorMap.rooms[0].length);
				fRandom = MersenneTwister.nGenerateRandomFloatFromInstance(_oRandomNumberGenerator);
				ry = Math.floor(fRandom * oFloorMap.rooms.length);
				var oCellInMinimap:Tile = oFloorMap.minimap.aoMapLayout[ry][rx];
				
				// if the minimap is only 1x1, or if the cell is not sealed off from the rest of the maze, then it's valid!
				if ( (oFloorMap.minimap.aoMapLayout.length == 1 && oFloorMap.minimap.aoMapLayout[0].length == 1  ) 
						|| !oCellInMinimap.bWall_Up || !oCellInMinimap.bWall_Down || !oCellInMinimap.bWall_Right || !oCellInMinimap.bWall_Left )
				{
					// we've found a section of the map that is connected to the maze.
					// let's make sure it has some valid rooms though!
					if ( oFloorMap.rooms[ry][rx] != null )
					{
						if ( oFloorMap.rooms[ry][rx].rooms.length > 0 )
						{
							//trace("MonsterCreator::oGetValidRoom() -> VALID ROOM FOUND @ " + rx + " , " + ry);
							bValidRoomFound = true;
						}
					}
				} 
				nIterations++;			
			}
			
			if (bValidRoomFound) return {x:rx, y:ry};
			return null;
		};
		
		
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