///////////////////////////////////////////////////
//	Actions
//	CREATED: 2009-09-29.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
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
	
	
	public class Action
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		/*
		public static const MOVE:int 			= 0;
		public static const FACE_DIRECTION:int 	= 1;
		public static const INTERACT:int 		= 2;
		public static const ATTACK:int 			= 3;
		public static const USE_ITEM:int 		= 4;
		public static const THROW_ITEM:int 		= 5;
		public static const SHOOT:int 			= 6;
		public static const WARP:int 			= 7;
		public static const REST:int 			= 8;
		public static const RUN:int 			= 9;
		public static const PRAY:int 			= 10;
		public static const DROP_ITEM:int 		= 11;
		
		*/


		/**
		*	Indicates that no Action has been assigned yet.
		*/
		public static const NONE:int 					= 0;
		
		
		/**
		* Causes object to attempt to move in a specified direction.
		*	
		* <p>var params:Object = {nDirection:int};</p>
		*	
		* <p>Rules: object can only move one tile at a time, regardless of its speed.
		*	if the object can move faster than 1 tile per frame, the game manager should work that out.</p>
		*/
		public static const MOVE:int 					= 0;
		
		
		/**
		*	Causes object to face a particular direction.
		*	
		*	<p>var params:Object = {nDirection:int};
		*/
		public static const FACE_DIRECTION:int 			= 1;
		
		
		/**
		*	Interact with whatever is at a specific direction.
		*
		*	<p>if I decide to map interact and attack to the same button, the action object will still use INTERACT and ATTACK constants.
		*	The logic for determining whether to attack or interact would happen after the key press, but before the action object is put together.</p>
		*
		*	<p>var params:Object = {nDirection:int};
		*/
		public static const INTERACT:int				= 2;
		
		
		/**
		*	Attacks in a specific direction with attack id nAttackId
		*	
		*	<p>nAttackId is required because the object could attack with left arm, right arm, inherent species skill , etc.</p>
		*	
		*	<p>if I decide to map interact and attack to the same button, the action object will still use INTERACT and ATTACK constants.
		*	The logic for determining whether to attack or interact would happen after the key press, but before the action object is put together.</p>
		*
		*	<p>var params:Object = {nDirection:int, nAttackId:int};
		*/
		public static const ATTACK:int					= 3;
		
		
		/**
		*	The character wiill use an item nItemId on themselves.
		*	
		*	<p>Note that the character shouldn't care where the item came from, it will only care that the action is USE_ITEM XX.
		*	The game manager should work out where the item came from.  This allows us to have npc's use items on each other.
		*	
		*	<p>var params:Object = {nItemId:int};
		*/
		public static const USE_ITEM:int 				= 4;
		

		/**
		*	The character will throw an item nItemId at a target location.
		*	
		*	<p>The character doesn't care where the item came from - item origin is something the game manager should work out.</p>
		*	
		*	<p>Also note: the target is specific.  This allows the greatest flexibility.<p>
		*	
		*	<p>I'm going to make this separate from SHOOT because they are different.  Shooting a gun and throwing a gun are different.<p>
		*	
		*	<p>var params:Object = {nItemId:int, nTargetX:int, nTargetY:int}
		*	
		*/
		public static const THROW_ITEM:int				= 5;
		

		/**
		*	Shoots some item nItemId at a target location.
		*	
		*	<p>var params:Object = {nItemId:int, nTargetX:int, nTargetY:int}
		*/
		public static const SHOOT:int 					= 6;
		
		
		/**
		*	Causes character to teleport to a different position.
		*	
		*	<p>var params:Object = {nMapId:int, nPositionX:int, nPositionY:int}
		*
		*/
		public static const WARP:int					= 7;
		
		
		/**
		*	Causes character to rest one turn.
		*	
		*	<p>var params:Object = {};
		*/
		public static const REST:int					= 8;
		

		/**
		*	Causes the character to run in nDirection, presumably at double speed.  
		*	
		*	<p>This could sacrifice energy/stamina.  I need to think about it.</p>
		*	
		*	<p>I don't think I want to use this, as it might complicate things.  Could make player too powerful.</p>
		*	
		*	<p>var params:Object = {nDirection:int};
		*	
		*/
		public static const RUN:int						= 9;// MAYBE I'LL DO THIS, MAYBE NOT.
		

		/**
		*	Causes character to pray one turn.
		*	
		*	<p>This could either do a little or a lot, depending on the character.  
		*	When an evil Shaman starts praying, it might strike fear in enemies, for example.
		*	A person with good karma might see something beneficial come out of praying.<p>
		*	
		*	<p>You could pray to a God for something - weapons, armor, items, monsters, death, divine protection, etc.</p>
		*	
		*	<p>Praying could be put into the game and have absolutely no effect on the outcome of the game.
		*	It could send out positive, ambiguous messages to the log.  
		*	"You feel more confident in yourself." or "You feel reaffirmed with God behind your back."</p>
		*	
		*	<p>Example wishes: 
		*	WEAPON 
		*	ARMOR
		*	ITEM
		*	STRONG_MONSTERS
		*	WEAK_MONSTERS
		*	FOOD
		*	DEATH
		*	PROTECTION
		*	STRENGTH
		*	INTELLIGENCE
		*	
		*	<p>var params:Object = {nGodId:int, nWishId:int}<p>	
		*/
		public static const PRAY:int 					= 10;// CAN STRIKE FEAR IN THE DEVOUTLY RELIGIOUS
		
		
		/**
		*	Causes character to drop an item.
		*	
		*	<p>If the character trips and drops 5 items, there is a separate DROP_ITEM action for each item.</p>
		*	
		*	<p>This needs to be separate from PLACE_ITEM because placing a jar won't break it, whereas dropping a jar will.</p>
		*	
		*	<p>var params:Object = {nItemId:int, nPositionX:int, nPositionY:int};
		*	
		*/
		public static const DROP_ITEM:int 		= 11;
		
		
		/**
		*	Causes character to place an item.
		*	
		*	<p>Different from DROP_ITEM. Dropping an item could break it.  Placing an item will never break it.</p>
		*
		*/
		public static const PLACE_ITEM:int 		= 12;
		
		public static const FALL:int = 13;

		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		private var _nActionId:int = -1;
		private var _oParams:Object = null;
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		private static var _instance:Action;
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		/**
		*	@constructor
		*/
		public function Action(singleton:SingletonEnforcer):void
		{
			reset();
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public static function getInstance():Action
		{
			if (_instance == null)
			{
				_instance = new Action(new SingletonEnforcer());
			}
			return _instance;
		};
		
		public static function getParams(nActionId:int):Object
		{
			switch (nActionId)
			{
				case Action.MOVE :
					return {x:0, y:0};
				break;
				case Action.FACE_DIRECTION :
					
				break;
				case Action.INTERACT :
					
				break;
			}
			return null;
		};
		
		public function setAction(nActionId:int, oParams:Object):void
		{
			_nActionId = nActionId;
			_oParams = oParams;
		};
		
		public function reset():void
		{
			_nActionId = Action.NONE;
			_oParams = null;
		}
		
		//////////////////////////////////////////////
		//
		//	GETTERS
		//
		//////////////////////////////////////////////
		
		public function get id():int{
			return _nActionId;
		};

		public function get params():Object{
			return _oParams;
		};
		
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
internal class SingletonEnforcer{};