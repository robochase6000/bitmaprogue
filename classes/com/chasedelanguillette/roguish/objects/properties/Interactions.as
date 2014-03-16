///////////////////////////////////////////////////
//	Interactivity
//	CREATED: 2009-11-06.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//	EXAMPLE: hero is a container (can hold items), is droppable ( if you can pick it up lol ), is living, can be eaten, etc
//
//	hero.objectInteractions = (IS_CONTAINER | IS_DROPPABLE | IS_HOLDABLE | IS_VIEWABLE | IS_THROWABLE | IS_EDIBLE | IS_LIVING);
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
	import com.chasedelanguillette.Bits;
	
	
	
	public class Interactions
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		/**
		*	Indicates whether the object can hold other items.
		*	
		*/
		public static const IS_CONTAINER:int = Bits.BIT_01		
		
		/**
		*	Indicates whether the object can be dropped
		*/
		public static const IS_DROPPABLE:int = Bits.BIT_02
		
		/**
		*	Indicates whether the object may be equipped by humanoids.
		*/
		public static const IS_EQUIPPABLE:int = Bits.BIT_03
		
		/**
		*	Indicates whether the object can be held, and thusly, inserted into inventory.
		*/
		public static const IS_HOLDABLE:int = Bits.BIT_04
		
		/**
		*	Indicates whether the object is pushable, like that japanese box game.
		*/
		public static const IS_PUSHABLE:int = Bits.BIT_05
		
		/**
		*	Indicates whether the object is readable (Magic tomes, for example)
		*/
		public static const IS_READABLE:int = Bits.BIT_06
		
		/**
		*	Indicates whether the object is swingable (Magic Staves, for example)
		*/
		public static const IS_SWINGABLE:int = Bits.BIT_07
		
		/**
		*	Indicates wehther the object is castable (a Scroll for example)
		*/
		public static const IS_CASTABLE:int = Bits.BIT_09
		
		/**
		*	Indicates whether the object is writable. (a scroll, for example)
		*/
		public static const IS_WRITABLE:int = Bits.BIT_10
		
		/**
		*	Indicates whether the item may be memorizable (????? just throwing out ideas.)
		*/
		public static const IS_MEMORIZABLE:int = Bits.BIT_11
		
		/**
		*	Indicates whether the object is viewable. Viewable items should have a physical description.
		*/
		public static const IS_VIEWABLE:int = Bits.BIT_12
		
		/**
		*	Indicates whether the object may be thrown.
		*/
		public static const IS_THROWABLE:int = Bits.BIT_13
		
		/**
		*	Indicates whether the item may be eaten.
		*/
		public static const IS_EDIBLE:int = Bits.BIT_14
		
		/**
		*	Indicates wehther the item may be quaffed.
		*/
		public static const IS_DRINKABLE:int = Bits.BIT_15
		
		/**
		*	Indicates whether the item is injectible into other things.
		*/
		public static const IS_INJECTABLE:int = Bits.BIT_16
		
		/**
		*	Is it like a gun? may it be shot?
		*/
		public static const IS_SHOOTABLE:int = Bits.BIT_17;
		
		/**
		*	Is it living? If it's living, then it has an entirely new set of interactive options
		*/
		public static const IS_LIVING:int = Bits.BIT_18;
		
		/**
		*	Can it be locked? This would be nice for containers.
		*/
		public static const IS_LOCKABLE:int = Bits.BIT_18;
	}
}