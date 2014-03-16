///////////////////////////////////////////////////
//	HUD
//	CREATED: 2009-09-01.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.ui.inGame
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
	
	
	
	public class HUD extends Sprite
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
		
		private var _tfFloorNumber:TextField;
		
		private var _oEnergyMeter:Meter;
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function HUD():void
		{
			this.addEventListener( Event.ADDED_TO_STAGE, vHandle_this_ADDED_TO_STAGE );
			
		};
		
		private function vHandle_this_ADDED_TO_STAGE(evt:Event):void
		{
			trace("HUD::vHandle_this_ADDED_TO_STAGE()");
			_tfFloorNumber = new TextField();
			_tfFloorNumber.textColor = 0xffffff;
            _tfFloorNumber.selectable = false;
            _tfFloorNumber.background = true;
            _tfFloorNumber.backgroundColor = 0x000000;
            _tfFloorNumber.autoSize = TextFieldAutoSize.LEFT;
			_tfFloorNumber.text = "Floor XXX";
			_tfFloorNumber.y = stage.stageHeight - _tfFloorNumber.height;
			
			if (!CONFIG::MINIMAP_DEMO)
				addChild(_tfFloorNumber);
			
			_oEnergyMeter = new Meter();
			_oEnergyMeter.Fill.gotoAndStop("energy");
			
			if (!CONFIG::MINIMAP_DEMO)
				addChild(_oEnergyMeter);
		}

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function updateEnergyMeter(nPercent:Number):void
		{
			_oEnergyMeter.Fill.scaleX = nPercent;
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
		
		public function set currentFloor(value:int):void {
			//_currentFloor = value;
			_tfFloorNumber.text = "Floor " + value;
		};
		
		
		
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