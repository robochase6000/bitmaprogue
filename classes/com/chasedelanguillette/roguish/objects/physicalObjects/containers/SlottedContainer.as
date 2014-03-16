///////////////////////////////////////////////////
//	SlottedContainer
//	CREATED: 2009-11-06.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//	A "slotted" container is one that can hold X number of items. In other words, it has X slots available for storage.
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.objects.physicalObjects.containers
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.objects.physicalObjects.containers.Container;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class SlottedContainer extends Container
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public var nSize:int = 0;
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		/**
		*	@param size the maximum items this container can hold.
		*/
		public function SlottedContainer():void
		{
			super();
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		/**
		*	
		*/
		override public function addItem(oItem:*):Boolean
		{
			// if we don't have enough slots, kick the request out!
			if (_aoItems.length == nSize ) return false;
			
			// add the item!
			_aoItems.push(oItem);
			return true;
		};
		
		/**
		*	Adds an item to the list at a specific spot.
		*/
		override public function addItemAt(oItem:*, nIndex:int):Boolean
		{
			if (nIndex >= nSize) return false;
			_aoItems.splice(nIndex, 0, oItem);
			return true;
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