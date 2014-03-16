///////////////////////////////////////////////////
//	Animation
//	CREATED: 2009-10-09.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.rendering.animation
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class Animation 
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		public static const LOOPING:int = -1;
		public static const COMPLETE:int = -2;
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public var anAnimationCycle_Current:Array;
		public var nAnimationId:int = -1;
		public var nDirection:int = -1;
		public var nAnimationState:int = 0;
		public var nKeyFrameCount:int = 0;
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		/**
		*	@constructor
		*/
		public function Animation():void
		{
			// 
			
		};
		
		
		/**
		*	plays this animation
		*/
		public function play(nAnimationId:int, nDirection:int):void
		{
			this.nAnimationId 			= nAnimationId;
			this.nDirection 			= nDirection;
			this.nAnimationState 		= 0;
			this.nKeyFrameCount			= 0;
			this.anAnimationCycle_Current	= anSetAnimationCycle(nAnimationId);
		};
		
		
		/**
		*	Causes the animation to play it's next frame.
		*	
		*	<p>Returns the current frame number</p>
		*/
		public function update():int
		{
			this.nKeyFrameCount++;
			if(this.nKeyFrameCount > anAnimationCycle_Current[nAnimationState] ) 
			{
				this.nKeyFrameCount = 0;
				this.nAnimationState++;
			}
			
			if ( bAnimationComplete(nAnimationId, nAnimationState))
			{
				if ( bAnimationLoops(nAnimationId))
				{
					// loop the animation!
					play(nAnimationId, nAnimationState);
					//return Animation.LOOPING
				}
				else
				{
					// dispatch complete event!
					return Animation.COMPLETE;
				}
				return 0;
			}

			return this.nAnimationState + nAnimationId;
		};
		
		public function get currentFrame():int
		{
			return this.nAnimationState + nAnimationId;
		}
		
		
		/**
		*	Sets the animation cycle to use.
		*/
		public function anSetAnimationCycle(nAnimationId:int):Array
		{
			/*
			// example
			switch (nAnimationId)
			{
				case Animation.WALK :
					return Animation.anAnimationCycle_Walk;
				break;
				case Animation.IDLE :
					return Animation.anAnimationCycle_Idle;
				break;
				case Animation.ATTACK :
					return Animation.anAnimationCycle_Attack;
				break;
				case Animation.ATTACKED :
					return Animation.anAnimationCycle_Attacked;
				break;
				case Animation.EAT :
					return Animation.anAnimationCycle_Eat;
				break;
			}
			*/
			return null;
		};
		
		
		/**
		*	Returns whether the animation has finished playing.
		*/
		public function bAnimationComplete(nAnimationId:int, nAnimationState:int):Boolean
		{
			/*
			// example
			switch (nAnimationId)
			{
				case Animation.WALK :
					if ( nAnimationState >= anAnimationCycle_Walk.length  ) return true;
				break;
				case Animation.IDLE :
					if ( nAnimationState >= anAnimationCycle_Idle.length  ) return true;
				break;
				case Animation.ATTACK :
					if ( nAnimationState >= anAnimationCycle_Attack.length  ) return true;
				break;
				case Animation.ATTACKED :
					if ( nAnimationState >= anAnimationCycle_Attacked.length  ) return true;
				break;
				case Animation.EAT :
					if ( nAnimationState >= anAnimationCycle_Eat.length  ) return true;
				break;
			}
			*/
			return false;
		};
		
		
		/**
		*	Returns whether the specified animation is meant to loop or not.
		*	
		*	@param nAnimationId	The indexed animation to be examined.
		*/
		public function bAnimationLoops(nAnimationId:int):Boolean
		{
			/*
			// example
			switch (nAnimationId)
			{
				case Animation.WALK :
					return true;
				break;
				case Animation.IDLE :
					return true;
				break;
				case Animation.ATTACK :
					return false;
				break;
				case Animation.ATTACKED :
					return false;
				break;
				case Animation.EAT :
					return true;
				break;
			}
			*/
			return false;
		};
		
		public function getAnimationLength(nAnimationId:int):int
		{
			return 0;
		}
		
	}
}