///////////////////////////////////////////////////
//	MapParser
//	CREATED: 2009-08-14.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//	give the parse function the xml you want to parse and it will return a MapData object :)
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.editor.roomEditor
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	import com.chasedelanguillette.roguish.maps.sections.Room;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.geom.Rectangle;
	
	
	public class MapParser
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		public static const REGION_ROOM:int = 0;
		public static const REGION_EXIT:int = 1;
		
		//============================================
		//	Public
		//============================================

		public static function parse(map:XML):MapData
		{
			var m:MapData = new MapData(getTiles(map), getRooms(map), getExits(map));
			m.mapTypeMask = int(map.@type);
			trace("map type loaded: " + m.mapTypeMask);
			return m;
		};


		//============================================
		//	Private
		//============================================
		
		private static function getTiles(map:XML):Array
		{
			var aoMap:Array = new Array();
			
			var mapString:String = String(map.tiles);
			
			var tileSeparator:String = String(map.tiles.@tileSeparator);
			var rowSeparator:String = String(map.tiles.@rowSeparator);
			
			var nCurrentRow:int = 0;
			aoMap[nCurrentRow] = new Array();
			
			for (var i:int = 0; i < mapString.length; i++)
			{
				
				var char:String = mapString.charAt(i);
				switch(char)
				{
					case tileSeparator :
						
					break;
					case rowSeparator :
						aoMap.push(new Array());
						nCurrentRow++;
					break;
					default :
						aoMap[nCurrentRow].push(char)
					break;
				}
			}
			
			//trace(aoMap)
			return aoMap;
		};
		
		private static function getRooms(map:XML):Array
		{
			var rooms:Array = new Array();
			
			// figure out where the rooms are
			for each( var region:XML in map.regions.elements() )
			{				
				if (int(region.@id) == REGION_ROOM)// Fri Aug 14 21:37:05 CDT 2009 CMD TODO: convert 0 to a constant for room type
				{
					//var rect:Rectangle = new Rectangle(region.@x, region.@y, region.@w, region.@h);
					var rect:Room = new Room(region.@x, region.@y, region.@w, region.@h);
					//trace("MapParser::getRooms() -> room added: (" + rect.x + " , " + rect.y + " , " + rect.width + " , " + rect.height + " )");
					rooms.push(rect);
				}
				
			}
			return rooms;
		};
		
		private static function getExits(map:XML):Array
		{
			var exits:Array = new Array();
			
			// figure out where the exits are
			// figure out where the rooms are
			for each( var region:XML in map.regions.elements() )
			{				
				if (int(region.@id) == REGION_EXIT)// Fri Aug 14 21:37:05 CDT 2009 CMD TODO: convert 1 to a constant for exit type
				{
					var rect:Room = new Room(region.@x, region.@y, region.@w, region.@h);
					//trace("MapParser::getExits() -> exit added: (" + rect.x + " , " + rect.y + " , " + rect.width + " , " + rect.height + " )");
					exits.push(rect);
				}
				
			}
			
			return exits;
		};
		
		
	}
}