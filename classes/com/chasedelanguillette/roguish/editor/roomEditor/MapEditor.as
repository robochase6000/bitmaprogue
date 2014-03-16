///////////////////////////////////////////////////
//	MapEditor
//	CREATED: 2009-05-29.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.editor.roomEditor
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.editor.roomEditor.NewMapDialog;
	import com.chasedelanguillette.roguish.editor.regionEditor.RegionEditor;
	import com.chasedelanguillette.utils.ArrayUtils;
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.display.*;
	import flash.events.*;
	
	public class MapEditor extends MovieClip
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		public static const TILE_ROOM:int 			= 0;
		public static const TILE_HALL:int 			= 1;
		public static const TILE_SECRET_HALL:int 	= 2;
		public static const TILE_WALL:int 			= 3;
		public static const TILE_WATER:int 			= 4;
		public static const TILE_SECRET_ROOM:int 	= 5;
		
		public static const MODE_TILE_PLACEMENT:int = 0;
		public static const MODE_REGION_EDITING:int = 1;
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public var aoMap:Array = new Array();
		public var oNewMapDialog:NewMapDialog = new NewMapDialog();
		public var mapContainer:Sprite = new Sprite();;
		public var tw:int = 15;
		public var th:int = tw;
		public var ui:MapUI = new MapUI();
		
		// room, hallway, secret hallway, wall, water
		public var tileType_0:Object	= {type:TILE_ROOM, 			desc:"Room", 			color:0xaa0000};
		public var tileType_1:Object 	= {type:TILE_HALL, 			desc:"Hall",			color:0xffffff};
		public var tileType_2:Object 	= {type:TILE_SECRET_HALL, 	desc:"Secret Hall",		color:0x666666};
		public var tileType_3:Object	= {type:TILE_WALL, 			desc:"Wall",			color:0x333333};
		public var tileType_4:Object 	= {type:TILE_WATER, 		desc:"Water",			color:0x0000cc};
		public var tileType_5:Object 	= {type:TILE_SECRET_ROOM, 	desc:"Secret Room",		color:0x00cc00};
		public var tileTypes:Array 		= [tileType_0, tileType_1, tileType_2, tileType_3, tileType_4, tileType_5];
		public var nCurrentTileType:int = 0;
		public var oCurrentTileType:Object = tileTypes[nCurrentTileType];
		
		protected var oRegionEditor:RegionEditor;
		
		public var nCurrentMode:int = MODE_TILE_PLACEMENT;
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function MapEditor():void
		{
			trace("MapEditor::MapEditor()");
			
			mapContainer.name = "mapContainer"
			addChild(mapContainer);
			mapContainer.graphics.lineStyle(1, 0x000000);
			stage.focus = this;
			stage.addEventListener( KeyboardEvent.KEY_DOWN, vHandle_this_KEY_DOWN );
			stage.addEventListener( KeyboardEvent.KEY_UP, vHandle_stage_KEY_UP );
			
			addChild(ui);
			ui.y = stage.stageHeight - ui.height;
			
			addChild(oNewMapDialog);
			newMapRequest();
			
			oRegionEditor = new RegionEditor(this.stage, tw, false);
			addChild(oRegionEditor);
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function vSetEnabled_MapEditing(bEnabled:Boolean):void
		{
			trace("MapEditor::vSetEnabled_MapEditing()");
			
		};

		public function newMapRequest():void
		{
			trace("MapEditor::newMapRequest()");
			oNewMapDialog.vSetEnabled(true);
			this.oNewMapDialog.addEventListener( Event.COMPLETE, vHandle_oNewMapDialog_COMPLETE );
		};
		
		public function makeNewMap(w:int, h:int):void
		{
			
			trace("MapEditor::makeNewMap() -> w: " + w + " h: " + h);
			cleanup();
			
			aoMap = new Array();
			for (var i:int = 0; i < h; i++)
			{
				aoMap[i] = new Array();
				for (var j:int = 0; j < w; j++)
				{
					aoMap[i][j] = new Object();
					var t:Object = aoMap[i][j];
					
					t.type = tileType_3;
				}
			}
			
			drawmap();
			vSetModeEnabled_TilePlacement(true)
		}
		
		public function cleanup():void
		{
			trace("MapEditor::cleanup()");
			
		};
		
		/**
		*	drawmap()
		*	The map gets redrawn every time the tiles change!
		*/
		public function drawmap():void
		{
			//trace("MapEditor::drawmap()");
			mapContainer.graphics.clear();
			mapContainer.graphics.lineStyle(1, 0x000000);
			for (var i:int = 0; i < aoMap.length; i++)
			{	
				for (var j:int = 0; j < aoMap[0].length; j++)
				{
					
					mapContainer.graphics.beginFill(aoMap[i][j].type.color, 1.0)
					/*if ( aoMap[i][j].bWalkable ){
								mapContainer.graphics.beginFill(0xffffff, 0.2);
							}
							else
							{
								mapContainer.graphics.beginFill(0x333333, 0.4);
							}*/
					mapContainer.graphics.drawRect(j * tw, i * th, tw, th);
					mapContainer.graphics.endFill();
					
				}
			}
		};
		
		
		//============================================
		//	MAP OUTPUT
		//============================================

		public function xmlGetMapOutput():XML
		{
			trace("MapEditor::vDisplayMapOutput()");
			var tilesAsXML:String	= outputMapAsXML();
			var regionXML:XML 		= oRegionEditor.xmlGetRegionInfo();
			return regionXML.appendChild(tilesAsXML);
		};
		
		public function outputmapinfo():void
		{
			//outputMapAsActionscript();
			trace(outputMapAsXML());
		};
		
		public function outputMapAsActionscript()
		{
			var varType:String = "var map:Array = [";
			var prefix:String = "";
			for (var i:int = 0; i < aoMap.length; i++)
			{
				prefix += "["
				for (var j:int = 0; j < aoMap[0].length; j++)
				{
					prefix += String(aoMap[i][j].type.type);
					if ( j < aoMap[0].length )
					{
						prefix += ","
					}
				}
				prefix += "]";
				if ( i < aoMap.length - 1 ) {
					prefix += ",\n"
				} else {
					prefix += "];"
				}
			}
			trace( varType );
			trace( prefix );
		}
		
		public function outputMapAsXML():String
		{
			var map:XML;
			var szMap:String = "";
			var szTileSeparator:String = ",";
			var szRowSeparator:String = "|";
			
			for (var i:int = 0; i < aoMap.length; i++)
			{
				for (var j:int = 0; j < aoMap[0].length; j++)
				{
					szMap += String(aoMap[i][j].type.type);
					if (j != aoMap[0].length - 1) szMap += szTileSeparator;
				}
				if (i != aoMap.length - 1) szMap += szRowSeparator;
			}
			
			//var szRoomDimensions = " w=\"" + aoMap[0].length + "\" h=\"" + aoMap.length + "\"";
			return "<tiles tileSeparator=\"" + szTileSeparator + "\" rowSeparator=\"" + szRowSeparator + "\">" + szMap + "</tiles>";
		}
		
		
		//============================================
		//	MODE SWITCHING
		//============================================
		
		public function vSwitchModes(nNewMode:int):void
		{
			if (nCurrentMode != nNewMode){
				vDisableCurrentMode();
				vEnableNewMode(nNewMode);
			}
		};
		
		public function vDisableCurrentMode():void
		{
			switch (nCurrentMode)
			{
				case MODE_TILE_PLACEMENT :
					vSetModeEnabled_TilePlacement(false);
				break;
				case MODE_REGION_EDITING :
					vSetModeEnabled_RegionEditing(false);
				break;
			}
		};
		
		public function vEnableNewMode(nNewMode:int):void
		{
			nCurrentMode = nNewMode;
			switch (nCurrentMode)
			{
				case MODE_TILE_PLACEMENT :
					vSetModeEnabled_TilePlacement(true);
				break;
				case MODE_REGION_EDITING :
					vSetModeEnabled_RegionEditing(true);
				break;
			}
		};
		
		public function vSetModeEnabled_TilePlacement(bEnabled:Boolean):void
		{
			trace("MapEditor::vSetModeEnabled_TilePlacement(bEnabled: " + bEnabled + ")");
			ui.vSetEnabled(bEnabled);
			if ( bEnabled)
			{
				mapContainer.addEventListener( MouseEvent.MOUSE_DOWN, vHandle_mapContainer_MOUSE_DOWN );
				mapContainer.addEventListener( MouseEvent.MOUSE_UP, vHandle_mapContainer_MOUSE_UP );
				mapContainer.addEventListener( MouseEvent.MOUSE_MOVE, vHandle_mapContainer_MOUSE_MOVE );
				//mapContainer.addEventListener( MouseEvent.CLICK, vHandle_stage_CLICK );
				ui.addEventListener( UIEvent.MAP_ROTATE_LEFT, vHandle_ui_MAP_ROTATE_LEFT );
				ui.addEventListener( UIEvent.MAP_ROTATE_RIGHT, vHandle_ui_MAP_ROTATE_RIGHT );
				ui.addEventListener( UIEvent.MAP_FLIP_HORIZONTAL, vHandle_ui_MAP_FLIP_HORIZONTAL );
				ui.addEventListener( UIEvent.MAP_FLIP_VERTICAL, vHandle_ui_MAP_FLIP_VERTICAL );
				ui.addEventListener( UIEvent.MAP_ADD_COLUMN, vHandle_ui_MAP_ADD_COLUMN );
				ui.addEventListener( UIEvent.MAP_ADD_ROW, vHandle_ui_MAP_ADD_ROW );
				ui.addEventListener( UIEvent.MAP_DELETE_ROW, vHandle_ui_MAP_DELETE_ROW );
				ui.addEventListener( UIEvent.MAP_DELETE_COLUMN, vHandle_ui_MAP_DELETE_COLUMN );
			}
			else
			{
				mapContainer.removeEventListener( MouseEvent.MOUSE_DOWN, vHandle_mapContainer_MOUSE_DOWN );
				mapContainer.removeEventListener( MouseEvent.MOUSE_UP, vHandle_mapContainer_MOUSE_UP );
				mapContainer.removeEventListener( MouseEvent.MOUSE_MOVE, vHandle_mapContainer_MOUSE_MOVE );
				//mapContainer.removeEventListener( MouseEvent.CLICK, vHandle_stage_CLICK );
				ui.removeEventListener( UIEvent.MAP_ROTATE_LEFT, vHandle_ui_MAP_ROTATE_LEFT );
				ui.removeEventListener( UIEvent.MAP_ROTATE_RIGHT, vHandle_ui_MAP_ROTATE_RIGHT );
				ui.removeEventListener( UIEvent.MAP_FLIP_HORIZONTAL, vHandle_ui_MAP_FLIP_HORIZONTAL );
				ui.removeEventListener( UIEvent.MAP_FLIP_VERTICAL, vHandle_ui_MAP_FLIP_VERTICAL );
				ui.removeEventListener( UIEvent.MAP_ADD_COLUMN, vHandle_ui_MAP_ADD_COLUMN );
				ui.removeEventListener( UIEvent.MAP_ADD_ROW, vHandle_ui_MAP_ADD_ROW );
				ui.removeEventListener( UIEvent.MAP_DELETE_ROW, vHandle_ui_MAP_DELETE_ROW );
				ui.removeEventListener( UIEvent.MAP_DELETE_COLUMN, vHandle_ui_MAP_DELETE_COLUMN );
			}
		};
		
		public function vSetModeEnabled_RegionEditing(bEnabled:Boolean):void
		{
			trace("MapEditor::vSetModeEnabled_RegionEditing(bEnabled: " + bEnabled + ")");
			oRegionEditor.vSetEnabled(bEnabled);
			if (bEnabled)
			{

			}
			else
			{
				
			}
		};
		
		//////////////////////////////////////////////
		//
		//	EVENT HANDLERS
		//
		//////////////////////////////////////////////
		public static const KEY_N:int 			= 78;
		public static const KEY_ENTER:int 		= 13;
		public static const KEY_SHIFT:int 		= 16;
		public static const KEY_1:int 			= 49;
		public static const KEY_2:int 			= 50;
		public static const KEY_3:int 			= 51;
		public static const KEY_4:int 			= 52;
		public static const KEY_5:int 			= 53;
		public static const KEY_6:int 			= 54;
		public static const KEY_T:int 			= 84;
		public static const KEY_R:int 			= 82;
		public static const KEY_V:int			= 86;
		public static const KEY_P:int 			= 80;

		private var _bKeyDown_Shift:Boolean = false;;
		
		private function vHandle_this_KEY_DOWN(evt:KeyboardEvent):void
		{
			vHandle_this_KEY_DOWN_global(evt);
			switch (nCurrentMode)
			{
				case MODE_TILE_PLACEMENT :
					vHandle_this_KEY_DOWN_TilePlacementMode(evt);
				break;
				case MODE_REGION_EDITING :
					vHandle_this_KEY_DOWN_RegionEditingMode(evt);
				break;
			}
		};
		
		public function vHandle_this_KEY_DOWN_global(evt:KeyboardEvent):void
		{
			trace( "keyCode: " + evt.keyCode );
			switch (evt.keyCode)
			{
				case KEY_SHIFT:
					_bKeyDown_Shift = true;
				break;
				case KEY_T:
					if (_bKeyDown_Shift) vSwitchModes(MODE_TILE_PLACEMENT);
				break;
				case KEY_R:
					if (_bKeyDown_Shift) vSwitchModes(MODE_REGION_EDITING);
				break;
				case KEY_V:
					oRegionEditor.visible = !oRegionEditor.visible;
				break;
				case KEY_P:
					if (_bKeyDown_Shift) trace( ":: MAP OUTPUT :: " + "\n" + xmlGetMapOutput() );
				break;
			}
		};
		
		public function vHandle_this_KEY_DOWN_TilePlacementMode(evt:KeyboardEvent):void
		{
			var bTileTypeUpdated:Boolean = false;
			switch( evt.keyCode )
			{
				case KEY_N :
					if (evt.ctrlKey) newMapRequest();
				break;
				case KEY_ENTER :
					//outputmapinfo();
				break;
				case KEY_1 :
					nCurrentTileType = 0;
					bTileTypeUpdated = true;
				break;
				case KEY_2 :
					nCurrentTileType = 1;
					bTileTypeUpdated = true;
				break;
				case KEY_3 :
					nCurrentTileType = 2;
					bTileTypeUpdated = true;
				break;
				case KEY_4 :
					nCurrentTileType = 3;
					bTileTypeUpdated = true;
				break;
				case KEY_5 :
					nCurrentTileType = 4;
					bTileTypeUpdated = true;
				break;
				case KEY_6 :
					nCurrentTileType = 5;
					bTileTypeUpdated = true;
				break;
			}
			if (bTileTypeUpdated) {
				oCurrentTileType = tileTypes[nCurrentTileType];
				trace( "current tile type: " + nCurrentTileType)
			}
		};
		
		public function vHandle_this_KEY_DOWN_RegionEditingMode(evt:KeyboardEvent):void
		{
			
		};
		
		private function vHandle_stage_KEY_UP(evt:KeyboardEvent):void
		{
			switch( evt.keyCode )
			{
				case KEY_SHIFT:
					_bKeyDown_Shift = false;
				break;
			}
		};
		
		private function vHandle_oNewMapDialog_COMPLETE(evt:Event):void
		{
			trace("MapEditor::vHandle_oNewMapDialog_COMPLETE()");
			trace( "oNewMapDialog.bValidNewMap::" + oNewMapDialog.bValidNewMap );
			
			if ( oNewMapDialog.bValidNewMap )
			{
				makeNewMap(oNewMapDialog.mw, oNewMapDialog.mh);
			}
		};
		
		private function vHandle_stage_CLICK(evt:MouseEvent):void
		{
			trace("MapEditor::vHandle_stage_CLICK()");
			var tilex:int = mapContainer.mouseX / tw;
			var tiley:int = mapContainer.mouseY / th;
			trace( "x: " + tilex + " y: " + tiley)
			
			var tile:Object = aoMap[tiley][tilex];
			
			
			tile.bWalkable = !tile.bWalkable;
			trace(tile.bWalkable);
			drawmap();
			
		};
		
		private var _bMouseDown:Boolean = false;
		private var _aoPaintedTiles:Array = new Array();
		private function vHandle_mapContainer_MOUSE_DOWN(evt:MouseEvent):void
		{
			_aoPaintedTiles = new Array();
			_bMouseDown = true;
			
			var t:Object = oGetTileAt(mapContainer.mouseX, mapContainer.mouseY);
			if ( t != null )
			{
				t.bWalkable = !t.bWalkable
				t.type = oCurrentTileType;
				_aoPaintedTiles.push( t );
				drawmap();
			}
		}
		
		private function vHandle_mapContainer_MOUSE_UP(evt:MouseEvent):void
		{
			_bMouseDown = false;
			/*
			for (var i:int = 0; i < _aoPaintedTiles.length; i++)
			{
				var t:Object = _aoPaintedTiles[i];
				t.bWalkable = !t.bWalkable;
			}
			drawmap();
			*/
		}
		
		private function vHandle_mapContainer_MOUSE_MOVE(evt:MouseEvent):void
		{
			if ( _bMouseDown )
			{
				var t:Object = oGetTileAt(mapContainer.mouseX, mapContainer.mouseY);
				if ( t != null )
				{
					if ( !bIsTileInArray(t, _aoPaintedTiles)) {
						t.type = oCurrentTileType;
						t.bWalkable = !t.bWalkable
						_aoPaintedTiles.push( t );
						drawmap();
					}
				}
			}
		};
		
		private function oGetTileAt(x:int, y:int):Object
		{
			var tilex:int = x / tw;
			var tiley:int = y / th;
			
			if ( tilex < aoMap[0].length && tiley < aoMap.length )
			{
				var tile:Object = aoMap[tiley][tilex];
				return tile;
			} 
			
			return null;
		}
		
		private function bIsTileInArray(tile:Object, array:Array):Boolean
		{
			for (var i:int = 0; i < array.length; i++)
			{
				if ( array[i] == tile ){
					return true;
				}
			}
			return false;
		}
		
		
		//============================================
		//	ui events
		//============================================
		
		private function vHandle_ui_MAP_ROTATE_RIGHT(evt:UIEvent):void
		{
			trace("MapEditor::vHandle_ui_MAP_ROTATE_RIGHT()");
			aoMap = ArrayUtils.aoRotateRight(aoMap);
			drawmap();
		};
		
		private function vHandle_ui_MAP_ROTATE_LEFT(evt:UIEvent):void
		{
			trace("MapEditor::vHandle_ui_MAP_ROTATE_LEFT()");
			aoMap = ArrayUtils.aoRotateLeft(aoMap);
			drawmap();
		};
		
		private function vHandle_ui_MAP_FLIP_HORIZONTAL(evt:UIEvent):void
		{
			trace("MapEditor::vHandle_ui_MAP_FLIP_HORIZONTAL()");
			aoMap = ArrayUtils.aoFlipHorizontal(aoMap);
			drawmap();
		};
		
		private function vHandle_ui_MAP_FLIP_VERTICAL(evt:UIEvent):void
		{
			trace("MapEditor::vHandle_ui_MAP_FLIP_VERTICAL()");
			aoMap = ArrayUtils.aoFlipVertical(aoMap);
			drawmap();
		};
		 
		private function vHandle_ui_MAP_ADD_ROW(evt:UIEvent):void
		{
			trace("MapEditor::vHandle_ui_MAP_ADD_ROW()");
			aoMap.push(new Array());
			for (var i:int = 0; i < aoMap[0].length; i++)
			{
				aoMap[aoMap.length - 1][i] = new Object();
				var t:Object = aoMap[aoMap.length - 1][i];
				t.type = tileType_3;
				//t.bWalkable = false;
			}
			drawmap();
		}
		
		private function vHandle_ui_MAP_ADD_COLUMN(evt:UIEvent):void
		{
			trace("MapEditor::vHandle_ui_MAP_ADD_COLUMN()");
			for (var i:int = 0; i < aoMap.length; i++)
			{
				trace("MapEditor::vHandle_ui_MAP_ADD_COLUMN() x: " + (aoMap[0].length - 1) + " y: " + i);
				aoMap[i].push(new Object());
				var t:Object = aoMap[i][aoMap[0].length - 1];
				t.type = tileType_3;
				//t.bWalkable = false;
			}
			drawmap();
		}
		
		private function vHandle_ui_MAP_DELETE_ROW(evt:UIEvent):void
		{
			trace("MapEditor::vHandle_ui_MAP_DELETE_ROW()");
			aoMap.pop();
			drawmap();
		};
		
		private function vHandle_ui_MAP_DELETE_COLUMN(evt:UIEvent):void
		{
			trace("MapEditor::vHandle_ui_MAP_DELETE_COLUMN()");
			for (var i:int = 0; i < aoMap.length; i++)
			{
				aoMap[i].pop();
			}
			drawmap();
		}
		
		
		//////////////////////////////////////////////
		//
		//	PRIVATE METHODS
		//
		//////////////////////////////////////////////
		
		
	}
}