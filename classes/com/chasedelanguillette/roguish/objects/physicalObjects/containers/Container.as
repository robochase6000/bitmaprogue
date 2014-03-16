///////////////////////////////////////////////////
//	Container
//	CREATED: 2009-11-06.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//	A container is a physical object that can contain other physical objects.
//	At the very least, we expect a container to hold other objects; This class has an array to carry that functionality.
//	If you need a more complex container, extend the class!
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.objects.physicalObjects.containers
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.objects.physicalObjects.PhysicalObject;
	import com.chasedelanguillette.roguish.objects.properties.Interactions;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class Container extends PhysicalObject
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		public static const SORT_TYPE:int = 0;
		public static const SORT_WEIGHT:int = 1;
		public static const SORT_QUANTITY:int = 2;
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		protected var _aoItems:Array = new Array();
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		/**
		*	@constructor
		*/
		public function Container():void
		{
			super()
			
			nInteractionsAsObject |= (Interactions.IS_CONTAINER);
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function get aoItems():Array{
			return _aoItems;
		};
		
		/**
		*	Tries to add item to the end of the list.  Returns result.
		*/
		public function addItem(oItem:*):Boolean
		{
			_aoItems.push(oItem);
			return true;
		};
		
		/**
		*	Adds an item to the list at a specific spot.
		*/
		public function addItemAt(oItem:*, nIndex:int):Boolean
		{
			_aoItems.splice(nIndex, 0, oItem);
			return true;
		};
		
		/**
		*	Removes item at specified index.
		*/
		public function removeItemAt(nIndex:int):*
		{
			var oItem:* = _aoItems.splice(nIndex, 1);
			return oItem;
		};
		
		/**
		*	Tries to remove a specific item from the container.
		*	
		*	<p>Returns a bool indicating whether the removal was successful.</p>
		*/
		public function removeItem(oItem:*):Boolean
		{
			for (var nItemIndex:int = 0; nItemIndex < _aoItems.length; nItemIndex++)
			{
				var oCurrentItem:* = _aoItems[nItemIndex];
				if ( oItem == oCurrentItem ){
					_aoItems.splice(nItemIndex, 1);
					return true;
				}
			}
			return false;
		};
		
		/**
		*	Auto-arranges contents, presumably by type.
		*
		*	<p>I thought about this, and I really don't want to sort by weight.  I can't sort by quantity because items dont' stack!</p>
		*/
		public function autoArrange():void
		{
			
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