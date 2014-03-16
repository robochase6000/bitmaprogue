///////////////////////////////////////////////////
//	CharacterAnimation
//	CREATED: 2009-10-09.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.rendering.animation.characters
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.rendering.animation.Animation;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class CharacterAnimation extends Animation
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		// these constants actually refer to the X position of the first frame of each corresponding animation!
		public static const WALK:int 		= 0;
		public static const IDLE:int 		= 20;
		public static const ATTACK:int 		= 4;
		public static const ATTACKED:int 	= 6;
		public static const EAT:int 		= 7;
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public static var anAnimationCycle_Walk:Array 			= [6,6,6,6];
		public static var anAnimationCycle_Idle:Array 			= [1,1,1,1];
		public static var anAnimationCycle_Attack:Array 		= [10,16];
		public static var anAnimationCycle_Attacked:Array 		= [20];
		public static var anAnimationCycle_Eat:Array 			= [10,10,10];
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function CharacterAnimation():void
		{
			
		};
		/**
		*	Sets the animation cycle to use.
		*/
		override public function anSetAnimationCycle(nAnimationId:int):Array
		{
			
			// example
			switch (nAnimationId)
			{
				case CharacterAnimation.WALK :
					return CharacterAnimation.anAnimationCycle_Walk;
				break;
				case CharacterAnimation.IDLE :
					return CharacterAnimation.anAnimationCycle_Idle;
				break;
				case CharacterAnimation.ATTACK :
					return CharacterAnimation.anAnimationCycle_Attack;
				break;
				case CharacterAnimation.ATTACKED :
					return CharacterAnimation.anAnimationCycle_Attacked;
				break;
				case CharacterAnimation.EAT :
					return CharacterAnimation.anAnimationCycle_Eat;
				break;
			}
			
			return null;
		};
		
		
		/**
		*	Returns whether the animation has finished playing.
		*/
		override public function bAnimationComplete(nAnimationId:int, nAnimationState:int):Boolean
		{
			
			// example
			switch (nAnimationId)
			{
				case CharacterAnimation.WALK :
					if ( nAnimationState >= anAnimationCycle_Walk.length  ) return true;
				break;
				case CharacterAnimation.IDLE :
					if ( nAnimationState >= anAnimationCycle_Idle.length  ) return true;
				break;
				case CharacterAnimation.ATTACK :
					if ( nAnimationState >= anAnimationCycle_Attack.length  ) return true;
				break;
				case CharacterAnimation.ATTACKED :
					if ( nAnimationState >= anAnimationCycle_Attacked.length  ) return true;
				break;
				case CharacterAnimation.EAT :
					if ( nAnimationState >= anAnimationCycle_Eat.length  ) return true;
				break;
			}
			
			return false;
		};
		
		
		/**
		*	Returns whether the specified animation is meant to loop or not.
		*	
		*	@param nAnimationId	The indexed animation to be examined.
		*/
		override public function bAnimationLoops(nAnimationId:int):Boolean
		{
			
			// example
			switch (nAnimationId)
			{
				case CharacterAnimation.WALK :
					return true;
				break;
				case CharacterAnimation.IDLE :
					return true;
				break;
				case CharacterAnimation.ATTACK :
					return false;
				break;
				case CharacterAnimation.ATTACKED :
					return false;
				break;
				case CharacterAnimation.EAT :
					return true;
				break;
			}
			
			return false;
		};
		
		override public function getAnimationLength(nAnimationId:int):int
		{
			var anAnimation:Array = null;
			switch (nAnimationId)
			{
				case CharacterAnimation.WALK :
					anAnimation = anAnimationCycle_Walk;
				break;
				case CharacterAnimation.IDLE :
					anAnimation = anAnimationCycle_Idle;
				break;
				case CharacterAnimation.ATTACK :
					anAnimation = anAnimationCycle_Attack;
				break;
				case CharacterAnimation.ATTACKED :
					anAnimation = anAnimationCycle_Attacked;
				break;
				case CharacterAnimation.EAT :
					anAnimation = anAnimationCycle_Eat;
				break;
			}
			
			var nTotal:int = 0;
			if ( anAnimation != null )
			{
				for ( var i:int = 0; i < anAnimation.length; i++ )
				{
					nTotal += anAnimation[i];
				}
			}
			
			return nTotal;
		}
	}
}