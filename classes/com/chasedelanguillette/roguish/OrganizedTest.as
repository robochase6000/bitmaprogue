///////////////////////////////////////////////////
//	OrganizedTest
//	CREATED: 2009-08-11.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package 
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.defines.MazeDefines;
	import com.chasedelanguillette.roguish.defines.RenderDefines;
	
	
	import com.chasedelanguillette.roguish.maps.VectorRenderer;
	import com.chasedelanguillette.roguish.BitmapRenderer;
	
	import com.chasedelanguillette.roguish.characters.Mobile;
	
	import com.chasedelanguillette.roguish.editor.roomEditor.MapData;// Thu Sep 10 08:58:21 CDT 2009 CMD TODO: move MapData to a more sensible location.

	import com.chasedelanguillette.utils.NumberUtils;
	import com.chasedelanguillette.utils.ArrayUtils;
	import com.chasedelanguillette.utils.XmlLoader;
	import com.chasedelanguillette.utils.MersenneTwister;
//	import com.chasedelanguillette.system.MemoryWatch;
	
	
//	import FPSCounter;
	import com.chasedelanguillette.system.DebugConsole;
	import ui.HUD;
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.system.System;
	
	
	
	public class OrganizedTest extends MovieClip
	{
		
		
		public static const SCROLL_SPEED_SLOW:int = 5;
		public static const SCROLL_SPEED_MED:int = 8;
		public static const SCROLL_SPEED_FAST:int = 20;
		public static const SCROLL_SPEED_DASH:int = 50;
		public static const SCROLL_SPEED_WALK:int = 4;
		
		/// XML STUFF
		private var _roomListsLoader:XmlLoader;
		private var _oCurrentRoomListLoader:XmlLoader;
		private var _szRoomListsURL:String 				= "xml/RoomLists.xml";
		private var _aszRoomLists:Array 				= new Array();
		private var _aoRoomLoaders:Array 				= new Array();
		private var _aoMapData:Array 					= new Array();
		
		
		/// BITMAP RENDERING STUFF
		private var _oViewOffset:Object = new Object();
		private var _oBitmapRenderer:BitmapRenderer;
		
		
		/// MISC.
		private var _oHudContainer:Sprite;
		private var _oGameContainer:Sprite;
		private var _oDebugConsoleContainer:Sprite;
		
		
		/// MOVEMENT STUFF
		private var _nMovementSpeed:int = SCROLL_SPEED_FAST;
		
		
		/// SYSTEM STUFF // Tue Sep  1 19:55:06 CDT 2009 CMD TODO: Consider making a debug class that adds the fps counter & memory info to the stage in easy to use componenents
		private var _oDebugConsole:DebugConsole;
		
		
		/// UI STUFF
		private var _oHUD:HUD;
				
		
		
		// MAP TWISTER
		private var _oMersenneTwister_Maps:MersenneTwister;
		private var _anPreviousFloorSteps:Array 					= new Array();
		private var _nMapSeed 										= 214;//Math.floor(Math.random() * 500) + 1;
		
		// MONSTER TWISTER
		private var _oMersenneTwister_Monsters:MersenneTwister;
		private var _anPreviousMonsterSteps:Array 					= new Array();
		private var _nMonsterSeed:int 								= 214;//Math.floor(Math.random() * MersenneTwister.SEED_MAX) + 1;	
		
		// ITEM TWISTER
		private var _oMersenneTwister_Items:MersenneTwister;
		private var _anPreviousItemSteps:Array 						= new Array();
		private var _nItemSeed:int 									= Math.floor(Math.random() * MersenneTwister.SEED_MAX) + 1;
		
		private var _nPreviousMemory:Number = System.totalMemory;
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function OrganizedTest():void
		{
			trace("OrganizedTest::() -> MAP SEED :: " + _nMapSeed);
			
			// initialize mersenne twisters!
			_oMersenneTwister_Monsters 			= new MersenneTwister(_nMonsterSeed);
			_oMersenneTwister_Items 			= new MersenneTwister(_nItemSeed);
			_oMersenneTwister_Maps 				= new MersenneTwister(_nMapSeed);
			
			for (var i:int = 0; i < 1; i++)
			{
				_oMersenneTwister_Maps.nGenerateRandomNumber();
				_oMersenneTwister_Monsters.nGenerateRandomNumber();
				_oMersenneTwister_Items.nGenerateRandomNumber();
			}
			
			// initialize containers!
			_oGameContainer = new Sprite();
			_oHudContainer = new Sprite();
			_oDebugConsoleContainer = new Sprite();
			addChild(_oGameContainer);
			addChild(_oHudContainer);
			addChild(_oDebugConsoleContainer);
			
			
			// MemoryWatch(nRoundTo:int, xPos:int=0, yPos:int=17, color:uint=0xffffff, fillBackground:Boolean=false, backgroundColor:uint=0x000000) {;
			_oDebugConsole = new DebugConsole();
			
			_oHUD = new HUD();
			_oHudContainer.addChild(_oHUD);
			
			// load teh room list!
			_roomListsLoader = new XmlLoader(_szRoomListsURL);
			_roomListsLoader.addEventListener( Event.COMPLETE, vHandle_roomListsLoader_COMPLETE );
		};
		
		public function loadGame(game:Object = null):void
		{
			// load save data, add event listener that waits for game save to load
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		private var _oMinimap:Minimap;
		
		
		private var _aoMinimap:Array 						= null;
		private var _oFloorMap:FloorMap 					= null;
		
		
		// BITMAP OBJECTS
		private var _bmpCanvas:Bitmap 						= null;
		private var _bmpdMiniMap:BitmapData 				= null;
		private var _bmpMiniMap:Bitmap 						= null;
		
		
		private var _bBitmapRenderingEnabled:Boolean 		= RenderDefines.BITMAP_RENDERING_ENABLED;
	
		private var _bmdTileSet:TestTileSet 				= new TestTileSet(320, 320);
		private var _bmdHeroSheet:Shiren					= new Shiren(320, 320);
		
		
		
		
		// MINIMAP BITMAP RENDERING
		private var _nMinimapScale:int 						= RenderDefines.MINIMAP_SCALE;
		private var _nMiniMapFillColor:uint 				= RenderDefines.MINIMAP_COLOR;//0xaa000000;
		private var _nMonsterColor:uint 					= RenderDefines.MINIMAP_MONSTER_COLOR;//0xffff0000;
		private var _nHeroColor:uint 						= RenderDefines.MINIMAP_HERO_COLOR;//0xffffffff;
		
		// 
		private var _bInitialized:Boolean					= false;
		
		// VECTOR RENDERS
		private var _oMapSprite:Sprite;
		private var _oMinimapSprite:Sprite;
		
		
		
		public function cleanUp():void
		{
			MazeCreator.cleanUp();
			RoomCreator.cleanUp();
			
			if ( _oFloorMap != null )
			{
				_oFloorMap.cleanUp();
				_oFloorMap = null;
			}
			
			if (_oMinimap != null)
			{
				// destroy minimap
				_oMinimap.cleanUp();
				_oMinimap = null;
			}
			if (_oFloorMap != null)
			{
				// destroy floor map
				_oFloorMap = null;
			}
			
			// MonsterCreator.cleanUp();
			// ItemCreator.cleanUp();
			
			if (_oBitmapRenderer != null)
			{
				_oBitmapRenderer.cleanUp();
				_oBitmapRenderer = null;
			}
			
			if (_bmpCanvas != null)
			{
				_oGameContainer.removeChild(_bmpCanvas);
				_bmpCanvas = null;
			}
			
			if (_bmpdMiniMap != null)
			{
				_bmpdMiniMap = null;
			}
			
			if ( _bmpMiniMap != null )
			{
				_oGameContainer.removeChild(_bmpMiniMap);
				_bmpMiniMap = null;
			}
		}
		
		public function restoreMap(nIndex:int):void
		{
			trace("OrganizedTest::restoreMap(nIndex: " + nIndex + ")");
			
			// retore map number generator
			_oMersenneTwister_Maps = null;
			_oMersenneTwister_Maps = new MersenneTwister(_nMapSeed);
			for (var i:int = 0; i < _anPreviousFloorSteps[nIndex]; i++)
			{
				_oMersenneTwister_Maps.nGenerateRandomNumber();
			}
			
			for (i = nIndex + 1; i < _anPreviousFloorSteps.length; i++)
			{
				_anPreviousFloorSteps.splice(i, 1);
			}
			
			
			// restore monster num generator
			_oMersenneTwister_Monsters = null;
			_oMersenneTwister_Monsters = new MersenneTwister(_nMonsterSeed);
			for (var i:int = 0; i < _anPreviousMonsterSteps[nIndex]; i++)
			{
				_oMersenneTwister_Monsters.nGenerateRandomNumber();
			}
			
			for (i = nIndex + 1; i < _anPreviousMonsterSteps.length; i++)
			{
				_anPreviousMonsterSteps.splice(i, 1);
			}
			
			// restore item num generator
			_oMersenneTwister_Items = null;
			_oMersenneTwister_Items = new MersenneTwister(_nItemSeed);
			for (var i:int = 0; i < _anPreviousItemSteps[nIndex]; i++)
			{
				_oMersenneTwister_Items.nGenerateRandomNumber();
			}
			
			for (i = nIndex + 1; i < _anPreviousItemSteps.length; i++)
			{
				_anPreviousItemSteps.splice(i, 1);
			}
			
			buildMap(_aoMapData);
		}
				
		public function buildMap(aoRoomSet:Array):void
		{
			// Iniitiate a clean-up first otherwise we'll run into memory leaks!
			cleanUp();
			
			trace("CREATING FLOOR " + _anPreviousFloorSteps.length );
			//trace(_anPreviousMonsterSteps)
			_oHUD.currentFloor = _anPreviousFloorSteps.length;
			
			// create the room layout
			_oMinimap = MazeCreator.aoGenerateMaze(			_oMersenneTwister_Maps, 
															MazeDefines.MAZE_WIDTH_IN_ROOMS, 
															MazeDefines.MAZE_HEIGHT_IN_ROOMS, 
															MazeDefines.MAZE_DEAD_ENDS_REMOVED, 
															MazeDefines.MAZE_SPARSENESS,
															MazeDefines.MAZE_ADDITIONAL_WALLS_DESTROYED
															);
			
			_oFloorMap = RoomCreator.oGenerateFloorMap(		_oMersenneTwister_Maps,
															_oMinimap, 
															aoRoomSet, 
															MazeDefines.ROOM_WIDTH_IN_TILES,     
															MazeDefines.ROOM_HEIGHT_IN_TILES
															);
			
			//ArrayUtils.traceArray2D(_oFloorMap.tiles);
			
			//RoomCreator.vCreateGreatHall(_oFloorMap);
			
			//ArrayUtils.traceArray2D(_oFloorMap.tiles);
			
			
//			MonsterCreator.vCreateMonsterHouse(_oFloorMap)
			MonsterCreator.addMonsters(_oFloorMap, _oMersenneTwister_Monsters);
			//ItemCreator.addItems(_oFloorMap, _oMersenneTwister_Maps);
			
			// Convert the tiles AFTER we've placed the monsters & items.
			TileConverter.vConvertMap(_oFloorMap);
			//ArrayUtils.traceArray2D(_oFloorMap.tiles);
			
			if(_bBitmapRenderingEnabled)
			{
				trace( _bmdTileSet )
				_oBitmapRenderer = new BitmapRenderer(_oFloorMap.tiles, _bmdTileSet as BitmapData, stage.stageWidth, stage.stageHeight, RenderDefines.TILE_WIDTH, RenderDefines.TILE_HEIGHT);
				_bmpCanvas = new Bitmap(_oBitmapRenderer.bmdCanvas);
				_oGameContainer.addChild(_bmpCanvas);
				_oViewOffset.x = 20;
				_oViewOffset.y = 0;
				_oBitmapRenderer.update(_oViewOffset.x,_oViewOffset.y);
				this.addEventListener( Event.ENTER_FRAME, vHandle_this_ENTER_FRAME );
				
				// make a bitmap minimap!
				_bmpdMiniMap = new BitmapData(_oFloorMap.tiles[0].length * _nMinimapScale, _oFloorMap.tiles.length * _nMinimapScale, true, 0x00000000)
				_bmpMiniMap = new Bitmap(_bmpdMiniMap);
				_oGameContainer.addChild(_bmpMiniMap);

				_bmpMiniMap.x = (stage.stageWidth - _bmpdMiniMap.width) / 2;
				_bmpMiniMap.y = (stage.stageHeight - _bmpdMiniMap.height) / 2;
				
				for (var i:int = 0; i < _oFloorMap.tiles.length * _nMinimapScale; i += 1 * _nMinimapScale)
				{
					for (var j:int = 0; j < _oFloorMap.tiles[0].length * _nMinimapScale; j += 1 * _nMinimapScale)
					{
						if ( _oFloorMap.tiles[i / _nMinimapScale][j / _nMinimapScale] == 1 ) {
							_bmpdMiniMap.fillRect(new Rectangle(j, i, _nMinimapScale, _nMinimapScale), _nMiniMapFillColor)
						}
					}
				}
				
				if (_oFloorMap.monsters != null)
				{
					for (var i:int = 0; i < _oFloorMap.monsters.length; i++)
					{
						
						var m = _oFloorMap.monsters[i];
						var nFillColor:uint = _nMonsterColor;
						if ( m.id == Mobile.HERO ) nFillColor = _nHeroColor;
						var tx:int = m.tx * _nMinimapScale;
						var ty:int = m.ty * _nMinimapScale;
						
						_bmpdMiniMap.fillRect(new Rectangle(tx, ty, _nMinimapScale, _nMinimapScale), nFillColor)
					}
					
				}
			}
			else
			{
				// render the map first
				_oMapSprite = new Sprite();
				_oMapSprite.name = "map";
				_oGameContainer.addChild(_oMapSprite);
				VectorRenderer.vDrawMaze_ArrayOfInts(_oFloorMap.tiles, _oMapSprite, RenderDefines.VECTOR_MAP_TILE_WIDTH, RenderDefines.VECTOR_MAP_TILE_HEIGHT);
				
				// render the minimap next
			 	_oMinimapSprite = new Sprite();
				_oMinimapSprite.name = "minimap";
				VectorRenderer.vDrawMaze(_aoMinimap, _oMinimapSprite, false, RenderDefines.VECTOR_MINIMAP_TILE_SPACING, RenderDefines.VECTOR_MINIMAP_TILE_WIDTH, RenderDefines.VECTOR_MINIMAP_TILE_HEIGHT);
				_oGameContainer.addChild( _oMinimapSprite );
				_oMinimapSprite.x = _oMapSprite.x + _oMapSprite.width + 10 
				_oMinimapSprite.y = 10;
			};
			
			if (!_bInitialized)
			{
				_bInitialized = true;
				
				///
				/// Init Input!
				stage.addEventListener( KeyboardEvent.KEY_DOWN, vHandle_this_KEY_DOWN );
				stage.addEventListener( KeyboardEvent.KEY_UP, vHandle_this_KEY_UP );
				stage.focus = this;
				
				_oDebugConsoleContainer.addChild(_oDebugConsole);
			}
			else
			{
				//this.swapChildren(_oDebugConsole, _bmpCanvas);
			}
		};
		
		public function vToggleMinimap():void
		{
			if ( _bBitmapRenderingEnabled )
			{
				_oMinimapContainer.visible = !_oMinimapContainer.visible;
			}
			else
			{
				_oMinimapSprite.visible = !_oMinimapSprite.visible;
			}
		}
		
		
		//============================================
		//	KEYBOARD INPUT
		//============================================
		
		private var _bKeyDown_Left:Boolean = false;
		private var _bKeyDown_Right:Boolean = false;
		private var _bKeyDown_Up:Boolean = false;
		private var _bKeyDown_Down:Boolean = false;
		
		private var _bSuppressInput:Boolean = false;
		
		private function vHandle_this_KEY_DOWN(evt:KeyboardEvent):void
		{
			//trace( evt.keyCode );
			
			switch ( evt.keyCode )
			{
				case 37 : // left
					_bKeyDown_Left = true;
				break;
				case 38 : // up
					_bKeyDown_Up = true;
				break;
				case 39 : // right
					_bKeyDown_Right = true;
				break;
				case 40 : // down
					_bKeyDown_Down = true;
				break;
				case 82 : // R
					if ( evt.shiftKey ) 
				break;
				case 188 : // comma
					if (_anPreviousFloorSteps.length > 1) restoreMap(_anPreviousFloorSteps.length - 2)
				break;
				case 77 : // m
					vToggleMinimap();
				break;
				case 190 : // period
					_anPreviousFloorSteps.push(_oMersenneTwister_Maps.step);
					_anPreviousMonsterSteps.push(_oMersenneTwister_Monsters.step);
					_anPreviousItemSteps.push(_oMersenneTwister_Items.step);
					//trace(_anPreviousFloorSteps);
					buildMap(_aoMapData);
				break;
			};
			
			
		};
		
		private function vHandle_this_KEY_UP(evt:KeyboardEvent):void
		{
			switch ( evt.keyCode )
			{
				case 37 : // left
					_bKeyDown_Left = false;
				break;
				case 38 : // up
					_bKeyDown_Up = false;
				break;
				case 39 : // right
					_bKeyDown_Right = false;
				break;
				case 40 : // down
					_bKeyDown_Down = false;
				break;
			};
		};
		
		
		//============================================
		//	MAIN LOOP
		//============================================
		
		private function updateMemory():void
		{
			var nCurrentMemory = System.totalMemory;
			if ( nCurrentMemory >= _nPreviousMemory )
			{
				_nPreviousMemory = nCurrentMemory;
				//trace( "memory increased to: " + Math.round(_nPreviousMemory / 1000) + "kb")
			}
		};
		
		private function checkKeys_Game():void
		{
			
		};
		
		private function checkKeys_UI():void
		{
			//
		}
		
		private function updateCharacters():void
		{
			
		};
		
		/**
		*	render() steps
		*	1. draw map
		*	2. draw traps
		*	3. draw items
		*	4. draw characters
		*	5. draw weapons
		*/
		private function bitmapRender():void
		{
			// DRAW MAP
			_oBitmapRenderer.update(_oViewOffset.x,_oViewOffset.y);// Thu Sep 17 12:35:45 CDT 2009 CMD TODO: make sure this gets called only when the view changes!
			
			// DRAW TRAPS
			//_oBitmapRenderer.renderGroup(_oFloorMap.traps, _bmdTrapSheet);
			
			// DRAW ITEMS
			_oBitmapRenderer.renderGroup(_oFloorMap.items, _bmdItemSheet);
			
			// DRAW CHARACTERS
			_oBitmapRenderer.renderSprites(_oFloorMap.monsters, _bmdHeroSheet);
			
			// DRAW WEAPONS
			//_oBitmapRenderer.drawWeapons(_oFloorMap.monsters, _bmdWeaponSheet);
		};
		
		private function vectorRender():void
		{
			// do something!
		};
		
		private function vHandle_this_ENTER_FRAME(evt:Event):void
		{
						
		};

		
		//============================================
		//	XML LOADING!
		//============================================

		private function vHandle_roomListsLoader_COMPLETE(evt:Event):void
		{
			var roomLists:XMLList = _roomListsLoader.loadedXML.children();
			for each (var list:XML in roomLists)
			{
			    _aszRoomLists.push(list.@url);
			}
			
			// clean up the room list loader
			_roomListsLoader.removeEventListener( Event.COMPLETE, vHandle_roomListsLoader_COMPLETE );
			_roomListsLoader = null;
			
			// now we've got an array of links to other xml files
			for (var p:String in _aszRoomLists)
			{
				
				var roomListLoader:XmlLoader = new XmlLoader(_aszRoomLists[p]);
				roomListLoader.addEventListener( Event.COMPLETE, vHandle_roomListLoader_COMPLETE );
			}
		};
		
		private function vHandle_roomListLoader_COMPLETE(evt:Event):void
		{
			var roomListLoader:XmlLoader = evt.target as XmlLoader;
			
			var rooms:XMLList = roomListLoader.loadedXML.children();
			for each (var r:XML in rooms)
			{
				// Mon Aug 17 12:55:27 CDT 2009 CMD TODO: Consider not loading every single xml room all at once?
				// A more dynamic system of loading/unloading parts as they are needed would be much more versatile (tho prone to error)
				var roomLoader:XmlLoader = new XmlLoader(r.@url);
				roomLoader.addEventListener( Event.COMPLETE, vHandle_roomLoader_COMPLETE );
				_aoRoomLoaders.push(roomLoader);
			}
		};
		
		private function vHandle_roomLoader_COMPLETE(evt:Event):void
		{
			var roomLoader:XmlLoader = evt.target as XmlLoader;
			
			// figure out if we've loaded every room this wad requires
			var bDoneLoadingRooms:Boolean = true;
			for (var i:String in _aoRoomLoaders)
			{
				var roomLoader:XmlLoader = _aoRoomLoaders[i];
				if (!roomLoader.bLoaded)
				{
					bDoneLoadingRooms = false;
					break;
				}
			};
			
			if (bDoneLoadingRooms)
			{
				// tell someone we're done!
				trace("OrganizedTest::vHandle_roomLoader_COMPLETE() -> DONE LOADING ROOMS!");
				convertRoomXMLToMapDataObjects();
			}
		};
		
		private function convertRoomXMLToMapDataObjects():void
		{
			trace("OrganizedTest::convertRoomXMLToMapDataObjects()");
			
			for (var i:String in _aoRoomLoaders)
			{
				var roomLoader:XmlLoader = _aoRoomLoaders[i];
				var mapData:MapData = MapParser.parse(roomLoader.loadedXML);
				_aoMapData.push(mapData);
			}
			
			_anPreviousFloorSteps.push(_oMersenneTwister_Maps.step);
			_anPreviousMonsterSteps.push(_oMersenneTwister_Monsters.step);
			_anPreviousItemSteps.push(_oMersenneTwister_Items.step);
			//trace(_anPreviousFloorSteps);
			buildMap(_aoMapData);
		};
	}
}