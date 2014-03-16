/**
*	
*/
package com.chasedelanguillette.utils.states
{	
	/**
	*	
	*/
	public interface IState 
	{
		
		function enter():void;
		function update(dt:int):void;
		function exit():void;
		
	}
}