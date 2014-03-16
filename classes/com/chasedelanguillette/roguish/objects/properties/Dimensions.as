///////////////////////////////////////////////////
//	Dimensions
//	CREATED: 2009-11-10.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.objects.properties
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	/**
	*	A pretty simple class that stores general info about a physical object's place in the world.
	*	
	*	<p>Made into an object to make it portable, and very easy to swap out for other implementations.</p>
	*/
	public class Dimensions
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public var x:Number = 0;
		public var y:Number = 0;
		public var z:Number = 0;
		
		public var width:Number = 0;
		public var height:Number = 0;
		public var depth:Number = 0;
		
		public var volume:Number = 0;
		public var weight:Number = 0;
		
		public var direction:Number = 0;
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function Dimensions():void
		{
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function setPosition(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		};
		
		public function setDimensions(w:Number, h:Number, d:Number):void
		{
			this.width = w;
			this.height = h;
			this.depth = d;
			
			this.volume = w * h * d;
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