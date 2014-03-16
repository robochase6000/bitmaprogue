///////////////////////////////////////////////////
//	ModeManager
//	CREATED: 2009-08-13.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.editor.regionEditor
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class ModeManager
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
		
		private var _nCurrentMode:int = 0;
		private var _nMaxModes:int = 5;
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function ModeManager(nCurrentMode:int = 0, nMaxModes:int = 0):void
		{
			_nCurrentMode = nCurrentMode;
			_nMaxModes = nMaxModes;
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function vNext():int
		{
			_nCurrentMode++;
			if ( _nCurrentMode == _nMaxModes) _nCurrentMode = 0;
			return _nCurrentMode;
		};
		
		public function vPrevious():int
		{
			_nCurrentMode--;
			if ( _nCurrentMode < 0 ) _nCurrentMode = _nMaxModes - 1;
			return _nCurrentMode;
		};
		
		public function vSetMode(nMode:int):void
		{
			trace("ModeManager::vSetMode(nMode: " + nMode + ")");
			_nCurrentMode = nMode;
		};
		
		//////////////////////////////////////////////
		//
		//	GETTERS
		//
		//////////////////////////////////////////////
		
		public function get nCurrentMode():int{
			return _nCurrentMode;
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