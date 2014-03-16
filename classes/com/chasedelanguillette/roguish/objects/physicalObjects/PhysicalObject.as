///////////////////////////////////////////////////
//	PhysicalObject
//	CREATED: 2009-11-06.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//	A physical object is a tangible object that can be seen and touched in the world.  The important things to know are that it:
//	1. occupies physical space.
//	2. requires at least one pass at rendering, since it can be seen.
//
//////////////////////////////////////////////////

package com.chasedelanguillette.roguish.objects.physicalObjects
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.objects.GameObject;
	import com.chasedelanguillette.roguish.objects.properties.Material;
	import com.chasedelanguillette.roguish.objects.properties.Dimensions;
	import com.chasedelanguillette.roguish.objects.properties.RenderData;
	import com.chasedelanguillette.roguish.objects.properties.Action;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class PhysicalObject extends GameObject
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		/**
		*	id when dealing with floors!.
		*	
		*	<p>Note that floors and walls are the same thing.  A wall is a floor with a greater height!!</p>
		*/
		public static const FLOOR:int = 0;
		
		
		//============================================
		//	PHYSICAL PROPERTIES
		//============================================
		
		/**
		*	A bitmask that describes interactivity.	
		*
		*	See class Interactivity.
		*/
		public var nInteractionsAsObject:int = 0;
		
		
		/**
		*	Dimensions are now stored in an object.  
		*	
		*	<p>Probably a bit heavy, but this should make it really easy to port to different projects.</p>
		*/
		public var oDimensions:Dimensions = new Dimensions();
		
		
		/**
		*	Material this object is made of.	
		*/
		public var nMaterial:int = Material.WATER;
		
		
		/**
		*	A physical object may be rendered.	
		*	
		*	<p>Made static because each physical object should look the same.
		*	If something needs to look different, subclass PhysicalObject and assign a different render data.</p>
		*/
		public var oRenderData:RenderData = new RenderData();
		
		
		/**
		*	
		*/
		public var bIsFocused:Boolean = false;
		
		
		/**
		*		
		*/
		public var nCurrentAction:int = 0;
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		/**
		*	@constructor
		*/
		public function PhysicalObject():void
		{
			super();
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		/**
		*	Updates position in world.
		*/
		public function setPosition(x:int, y:int):void
		{
			oDimensions.x = x;
			oDimensions.y = y;
		};
		
		/**
		*	Updates physical dimensions.
		*	Also recalculates volume and weight.
		*/
		public function setDimensions(x:Number, y:Number, z:Number):void
		{
			oDimensions.width = x;
			oDimensions.height = y;
			oDimensions.depth = z;
			
			// update volume & weight
			oDimensions.volume = oDimensions.x * oDimensions.y * oDimensions.z;
			
			oDimensions.weight = Material.nBaseWeightPerUnit(this.nMaterial) * oDimensions.volume;
		};
		
		/**
		*	Sets the material for the physical object.
		*	Recalculates weight.
		*/
		public function setMaterial(nMaterial:int):void
		{
			this.nMaterial = nMaterial;
			oDimensions.weight = Material.nBaseWeightPerUnit(this.nMaterial) * oDimensions.volume;
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