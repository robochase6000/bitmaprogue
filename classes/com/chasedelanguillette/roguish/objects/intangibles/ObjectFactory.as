///////////////////////////////////////////////////
//	ObjectFactory
//	CREATED: 2009-11-11.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.objects.intangibles
{
	
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	// LIST PHYSICAL OBJECTS HERE!
	import com.chasedelanguillette.roguish.objects.physicalObjects.PhysicalObject;
	import com.chasedelanguillette.roguish.objects.physicalObjects.environmental.Floor;
	
	
	// LIST PHYSICAL OBJECT PROPERTIES HERE!!
	import com.chasedelanguillette.roguish.objects.properties.Material;
	
	
	// LIST LIVING OBJECTS HERE!!
	import com.chasedelanguillette.roguish.objects.physicalObjects.living.LivingObject;
	import com.chasedelanguillette.roguish.objects.physicalObjects.living.humanoid.Humanoid;
	import com.chasedelanguillette.roguish.objects.physicalObjects.living.monsters.slimes.*;
	
	
	// LIST LIVING PROPERTIES HERE!!
	import com.chasedelanguillette.roguish.objects.properties.races.Human;
	import com.chasedelanguillette.roguish.objects.properties.races.Dwarf;
	import com.chasedelanguillette.roguish.objects.properties.races.Elf;
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	/**
	*	THE factory for every physical object in the game.
	*/
	public class ObjectFactory
	{
		
		// Fri Nov 13 08:03:52 CST 2009 CMD TODO: load these textures dynamically, probably!
		private static var _bmdHeroSheet:Shiren					= new Shiren(640, 640);
		private static var _bmdSpriteSheet_BlackBlob:Blob_Black	= new Blob_Black(640, 640);
		
		private static var _bmdIcon_Sword:Icon_Sword = new Icon_Sword(32, 32);
		
		private static var _oHumanRace:Human = new Human();
		
		
		/**
		*	
		*/
		public static function makeCreature(nCreatureId:int):LivingObject
		{
			var oCreature:LivingObject = null;
			
			switch(nCreatureId)
			{
				case LivingObject.HUMAN :
					oCreature = new Humanoid() as LivingObject;
					
					// initialize humanoid with HUMAN stats here
					oCreature.oStats = _oHumanRace.oGetStartingPhysicalStats();
					
					// initialize render data here?
					oCreature.oRenderData.spriteSheets = [_bmdHeroSheet];
					
				break;
				case LivingObject.DWARF :
					oCreature = new Humanoid() as LivingObject;
					
					// initialize humanoid with DWARF stats here.
					//oCreature.oStats = Dwarf.oGetStartingPhysicalStats();
					
					
				break;
				case LivingObject.ELF :
					oCreature = new Humanoid() as LivingObject;
					
					// initialize humanoid with ELF stats here.
					//oCreature.oStats = Elf.oGetStartingPhysicalStats();
					
					
				break;
				case LivingObject.SLIMER :
					oCreature = new Slime() as LivingObject;
					oCreature.oStats = _oHumanRace.oGetStartingPhysicalStats();
					oCreature.oRenderData.spriteSheets = [_bmdSpriteSheet_BlackBlob];
				break;
			}
			
			
			return oCreature;
		}
		
		public static function makeObject(nObjectId:int, nMaterial:int = 0):PhysicalObject
		{
			var oObject:PhysicalObject = null;
			
			switch (nObjectId)
			{
				
				case PhysicalObject.FLOOR :
					oObject = new Floor() as PhysicalObject;
					oObject.nMaterial = nMaterial;
				break;
				default :
					oObject = new PhysicalObject() as PhysicalObject;
					oObject.nMaterial = nMaterial;
					oObject.oRenderData.animates = false;
					oObject.oRenderData.icon = _bmdIcon_Sword;
				break;
			}
			return oObject;
		}
		
		
	}
}