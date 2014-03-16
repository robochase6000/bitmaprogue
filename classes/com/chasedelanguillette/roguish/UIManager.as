///////////////////////////////////////////////////
//	UIManager
//	CREATED: 2009-09-21.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish
{
	
	
	public class UIManager
	{

		//============================================================================
		//	SINGLETON STUFF - GRAB AN INSTANCE WITH UIManager.getInstance()
		//============================================================================

		private static var instance:UIManager;
		
		public function UIManager(o:SingletonEnforcer):void
		{
			
		};
		
		public static function getInstance():UIManager
		{
			if (instance==null)
			{
				instance = new UIManager(new SingletonEnforcer());
			}
			return instance;
		}
		
		
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