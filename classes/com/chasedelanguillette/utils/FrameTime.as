/**
*	
*/
package com.chasedelanguillette.utils
{	
	import flash.utils.getTimer;

	/**
	*	simple class for managing dt.  i'm sick of doing it every time for new projects
	*/
	public class FrameTime 
	{
		public static function get timeDiffInSeconds():Number{ return _timeDiffInSeconds; }
		public static function get dt():int{ return _dt; }
		private static var _dt:int = 0;
		private static var _timeDiffInSeconds:Number = 0;
		private static var _timeLastFrame:int = 0;
		
		public static function update():void
		{
			var time:int = getTimer();
			_dt = time - _timeLastFrame;
			_timeDiffInSeconds = _dt * 0.001;
			_timeLastFrame = time;
		}
	}
}