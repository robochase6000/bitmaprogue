///////////////////////////////////////////////////
//	LerpMachine
//	CREATED: 2009-10-01.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.utils
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.utils.NumberUtils;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class LerpMachine extends EventDispatcher
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		private var _target:Object;
		private var _currentValue:Number;
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		private var _nBeginningValue:Number;
		private var _nChangeInValue:Number;
		private var _nCurrentStep:Number;
		private var _nTotalSteps:Number;
		private var _bComplete:Boolean = false;
		
		public var oParams:* = null;
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function LerpMachine(target:Object = null, nBeginningValue:Number = 0, nChangeInValue:Number = 32, nCurrentStep:Number = 0, nTotalSteps:Number = 10):void
		{
			reset(target, nBeginningValue, nChangeInValue, nCurrentStep, nTotalSteps)
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function reset(target:Object, nBeginningValue:Number, nChangeInValue:Number, nCurrentStep:Number, nTotalSteps:Number):void
		{
			_target = target;
			_nBeginningValue = nBeginningValue;
			_nChangeInValue = nChangeInValue;
			_nCurrentStep = nCurrentStep;
			_nTotalSteps = nTotalSteps;
			_bComplete = false;
			update();
		};
		
		public function step():void
		{
			_nCurrentStep++;
			update();
		};
		
		public function setTarget(target:Object):void
		{
			
		};
		
		public function clear():void
		{
			_target = null;
		}
		
		
		//////////////////////////////////////////////
		//
		//	GETTERS
		//
		//////////////////////////////////////////////
		
		public function get complete():Boolean{
			return _bComplete;
		};
		
		public function get currentValue():Number{
			return _currentValue;
		};
		
		public function get target():Object{
			return _target;
		};
		
		
		
		//////////////////////////////////////////////
		//
		//	SETTERS
		//
		//////////////////////////////////////////////
		
		public function set target(value:Object):void {
			_target = value;
		};
		
		public function set duration(value:int):void {
			_nTotalSteps = value;
		}
		
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
		
		private function update():void
		{
			if (_nCurrentStep > _nTotalSteps) _nCurrentStep = _nTotalSteps;
			lerp();			
			if ( _nCurrentStep == _nTotalSteps ) {
				//trace("done lerping!");
				_bComplete = true;
				//dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function lerp():void
		{
			_currentValue = NumberUtils.lerp(_nBeginningValue, _nChangeInValue, _nCurrentStep, _nTotalSteps );
		};
	}
}