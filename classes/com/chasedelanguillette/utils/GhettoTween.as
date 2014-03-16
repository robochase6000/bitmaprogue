/**
*	
*/
package com.chasedelanguillette.utils
{	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.robertpenner.easing.*;

	/**
	*	ghetto tween class that's Royalty Free.  provides basic functionality for tweening properties
	*/
	public class GhettoTween 
	{
		private static var _timer:Timer;
		private static var _activeTweens:Array = new Array();

		public static function to(target:Object, duration:Number, params:Object):GhettoTween
		{
			var tween:GhettoTween = new GhettoTween(target, duration, params);
			_activeTweens.push(tween);
			return tween;
		}

		public static function update(dt:Number):void
		{
			var tweenCount:int = _activeTweens.length;
			for (var tweenIndex:int = 0; tweenIndex < tweenCount; tweenIndex++)
			{
				var tween:GhettoTween = _activeTweens[tweenIndex];
				tween.update(dt);
				if (tween.complete)
				{
					_activeTweens.splice(tweenIndex, 1);
					tweenIndex--;// to offset the splice.
					tweenCount--;// to offset the splice.
					tween.doCallback();
				}
			}
		}


		//========================================================
		// 
		//========================================================
		private var _target:Object;
		public function get target():Object { return _target; }

		/**
		* hash of properties to tween.
		* e.g.
		* _tweenProperties[alpha] = 1.0;
		*/
		private var _tweenProperties:Object = {};
		/**
		* start values of the tween
		* _startValues[alpha] = 0.0;
		*/
		private var _startValues:Object = {};
		/**
		* thd diff value of the tween...how much it will change
		* _diffValues[alpha] = 1.0;
		*/
		private var _diffValues:Object = {};

		public var time:Number = 0.0;
		private var _duration:Number;
		public function get duration():Number { return _duration; }
		/**
		* sets a delay before the tween is ran.
		*/
		private var _delayDuration:Number = 0.0;
		/**
		* easing function to use.
		*/
		private var _easingFunction:Function = Linear.easeNone;
		/**
		* callback function to fire when the tween is done.  note that it's only called if you let the static GhettoTween methods manage your tween
		*/
		private var _onCompleteCallback:Function;
		/**
		* used with _onCompleteCallback in case you want to pass data around.
		*/
		private var _onCompleteParams:Object;

		/**
		* @constructor
		*/
		public function GhettoTween(target:Object, duration:Number, params:Object):void
		{
			if (duration <= 0.0) throw new Error("GhettoTween must have a duration > 0!");
			_target = target;
			time = 0.0;
			_duration = duration;

			// copy tweenable properties
			// also catches any special tween properties like onComplete, easing, delay, etc
			if (params)
			{
				for(var property:String in params)
				{
					switch(property)
					{
						case "onComplete":
							_onCompleteCallback = params[property];
						break;
						case "onCompleteParams":
							_onCompleteParams = params[property];
						break;
						case "easing":
							_easingFunction = params[property];
						break;
						case "delay":
							_delayDuration = params[property];
						break;
						default:
							_tweenProperties[property] = params[property];
							// mark down start & diff values.
							_startValues[property] = target[property];
							_diffValues[property] =  _tweenProperties[property] - _startValues[property];
						break;
					}
				}
			}
		}	
		
		public function update(dt:Number):void
		{
			if (_delayDuration > 0.0)
			{
				_delayDuration -= dt;
			}
			else
			{
				time = Math.min(time + dt, _duration);
				for(var property:String in _tweenProperties)
				{
					target[property] = _easingFunction(time, _startValues[property], _diffValues[property], _duration);
				}
			}
		}	

		public function get complete():Boolean
		{
			return (time >= duration);
		}

		public function doCallback():void
		{
			if (_onCompleteCallback != null)
			{
				_onCompleteCallback(_onCompleteParams);
			}
		}
	}
}
