///////////////////////////////////////////////////
//	InitSystem
//	CREATED: 2009-09-21.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//	pretty much a singleton of global data & a nice place to initialize that data.  probably not the best idea!
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.startup
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.system.input.InputManager;
	import com.chasedelanguillette.roguish.defines.SystemDefines;
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.display.Stage;
	
	public class InitSystem
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public static var nStageWidth:int;
		public static var nStageHeight:int;
		public static var nHalfStageWidth:int;
		public static var nHalfStageHeight:int;
		
		public static var nRenderWidth:int;
		public static var nRenderHeight:int;
		public static var nRenderScale:int;

		
		// flow control!
		public var bSkipLogoParade:Boolean 			= true;
		public var bSkipFrontEnd:Boolean 			= true;
		public var bSkipGame:Boolean 				= false;
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		private var _oInputManaager:InputManager;
		private var _oStageRef:Stage;
		
		
		//============================================================================
		//	SINGLETON STUFF - GRAB AN INSTANCE WITH GameManager.getInstance()
		//============================================================================
		
		private static var instance:InitSystem;
		
		public function InitSystem(o:SingletonEnforcer):void
		{
			
		}
		
		public static function getInstance():InitSystem
		{
			if (instance==null)
			{
				instance = new InitSystem(new SingletonEnforcer());
			}
			return instance;
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function initialize(oStageRef:Stage):void
		{
			trace("InitSystem::initialize()");
			
			_oStageRef = oStageRef;
			InitSystem.nStageWidth = _oStageRef.stageWidth;
			InitSystem.nStageHeight = _oStageRef.stageHeight;
			InitSystem.nHalfStageWidth = _oStageRef.stageWidth / 2;
			InitSystem.nHalfStageHeight = _oStageRef.stageHeight / 2;
			
			InitSystem.nRenderWidth = InitSystem.nHalfStageWidth + 1
			InitSystem.nRenderHeight = InitSystem.nHalfStageHeight + 1
			InitSystem.nRenderScale = 2;
			
			// init input manager!
			InputManager.instance.initialize(_oStageRef);			
		};
		
		//////////////////////////////////////////////
		//
		//	GETTERS
		//
		//////////////////////////////////////////////
		
		public function get oInputManager():InputManager
		{
			return InputManager.instance;
		};
		
		public function get bDebugEnabled():Boolean{
			return SystemDefines.DEBUG_ENABLED;
		};
		
		public function get bHudEnabled():Boolean{
			
			return SystemDefines.HUD_ENABLED;
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
};


internal class SingletonEnforcer{};