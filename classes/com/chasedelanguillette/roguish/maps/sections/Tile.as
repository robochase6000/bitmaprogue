///////////////////////////////////////////////////
//	Tile
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
	//import creatures.Mobile;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class Tile
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		public var tx:int;
		public var ty:int;
		public var bWall_Up:Boolean = true;
		public var bWall_Down:Boolean = true;
		public var bWall_Left:Boolean = true;
		public var bWall_Right:Boolean = true;
		public var bWalkable:Boolean = false;
		public var bOccupied:Boolean = false;
		//public var oOccupant:Mobile = null;
		public var bWallDestroyed:Boolean = false;// for testing only.
		public var bNodeVisted:Boolean = false;
		public var oParent:Tile = null;
		
		public var bTested:Boolean = false;
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function Tile():void
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