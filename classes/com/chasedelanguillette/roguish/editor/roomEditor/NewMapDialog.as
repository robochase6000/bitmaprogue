///////////////////////////////////////////////////
//	NewMapDialog
//	CREATED: 2009-05-29.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.editor.roomEditor
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	public class NewMapDialog extends MovieClip
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		public var mw:int;
		public var mh:int;
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		private var _bValidNewMap:Boolean = false;
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function NewMapDialog():void
		{
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function vSetEnabled(bEnabled:Boolean):void
		{
			this.visible = bEnabled;
			if (bEnabled)
			{
				this.oConfirmButton.addEventListener( MouseEvent.CLICK, vHandle_oConfirmButton_CLICK );
				this.oCancelButton.addEventListener( MouseEvent.CLICK, vHandle_oCancelButton_CLICK );
			}
			else
			{
				this.oConfirmButton.removeEventListener( MouseEvent.CLICK, vHandle_oConfirmButton_CLICK );
				this.oCancelButton.removeEventListener( MouseEvent.CLICK, vHandle_oCancelButton_CLICK );
			}
		}
		
		//////////////////////////////////////////////
		//
		//	GETTERS
		//
		//////////////////////////////////////////////
		
		public function get bValidNewMap():Boolean{
			return _bValidNewMap;
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
		
		private function vHandle_oCancelButton_CLICK(evt:MouseEvent):void
		{
			//trace("NewMapDialog::vHandle_oCancelButton_CLICK()");
			
			_bValidNewMap = false;
			vSetEnabled(false);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function vHandle_oConfirmButton_CLICK(evt:MouseEvent):void
		{			
			mw = int(dt_width.text);
			mh = int(dt_height.text);
			
			//trace("NewMapDialog::vHandle_oConfirmButton_CLICK() -> mw: " + mw + " mh: " + mh);
			
			_bValidNewMap = true;
			vSetEnabled(false);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		//////////////////////////////////////////////
		//
		//	PRIVATE METHODS
		//
		//////////////////////////////////////////////
		
		
	}
}