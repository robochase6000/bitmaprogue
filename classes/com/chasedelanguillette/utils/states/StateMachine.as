/**
*	
*/
package com.chasedelanguillette.utils.states
{	
	import com.chasedelanguillette.utils.states.IState;

	/**
	*	
	*/
	public class StateMachine 
	{
		private var _currentState:IState;
		public function get currentState():IState { return _currentState; }

		/**
		*	@constructor
		*/
		public function StateMachine():void
		{
			
		}
		
		public function update(dt:int):void
		{
			if (_currentState)
			{
				_currentState.update(dt);
			}
		}
		public function changeState(newState:IState):void
		{
			if (_currentState) _currentState.exit();
			_currentState = newState;
			_currentState.enter();
		}
		
	}
}