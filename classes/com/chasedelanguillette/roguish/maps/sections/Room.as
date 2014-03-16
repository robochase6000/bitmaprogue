///////////////////////////////////////////////////
//	Room
//	CREATED: 2009-05-25.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.maps.sections
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	import com.chasedelanguillette.geom.SimpleRectangle;
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	public class Room extends SimpleRectangle
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public var anUnoccupiedTiles:Array;
		public var anUnoccupiedByItems:Array;
		public var anUnoccupiedByTraps:Array;
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function Room(x:int = 0, y:int = 0, width:int = 0, height:int = 0):void
		{
			//trace("Room::Room(x: " + x + " y: " + y + " w: " + width + " h: " + height + ")");
			super(x, y, width, height);
			
			// keep a list of unoccupied tiles here
			anUnoccupiedTiles = new Array();
			anUnoccupiedByItems = new Array();
			anUnoccupiedByTraps = new Array();
			
			var nIndex:int = 0;
			for (var i:int = 0; i < height; i++)
			{
				for (var j:int = 0; j < width; j++)
				{
					anUnoccupiedTiles[nIndex] = nIndex;
					anUnoccupiedByItems[nIndex] = nIndex;
					anUnoccupiedByTraps[nIndex] = nIndex;
					nIndex++;
				}
			}
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