///////////////////////////////////////////////////
//	LivingObject
//	CREATED: 2009-11-09.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//	A living object can die.  It has an age, an average lifespan, and hp.
//	A living object is living and can be eaten.
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.objects.physicalObjects.living
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.objects.physicalObjects.PhysicalObject;
	
	import com.chasedelanguillette.roguish.objects.properties.Interactions;
	import com.chasedelanguillette.roguish.objects.properties.PhysicalStats;
	
	import com.chasedelanguillette.roguish.objects.intangibles.ai.AI;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class LivingObject extends PhysicalObject
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		public static const HUMAN:int = 0;
		public static const DWARF:int = 1;
		public static const ELF:int = 2;
		public static const MINOTAUR:int = 3;
		public static const CENTAUR:int = 4;
		public static const SPIDERLING:int = 5;
		public static const ORC:int = 6;
		public static const BROWNIE:int = 7;
		public static const PIXIE:int = 8;
		public static const FAIRY:int = 9;
		public static const DRAGON:int = 10;
		public static const SLIMER:int = 11;
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		/**
		*	Denotes this Living object's starting stats so we always know what to fall back to.
		*/
		public static var oDefaultStats:PhysicalStats;
		
		/**
		*	The current stats for this instance of a living object.
		*/
		public var oStats:PhysicalStats;
		
		/**
		*	AI object; both plants and animals alike may use ai, though a plant's ai will be very, very simple.
		*/
		public var oAI:AI;
		
		/**
		*	
		*/
		public var bMoveMade:Boolean = false;
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////asdas
		
		public function LivingObject():void
		{
			super();
			
			nInteractionsAsObject |= (Interactions.IS_EDIBLE | Interactions.IS_LIVING);
			
			LivingObject.oDefaultStats = new PhysicalStats();
			oStats = new PhysicalStats();
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function setAI(ai:AI):void
		{
			oAI = ai;
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