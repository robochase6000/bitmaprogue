///////////////////////////////////////////////////
//	FrontEndManager
//	CREATED: 2009-09-21.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.startup
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.startup.InitSystem;
	
	//============================================
	//	NATIVE IMPORTS
	//============================================
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	public class FrontEndManager extends EventDispatcher
	{
		
		
		public var id:int = -1;	
		private var _oInitSystem:InitSystem = InitSystem.getInstance();	
		
		
		private var _bInitialized:Boolean = false;
		private var _oStage:Stage;
		
		
		//============================================================================
		//	SINGLETON STUFF - GRAB AN INSTANCE WITH UIManager.getInstance()
		//============================================================================

		private static var instance:FrontEndManager;
		
		public function FrontEndManager(o:SingletonEnforcer):void
		{
			
		};
		
		public static function getInstance():FrontEndManager
		{
			if (instance==null)
			{
				instance = new FrontEndManager(new SingletonEnforcer());
			}
			return instance;
		}
		
		public function cleanup():void
		{
			trace("FrontEndManager::cleanup()");
			_oStage = null;
			// & whatever else
		};
		
		public function initialize(stageReference:Stage):void
		{
			trace("FrontEndManager::initialize()");
			if ( !_bInitialized )
			{
				_oStage = stageReference;
				
				// conditionally skip the front end!
				if (_oInitSystem.bSkipFrontEnd)
				{
					trace("FrontEndManager::initialize() -> SKIPPING FRONT END");
					dispatchEvent(new Event(Event.COMPLETE));
				}
				else
				{
					trace("FrontEndManager::initialize() -> INITIALIZING FRONT END");
					// intiialize the UI!
				}
			}
		};
		
		
		//============================================
		//	MAIN UPDATE FUNCTION - SHOULD BE LOOPED ON
		//============================================

		
		public function update():void
		{
			checkInput();
			
		};
		
		private function checkInput():void
		{
			
		};
	}
}

internal class SingletonEnforcer{};