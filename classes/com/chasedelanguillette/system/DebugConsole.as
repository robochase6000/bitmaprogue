///////////////////////////////////////////////////
//	DebugConsole
//	CREATED: 2009-09-01.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.system
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.system.FPSCounter;
	import com.chasedelanguillette.system.MemoryWatch;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.display.Sprite
	
	public class DebugConsole extends Sprite
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		private var _fps:FPSCounter;
		private var _mem:MemoryWatch;
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function DebugConsole(fps:Boolean = true, mem:Boolean = true):void
		{
			if ( fps )
			{
				_fps = new FPSCounter(0,0,0xffffff,true,0x000000);
				addChild(_fps);
			}
			
			if ( mem )
			{
				_mem = new MemoryWatch(1000000, 3, 0, 13, 0xffffff, true, 0x000000)
				addChild(_mem);
			}
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		
		
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