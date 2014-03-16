///////////////////////////////////////////////////
//	Material
//	CREATED: 2009-11-05.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//	A list of materials and some functions that describe how they behave.
//	Every physical object in the world is made of a material.
//	For example, a person is made of the generic 'ORGANIC' material.
//	The person might be wearing a piece of armor made of STEEL and carrying a WOOD shield.
//	When struck by fire, we might roll the dice to see what burns.  
//	The STEEL armor is barely effect, the WOOD shield catches fire, and the ORGANIC person is badly burned.
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
	
	public class Material
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		public static const FIRE:int = Bits.BIT_01		
		public static const WATER:int = Bits.BIT_02
		public static const STONE:int = Bits.BIT_03
		public static const WOOD:int = Bits.BIT_04
		public static const CLOTH:int = Bits.BIT_05
		public static const LEATHER:int = Bits.BIT_06
		public static const STEEL:int = Bits.BIT_07
		public static const GOLD:int = Bits.BIT_09
		public static const SILVER:int = Bits.BIT_10
		public static const PLATINUM:int = Bits.BIT_11
		public static const BRONZE:int = Bits.BIT_12
		public static const CLAY:int = Bits.BIT_13
		public static const PLASTIC:int = Bits.BIT_14
		public static const RUBBER:int = Bits.BIT_15
		public static const PAPER:int = Bits.BIT_16
		public static const ORGANIC:int = Bits.BIT_17;
		public static const GLASS:int = Bits.BIT_18;
		public static const FLESH:int = Bits.BIT_19;
		public static const DRAGON_SCALE:int = Bits.BIT_20;
		public static const ROTTEN_FLESH:int = Bits.BIT_21;
		
		/*		
		// hereo, just to make copy & pasting quicker.
		if (nMaterialMask & Material.FIRE) return true;
		if (nMaterialMask & Material.WATER) return true;
		if (nMaterialMask & Material.STONE) return true;
		if (nMaterialMask & Material.WOOD) return true;
		if (nMaterialMask & Material.CLOTH) return true;
		if (nMaterialMask & Material.LEATHER) return true;
		if (nMaterialMask & Material.STEEL) return true;
		if (nMaterialMask & Material.GOLD) return true;
		if (nMaterialMask & Material.SILVER) return true;
		if (nMaterialMask & Material.PLATINUM) return true;
		if (nMaterialMask & Material.BRONZE) return true;
		if (nMaterialMask & Material.CLAY) return true;
		if (nMaterialMask & Material.PLASTIC) return true;
		if (nMaterialMask & Material.RUBBER) return true;
		if (nMaterialMask & Material.PAPER) return true;
		if (nMaterialMask & Material.ORGANIC) return true;
		if (nMaterialMask & Material.GLASS) return true;
		*/
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function Material():void
		{
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		/**
		* Gets base weight per unit.  Water is at the middle of the spectrum at 100.	
		*/
		public static function nBaseWeightPerUnit(nMaterialMask:int):int
		{
			if (nMaterialMask & Material.STEEL) return 200;
			if (nMaterialMask & Material.GOLD) return 200;
			if (nMaterialMask & Material.SILVER) return 200;
			if (nMaterialMask & Material.PLATINUM) return 200;
			if (nMaterialMask & Material.BRONZE) return 200;
			if (nMaterialMask & Material.STONE) return 200;
			
			if (nMaterialMask & Material.CLAY) return 150;
			
			if (nMaterialMask & Material.PLASTIC) return 125;
			if (nMaterialMask & Material.RUBBER) return 125;
			if (nMaterialMask & Material.GLASS) return 125;			
			
			if (nMaterialMask & Material.WATER) return 100;
			
			if (nMaterialMask & Material.PAPER) return 90;
			if (nMaterialMask & Material.ORGANIC) return 90;
			if (nMaterialMask & Material.FLESH) return 90;
			if (nMaterialMask & Material.DRAGON_SCALE) return 90;
			
			if (nMaterialMask & Material.WOOD) return 80;
			
			if (nMaterialMask & Material.LEATHER) return 60;
			
			if (nMaterialMask & Material.CLOTH) return 50;
			
			if (nMaterialMask & Material.FIRE) return 0;
			
			return 0;
		};
		
		
		public static function nGetBaseValue(nMaterial:int, nAmount:int):int
		{
			return nBaseValuePerUnit(nMaterial) * nAmount;
		};
		
		public static function nBaseValuePerUnit(nMaterialMask:int):int
		{
			if (nMaterialMask & Material.PLATINUM) return 10000;
			if (nMaterialMask & Material.GOLD) return 5000;
			if (nMaterialMask & Material.SILVER) return 1000;
			
			if (nMaterialMask & Material.LEATHER) return 100;
			if (nMaterialMask & Material.CLOTH) return 75;
			if (nMaterialMask & Material.PAPER) return 10;
			if (nMaterialMask & Material.PLASTIC) return 5;
			
			if (nMaterialMask & Material.CLAY) return 15;
			if (nMaterialMask & Material.GLASS) return 25;
			
			return 0;
		};
		
		public static function bMeldable(nMaterialMask:int):Boolean
		{
			if (nMaterialMask & Material.WOOD) return true;
			if (nMaterialMask & Material.FIRE) return true;
			if (nMaterialMask & Material.CLOTH) return true;
			if (nMaterialMask & Material.LEATHER) return true;
			if (nMaterialMask & Material.PAPER) return true;
			if (nMaterialMask & Material.PLASTIC) return true;
			
			return false;
		};
		
		/**
		*	Gives us an idea of how flammable a material is.
		*/
		public static function fFlammability(nMaterialMask:int):Number
		{
			if (nMaterialMask & Material.WOOD) return 0.95;
			if (nMaterialMask & Material.FIRE) return 1.0;
			if (nMaterialMask & Material.CLOTH) return 0.90;
			if (nMaterialMask & Material.LEATHER) return 0.75;
			if (nMaterialMask & Material.PAPER) return 1.0;
			if (nMaterialMask & Material.PLASTIC) return 0.25;
			if (nMaterialMask & Material.ORGANIC) return 0.95;
			if (nMaterialMask & Material.FLESH) return 0.8;
			if (nMaterialMask & Material.DRAGON_SCALE) return 0.33;
			
			return 0.0;
		};
		
		public static function bWaterDamages(nMaterialMask:int):Boolean
		{
			if (nMaterialMask & Material.FIRE) return true;
			if (nMaterialMask & Material.PAPER) return true;
			return false;
		};
		
		public static function fChanceToBreakWhenDropped(nMaterialMask:int):Number
		{
			// clay has a chance of breaking sometimes
			if (nMaterialMask & Material.CLAY) return 0.25;
			
			// glass always breaks
			if (nMaterialMask & Material.GLASS) return 1.0;
			
			return 0.0;
		};
		
		public static function fChanceToBreakWhenThrown(nMaterialMask:int):Number
		{
			// clay will always break when thrown
			if (nMaterialMask & Material.CLAY) return 1.0;
			
			// plastic won't always break
			if (nMaterialMask & Material.PLASTIC) return 0.5;
			
			// wood might break, but only rarely.
			if (nMaterialMask & Material.WOOD) return 0.1;
			
			// glass will always break when thrown.
			if (nMaterialMask & Material.GLASS) return 1.0
			
			return 0.0;
		};
		
		public static function bBounces(nMaterialMask:int):Boolean
		{
			if (nMaterialMask & Material.RUBBER) return true;
			return false;
		};
		
		public static function bRots(nMaterialMask:int):Boolean
		{
			if (nMaterialMask & Material.ORGANIC) return true;
			return false;
		};
		
		public static function bRusts(nMaterialMask:int):Boolean
		{
			if (nMaterialMask & Material.STEEL) return true;
			return false;
		};
		
		public static function bConductsElectricity(nMaterialMask:int):Boolean
		{
			if (nMaterialMask & Material.STEEL) return true;
			if (nMaterialMask & Material.GOLD) return true;
			if (nMaterialMask & Material.SILVER) return true;
			if (nMaterialMask & Material.PLATINUM) return true;
			if (nMaterialMask & Material.BRONZE) return true;
			if (nMaterialMask & Material.WATER) return true;
			if (nMaterialMask & Material.ORGANIC) return true;
			return false;
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