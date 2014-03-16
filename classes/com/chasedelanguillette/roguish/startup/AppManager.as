///////////////////////////////////////////////////
//	AppManager
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
	import com.chasedelanguillette.roguish.startup.Preloader;
	import com.chasedelanguillette.roguish.startup.InitSystem;
	import com.chasedelanguillette.roguish.startup.LogoParade;
	import com.chasedelanguillette.roguish.startup.FrontEndManager;
	import com.chasedelanguillette.roguish.startup.InGameManager;
	
	//============================================
	//	NATIVE IMPORTS
	//============================================
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.display.Stage;
	
	
	public class AppManager extends EventDispatcher
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		public static const MODE_INIT_SYSTEM:int 			= 0;
		public static const MODE_PRELOADER:int 				= 1;
		public static const MODE_LOGO_PARADE:int 			= 2;
		public static const MODE_FRONT_END:int 				= 3;
		public static const MODE_GAME:int 					= 4;
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		protected var _oStage:Stage;
		private var _bInitialized:Boolean = false;
		private var _nCurrentMode:int = MODE_INIT_SYSTEM;
		
		protected var _oPreloader:Preloader 				= new Preloader();
		protected var _oInitSystem:InitSystem 				= InitSystem.getInstance();
		protected var _oLogoParade:LogoParade 				= new LogoParade();
		protected var _oFrontEndManager:FrontEndManager 	= FrontEndManager.getInstance();
		protected var _oGameManager:InGameManager 			= InGameManager.getInstance();
		
		
		//============================================================================
		//	SINGLETON STUFF - GRAB AN INSTANCE WITH GameManager.getInstance()
		//============================================================================
		
		private static var instance:AppManager;
		
		public function AppManager(o:SingletonEnforcer):void
		{
			trace("AppManager::AppManager()");
		}
		
		public static function getInstance():AppManager
		{
			if (instance==null)
			{
				instance = new AppManager(new SingletonEnforcer());
			}
			return instance;
		};
		
		// AppManager instance needs to be initialized with a stage reference.
		// dumb, I know, but let's do the best that we can.
		public function initialize(stageReference:Stage):void
		{
			trace("AppManager::initialize()");
			
			if ( !_bInitialized )
			{
				_bInitialized = true;
				_oStage = stageReference;
				
				//_oPreloader.initialize();
				_oInitSystem.initialize(_oStage);
				
				_oLogoParade.id = MODE_LOGO_PARADE;
				_oLogoParade.addEventListener( Event.COMPLETE, handleSequenceComplete );
				_oLogoParade.initialize(_oStage);
				
				
				// intialize here!
				//_oStage.addEventListener( Event.ENTER_FRAME, vHandle_this_ENTER_FRAME );
			}
		};
		
		
		private function handleSequenceComplete(evt:Event):void
		{
			switch(evt.target.id)
			{
				case MODE_LOGO_PARADE :
					trace("AppManager::handleSequenceComplete() -> LOGO PARADE COMPLETE");
					
					// CLEAN UP AFTER LOGO PARADE!
					_oLogoParade.removeEventListener( Event.COMPLETE, handleSequenceComplete );
					_oLogoParade.cleanup();
					//_oLogoParade = null;
					
					// INITIALIZE FRONT END!
					_oFrontEndManager.id = MODE_FRONT_END;
					_oFrontEndManager.addEventListener( Event.COMPLETE, handleSequenceComplete );
					_oFrontEndManager.initialize(_oStage);
				break;
				case MODE_FRONT_END :
					trace("AppManager::handleSequenceComplete() -> FRONT END COMPLETE");
					
					// CLEAN UP AFTER FRONT END!
					_oFrontEndManager.removeEventListener( Event.COMPLETE, handleSequenceComplete );
					_oFrontEndManager.cleanup();
					//_oFrontEndManager = null;
					
					// Wed Oct 14 20:38:16 CDT 2009 CMD TODO: the desired level should be chosen by the player at this point.
					// figure that out.
					
					
					// INITIALIZE GAME!
					_oGameManager.id = MODE_GAME;
					_oGameManager.addEventListener( Event.COMPLETE, handleSequenceComplete );
					_oGameManager.initialize(_oStage);
				break;
				case MODE_GAME :
					trace("AppManager::handleSequenceComplete() -> GAME COMPLETE");
					
					// CLEAN UP AFTER GAME!
					_oGameManager.removeEventListener( Event.COMPLETE, handleSequenceComplete );
					_oGameManager.cleanup();
					//_oGameManager = null;

					// FIGURE OUT WHERE TO GO FROM HERE.
					// WE'RE PROBABLY GOING BACK TO THE FRONT END.
					// THE FRONT END WILL NEED A WAY OF INITIALIZING AT CERTAIN SCREENS. 
					// FOR EXAMPLE, WE WON'T ALWAYS RETURN TO THE MAIN MENU.  SOMETIMES WE'LL RETURN TO THE FRONT END BUT GO TO THE GAME OVER SCREEN!
					
					// maybe before we remove the InGameManager, have it mark down its exit state so we know what to next.
					// perhaps we need to display the game over screen or the victory screen.  maybe we just return to the main menu.
				break;
			}
		};
		
		//============================================
		//	MAIN APP LOOP
		//============================================

		private function vHandle_this_ENTER_FRAME(evt:Event):void
		{
			trace("AppManager::vHandle_this_ENTER_FRAME()");
			switch(_nCurrentMode)
			{
				case MODE_PRELOADER :
					// handle preloader
				break;
				case MODE_INIT_SYSTEM :
					// handle initSystem
					
				break;
				case MODE_LOGO_PARADE :
					// handle logo parade
				break;
				case MODE_FRONT_END :
					// handle front end
				break;
				case MODE_GAME :
					// handle game
				break;
			}			
		};
		
		
		//============================================
		//	GETTERS
		//============================================
		
		public function get nCurrentMode():int{
			return _nCurrentMode;
		};
		
		
	}
}

internal class SingletonEnforcer{};