///////////////////////////////////////////////////
//	InputConverter
//	CREATED: 2009-10-05.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	import com.chasedelanguillette.system.input.InputManager;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class InputConverter
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		public static const ACTION_NORTH_WEST:int				= 0;
		public static const ACTION_NORTH:int					= 1;
		public static const ACTION_NORTH_EAST:int				= 2;
		public static const ACTION_WEST:int						= 3;
		public static const ACTION_EAST:int						= 4;
		public static const ACTION_SOUTH_WEST:int				= 5;
		public static const ACTION_SOUTH:int					= 6;
		public static const ACTION_SOUTH_EAST:int				= 7;
		public static const ACTION_WAIT:int						= 8;
		public static const ACTION_TOGGLE_MAP:int 				= 9;
		public static const ACTION_INVENTORY:int 				= 10;
		public static const ACTION_PICK_UP:int 					= 11;
		public static const ACTION_ATTACK:int 					= 12;
		public static const ACTION_MENU:int 					= 13;
		public static const ACTION_FIRE:int 					= 14;
		public static const ACTION_READ_SCROLL:int 				= 15;
		public static const ACTION_EAT:int 						= 16;
		public static const ACTION_USE_STAVE:int 				= 17;
		public static const ACTION_SWITCH_WEAPONS:int			= 18;
		
		// MINIMAP DEMO CRAP
		public static const ACTION_GENERATE_NEXT_FLOOR:int 		= 19;
		public static const ACTION_GENERATE_PREV_FLOOR:int 		= 20;
		
		//
		public static const ACTION_GENERATE_DUNGEON:int = 21;
		public static const ACTION_GENERATE_STREETS:int = 22;
		public static const ACTION_GENERATE_CAVES:int = 23;
		public static const ACTION_GENERATE_MYSTERY_DUNGEON:int = 24;
		public static const ACTION_GENERATE_ALL:int = 25;
		
		public static const ACTION_TOGGLE_GAME_VIEW:int = 26
		
		
		public static const ACTION_TOTAL:int 					= 27;
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		var defaultControls:Array = new Array(ACTION_TOTAL);	
		var currentControls:Array = new Array(ACTION_TOTAL);
		var actionNames:Array = new Array();
			
			
		var keyNames:Array = new Array();				// an array of our key names so we can display them in the UI
		var keyActions:Array = new Array(225);			// an array, indexed by all the keys on the keyboard, indicates which action index has been assigned to the key.  if no action has been assigned, it will be -1
		var buttons:Array = new Array();				// an array of all our UI buttons
		
		private var _oInputManager:InputManager = null;
		private var _nActionId:int = -1
		
		/**
		*	@constructor
		*/
		public function InputConverter(singleton:SingletonEnforcer):void
		{
			// init default controls!
			defaultControls[InputConverter.ACTION_NORTH_WEST] 				= InputManager.KEY_Q;
			defaultControls[InputConverter.ACTION_NORTH] 					= InputManager.KEY_W;
			defaultControls[InputConverter.ACTION_NORTH_EAST] 				= InputManager.KEY_E;
			defaultControls[InputConverter.ACTION_WEST] 					= InputManager.KEY_A;
			defaultControls[InputConverter.ACTION_EAST] 					= InputManager.KEY_D;
			defaultControls[InputConverter.ACTION_SOUTH_WEST] 				= InputManager.KEY_Z;
			defaultControls[InputConverter.ACTION_SOUTH] 					= InputManager.KEY_X;
			defaultControls[InputConverter.ACTION_SOUTH_EAST] 				= InputManager.KEY_C;
			
			
			defaultControls[InputConverter.ACTION_WAIT] 					= InputManager.KEY_S;
			defaultControls[InputConverter.ACTION_TOGGLE_MAP] 				= InputManager.KEY_M;
			defaultControls[InputConverter.ACTION_INVENTORY] 				= -1;//InputManager.KEY_1;
			defaultControls[InputConverter.ACTION_PICK_UP]		 			= InputManager.KEY_P;
			defaultControls[InputConverter.ACTION_ATTACK] 					= InputManager.KEY_SPACE;
			defaultControls[InputConverter.ACTION_MENU] 					= InputManager.KEY_QUESTION;
			defaultControls[InputConverter.ACTION_FIRE] 					= -1;//InputManager.KEY_2;
			defaultControls[InputConverter.ACTION_READ_SCROLL] 				= InputManager.KEY_R;
			defaultControls[InputConverter.ACTION_EAT] 						= InputManager.KEY_G;
			defaultControls[InputConverter.ACTION_USE_STAVE] 				= InputManager.KEY_V;
			defaultControls[InputConverter.ACTION_SWITCH_WEAPONS] 			= InputManager.KEY_T;
			
			defaultControls[InputConverter.ACTION_GENERATE_NEXT_FLOOR] 			= -1;//InputManager.KEY_L;
			defaultControls[InputConverter.ACTION_GENERATE_PREV_FLOOR] 			= -1;//InputManager.KEY_K;
			
			defaultControls[InputConverter.ACTION_GENERATE_DUNGEON] 			= InputManager.KEY_1;
			defaultControls[InputConverter.ACTION_GENERATE_STREETS] 			= InputManager.KEY_2;
			defaultControls[InputConverter.ACTION_GENERATE_CAVES] 				= InputManager.KEY_3;
			defaultControls[InputConverter.ACTION_GENERATE_MYSTERY_DUNGEON] 	= InputManager.KEY_4;
			defaultControls[InputConverter.ACTION_GENERATE_ALL] 				= InputManager.KEY_5;
			
			defaultControls[InputConverter.ACTION_TOGGLE_GAME_VIEW] 			= InputManager.KEY_L;
			
			

			// init action names!
			actionNames[InputConverter.ACTION_NORTH_WEST] 					= "Move/Face North-West";
			actionNames[InputConverter.ACTION_NORTH] 						= "Move/Face North";
			actionNames[InputConverter.ACTION_NORTH_EAST] 					= "Move/Face North-East";
			actionNames[InputConverter.ACTION_WEST] 						= "Move/Face West";
			actionNames[InputConverter.ACTION_EAST] 						= "Move/Face East";
			actionNames[InputConverter.ACTION_SOUTH_WEST] 					= "Move/Face South-West";
			actionNames[InputConverter.ACTION_SOUTH] 						= "Move/Face South";
			actionNames[InputConverter.ACTION_SOUTH_EAST] 					= "Move/Face South-East";
			actionNames[InputConverter.ACTION_WAIT] 						= "Wait/Rest";
			actionNames[InputConverter.ACTION_TOGGLE_MAP] 					= "Toggle Map On/Off";
			actionNames[InputConverter.ACTION_INVENTORY] 					= "Inventory";
			actionNames[InputConverter.ACTION_PICK_UP]		 				= "Pick Up";
			actionNames[InputConverter.ACTION_ATTACK] 						= "Attack";
			actionNames[InputConverter.ACTION_MENU] 						= "Main Menu";
			actionNames[InputConverter.ACTION_FIRE] 						= "Fire";
			actionNames[InputConverter.ACTION_READ_SCROLL] 					= "Read Scroll";
			actionNames[InputConverter.ACTION_EAT] 							= "Eat";
			actionNames[InputConverter.ACTION_USE_STAVE] 					= "Use Stave";
			actionNames[InputConverter.ACTION_SWITCH_WEAPONS] 				= "Switch Weapons";
			
			actionNames[InputConverter.ACTION_GENERATE_NEXT_FLOOR] 			= "Next Floor";
			actionNames[InputConverter.ACTION_GENERATE_PREV_FLOOR] 			= "Prev Floor";
			
			resetControls();
			mapKeysToActions();
		};
		
		private static var instance:InputConverter;
		public static function getInstance():InputConverter
		{
			if (instance == null) instance = new InputConverter(new SingletonEnforcer())
			return instance;
		}

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		/**
		*	set a reference to the input manager this wrapper relies on.
		*/
		public function setInputManager(oInputManager:InputManager):void
		{
			_oInputManager = oInputManager;
			_oInputManager.clearKeysToWatch();
			for (var key:String in defaultControls)
			{
				_oInputManager.watchKey(defaultControls[key]);
			}
		};
		
		
		/**
		*	should be called every frame.
		*	
		*	<p>If no InputManager instance has been set, this class is useless </p>
		*/
		public function update():int
		{
			if(_oInputManager != null) 
			{
				return handleUpdate();
			}
			else
			{
				trace("InputConverter::update() :: warning :: you want to do an input update, but yr InputConverter doesn't have a reference to the InputManager class!");
			}
			return -1;
		};
		
		
		/**
		*	Checks for relevant key presses from InputManager
		*/
		private function handleUpdate():int
		{
			var action:int = getActionFromInput();
			_oInputManager.update();
			return action;
			
		}
		
		private function getActionFromInput():int
		{
			
			if ( _oInputManager.keyReleased( currentControls[InputConverter.ACTION_TOGGLE_GAME_VIEW] ) )
			{
				return InputConverter.ACTION_TOGGLE_GAME_VIEW;
			}
			else if ( _oInputManager.keyReleased( currentControls[InputConverter.ACTION_TOGGLE_MAP] ) )
			{
				return InputConverter.ACTION_TOGGLE_MAP;
			}
			
			if ( _oInputManager.keyReleased( currentControls[InputConverter.ACTION_GENERATE_NEXT_FLOOR] ) )
			{
				return InputConverter.ACTION_GENERATE_NEXT_FLOOR;
			}
			else if ( _oInputManager.keyReleased( currentControls[InputConverter.ACTION_GENERATE_PREV_FLOOR] ) )
			{
				return InputConverter.ACTION_GENERATE_PREV_FLOOR;
			}
			//==============================
			else if ( _oInputManager.keyReleased( currentControls[InputConverter.ACTION_GENERATE_DUNGEON] ) )
			{
				return InputConverter.ACTION_GENERATE_DUNGEON;
			}
			else if ( _oInputManager.keyReleased( currentControls[InputConverter.ACTION_GENERATE_STREETS] ) )
			{
				return InputConverter.ACTION_GENERATE_STREETS;
			}
			else if ( _oInputManager.keyReleased( currentControls[InputConverter.ACTION_GENERATE_CAVES] ) )
			{
				return InputConverter.ACTION_GENERATE_CAVES;
			}
			else if ( _oInputManager.keyReleased( currentControls[InputConverter.ACTION_GENERATE_MYSTERY_DUNGEON] ) )
			{
				return InputConverter.ACTION_GENERATE_MYSTERY_DUNGEON;
			}
			else if ( _oInputManager.keyReleased( currentControls[InputConverter.ACTION_GENERATE_ALL] ) )
			{
				return InputConverter.ACTION_GENERATE_ALL;
			}
			
			
			// check NW, SE
			if ( _oInputManager.keyDown( currentControls[InputConverter.ACTION_NORTH_WEST]) )
			{
				return InputConverter.ACTION_NORTH_WEST;
			}
			else if (_oInputManager.keyDown( currentControls[InputConverter.ACTION_SOUTH_EAST] ))
			{
				return InputConverter.ACTION_SOUTH_EAST;
			}
			
			// check N, S
			if ( _oInputManager.keyDown( currentControls[InputConverter.ACTION_NORTH] ) )
			{
				return InputConverter.ACTION_NORTH;
			}
			else if (_oInputManager.keyDown( currentControls[InputConverter.ACTION_SOUTH] ))
			{
				return InputConverter.ACTION_SOUTH;
			}
			
			// check W, E
			if ( _oInputManager.keyDown(currentControls[InputConverter.ACTION_WEST] ) )
			{
				return InputConverter.ACTION_WEST;
			}
			else if (_oInputManager.keyDown( currentControls[InputConverter.ACTION_EAST] ))
			{
				return InputConverter.ACTION_EAST;
			}
			
			// check NE, SW
			if ( _oInputManager.keyDown( currentControls[InputConverter.ACTION_NORTH_EAST] ) )
			{
				return InputConverter.ACTION_NORTH_EAST;
			}
			else if (_oInputManager.keyDown( currentControls[InputConverter.ACTION_SOUTH_WEST] ) )
			{
				return InputConverter.ACTION_SOUTH_WEST;
			}
			
			if ( _oInputManager.keyDown( currentControls[InputConverter.ACTION_ATTACK] ) )
			{
				return InputConverter.ACTION_ATTACK;
			}
			
			if ( _oInputManager.keyDown( currentControls[InputConverter.ACTION_WAIT] ) )
			{
				return InputConverter.ACTION_WAIT;
			}
			
			if ( _oInputManager.keyDown( currentControls[InputConverter.ACTION_PICK_UP] ) )
			{
				return InputConverter.ACTION_PICK_UP;
			}
									
			return -1;
			
		}
		
		
		/**
		*	Reassigns in-game action to a different key.
		*/
		public function mapActionToKey(nActionId:int, nKeyId:int):void
		{
			
		};
		
		
		/**
		*	Resets all controls to their default.
		*/
		public function resetControls():void
		{
			for ( var i:int = 0; i < InputConverter.ACTION_TOTAL; i++ )
			{
				currentControls[i] = defaultControls[i];
			}
		};
		
		
		/**
		*	assigns keys to an action. 
		*
		*	<p>if no action, it assigns -1</p>
		*/
		public function mapKeysToActions():void
		{
			for ( var i:int = 0; i < currentControls.length; i ++ )
			{
				var bAssigned:Boolean = false;
				for ( var j:int = 0; j < keyActions.length; j++ )
				{
					if (currentControls[i] == j){
						keyActions[j] = i;
						bAssigned = true;
						break;
					}
				}
				if (!bAssigned) keyActions[j] = -1;
			}
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
};
internal class SingletonEnforcer{};