///////////////////////////////////////////////////
//	SimpleRectangle
//	CREATED: 2009-09-11.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//	Basically nothing.  holds the barest info a rectangle must have: x, y, width, and height
//
//////////////////////////////////////////////////


package com.chasedelanguillette.geom
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class SimpleRectangle extends Object
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public var x:int;
		public var y:int;
		public var width:int;
		public var height:int;
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function SimpleRectangle(x:int = 0, y:int = 0, width:int = 0, height:int = 0):void
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public static function containsPoint(rect:SimpleRectangle, p:SimplePoint):Boolean
		{
			if ( p.x < rect.x ) return false;
			if ( p.y < rect.y ) return false;
			if ( p.x > rect.x + rect.width ) return false;
			if ( p.y > rect.y + rect.height ) return false;
			return true;
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