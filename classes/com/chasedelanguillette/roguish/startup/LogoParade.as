///////////////////////////////////////////////////
//	LogoParade
//	CREATED: 2009-09-21.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
// 	IDEALLY, THE APP MANAGER WOULD HAVE INITSYSTEM LOAD UP A TEXT FILE THAT DICTATES THE SEQUENCE OF LOGOS TO PLAY.
//	THIS WOULD GET THAT LIST AND PLAY THEM.  XML WOULD BE AN OBVIOUS CHOICE
//
//	<logos>
//		<logo swf="whatever.swf" name="Mochizorz" />
//		<logo swf="whatever2.swf" name="Kongrezorz" />
//	</logos>
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
	//	STANDARD IMPORTS
	//============================================
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	public class LogoParade extends EventDispatcher
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		public static const LOGO_0:int = 0;
		public static const LOGO_1:int = 1;
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public var id:int = -1;
		private var _oInitSystem:InitSystem = InitSystem.getInstance();
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		private var _bInitialized:Boolean = false;
		private var _oStage:Stage;
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function LogoParade():void
		{
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function cleanup():void
		{
			trace("LogoParade::cleanup()");
			_oStage = null;
			// & whatever else
		};
		
		public function initialize(stageReference:Stage):void
		{
			if ( !_bInitialized )
			{
				_oStage = stageReference;
				
				// conditionally skip the logo parade!
				if (_oInitSystem.bSkipLogoParade)
				{
					trace("LogoParade::initialize() -> SKIPPING LOGO PARADE");
					dispatchEvent(new Event(Event.COMPLETE));
				}
				else
				{
					trace("LogoParade::initialize() -> INITIALIZING LOGO PARADE");
					// intiialize the logo parade!
					
					// load sponsor.swf
					// sponsor.id = SPONSOR_0;
					// sponsor.addEventListener(Event.COMPLETE, handleLogoComplete)
					// sponsor.initialize();
				}
			}
		};
		
		private function handleLogoComplete(evt:Event):void
		{
			trace("LogoParade::handleLogoComplete()");
			switch(evt.target.id)
			{
				case LOGO_0:
					// logo0.cleanup
					// logo0 = null
					// logo1.id = LOGO_1;
					// logo1.addEventListener( Event.COMPLETE, handleLogoComplete );
					// logo1.initialize();
				break;
				case LOGO_1:
					handleLogoParadeComplete();
				break;
			}
		};
		
		private function handleLogoParadeComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
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