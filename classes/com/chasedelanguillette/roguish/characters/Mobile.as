///////////////////////////////////////////////////
//	Mobile
//	CREATED: 2009-09-18.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.characters
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.rendering.animation.characters.CharacterAnimation;//import game.characters.Animation;
	import com.chasedelanguillette.roguish.defines.GameDefines;
	
	import com.chasedelanguillette.geom.SimplePoint;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class Mobile
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		public static const HERO:int = 0;
		public static const MONSTER:int = 1;
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public var moveMade:Boolean = false;
		public var id:int;
		public var tx:int;
		public var ty:int;
		public var dir:int = Math.floor(Math.random() * 8);
		//public var ai:BaseAI;
		public var animation:CharacterAnimation;
		
		public var nEnergy:int = Math.ceil(Math.random() * 100);
		public var nEnergyPerTurn:int = Math.ceil(Math.random() * 100);
		
		/**
		*	A list of moves this mobile has taken, with 0 being the most recent.
		*/
		public var bMovedLastFrame:Boolean = false;
		public var bTrackMoves:Boolean = false;
		private var _moveHistory:Array = new Array();
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function Mobile(bTrackMoves:Boolean = false):void
		{
			this.bTrackMoves = bTrackMoves;
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function takeTurn():void
		{
			//trace("Mobile::takeTurn()");
		//	if ( this.ai != null ) this.ai.takeTurn(this);
		};
		
		
		/**
		*	Adds a move to the mobile's move history.
		*	
		*	<p>Tracking move history can have many neat benefits.</p>  
		*	
		*	<p>For example, enemies might be able to hunt each other now that we know the path a creature has been taking.  
		*	ideally, move history max would be set to -1 so there would be no limit</p>
		*/
		public function addMove():void
		{
			//trace("Mobile::addMove() -> STORING MOVE!!");
			// add the most recent move
			var move:SimplePoint = new SimplePoint(tx, ty);
			_moveHistory.unshift(move);
			
			// if there is a positive MOVE_HISTORY_MAX, we must trim off moves to keep memory sizes managable.
			// if the MOVE_HISTORY_MAX is negative, we can assume there is no maximum set and we should just store everything.
			if ( GameDefines.MOVE_HISTORY_MAX >= 0 )
			{
				// if the moveHistory is too long, we're going to splice them off and free them up to garbage collection.
				if (_moveHistory.length >= GameDefines.MOVE_HISTORY_MAX) 
				{
					// lop off everything that is beyond our max move history
					var spliced:Array = _moveHistory.splice(GameDefines.MOVE_HISTORY_MAX, _moveHistory.length - GameDefines.MOVE_HISTORY_MAX);
				
					//trace("Mobile::addMove() -> SPLICED " + spliced.length + " MOVES FROM HISTORY.");
					// force garbage collection on that shit.
					for (var i:int = 0; i < spliced.length; i++) spliced[i] = null;
					spliced = null;
				}
			}
		};
		
		
	
		//////////////////////////////////////////////
		//
		//	GETTERS
		//
		//////////////////////////////////////////////
		
		public function get moveHistory():Array{
			return _moveHistory;
		}
		
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