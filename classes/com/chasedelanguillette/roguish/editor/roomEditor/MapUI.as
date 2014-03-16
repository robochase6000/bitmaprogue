///////////////////////////////////////////////////
//	MapUI
//	CREATED: 2009-06-01.
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
	import com.chasedelanguillette.roguish.editor.roomEditor.UIEvent;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.display.*;
	import flash.events.*;
	
	public class MapUI extends MovieClip
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
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function MapUI():void
		{
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function vSetEnabled(bEnabled:Boolean):void
		{
			if ( bEnabled )
			{
				oLeftButton.addEventListener( MouseEvent.CLICK, vHandle_oLeftButton_CLICK );
				oRightButton.addEventListener( MouseEvent.CLICK, vHandle_oRightButton_CLICK );
				oFlipHorizontal.addEventListener( MouseEvent.CLICK, vHandle_oFlipHorizontal_CLICK );
				oFlipVertical.addEventListener( MouseEvent.CLICK, vHandle_oFlipVertical_CLICK );
				oAddRow.addEventListener( MouseEvent.CLICK, vHandle_oAddRow_CLICK );
				oAddColumn.addEventListener( MouseEvent.CLICK, vHandle_oAddColumn_CLICK );
				oDeleteRow.addEventListener( MouseEvent.CLICK, vHandle_oDeleteRow_CLICK );
				oDeleteColumn.addEventListener( MouseEvent.CLICK, vHandle_oDeleteColumn_CLICK );
			}
			else
			{
				oLeftButton.removeEventListener( MouseEvent.CLICK, vHandle_oLeftButton_CLICK );
				oRightButton.removeEventListener( MouseEvent.CLICK, vHandle_oRightButton_CLICK );
				oFlipHorizontal.removeEventListener( MouseEvent.CLICK, vHandle_oFlipHorizontal_CLICK );
				oFlipVertical.removeEventListener( MouseEvent.CLICK, vHandle_oFlipVertical_CLICK );
				oAddRow.removeEventListener( MouseEvent.CLICK, vHandle_oAddRow_CLICK );
				oAddColumn.removeEventListener( MouseEvent.CLICK, vHandle_oAddColumn_CLICK );
				oDeleteRow.removeEventListener( MouseEvent.CLICK, vHandle_oDeleteRow_CLICK );
				oDeleteColumn.removeEventListener( MouseEvent.CLICK, vHandle_oDeleteColumn_CLICK );
			}
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
		
		
		
		//////////////////////////////////////////////
		//
		//	EVENT HANDLERS
		//
		//////////////////////////////////////////////
		
		private function vHandle_oLeftButton_CLICK(evt:MouseEvent):void
		{
			trace("MapUI::vHandle_oLeftButton_CLICK()");
			dispatchEvent(new UIEvent(UIEvent.MAP_ROTATE_LEFT));
		};
		
		private function vHandle_oRightButton_CLICK(evt:MouseEvent):void
		{
			trace("MapUI::vHandle_oRightButton_CLICK()");
			dispatchEvent(new UIEvent(UIEvent.MAP_ROTATE_RIGHT));
			
		};
		
		private function vHandle_oFlipHorizontal_CLICK(evt:MouseEvent):void
		{
			trace("MapUI::vHandle_oFlipHorizontal_CLICK()");
			dispatchEvent(new UIEvent(UIEvent.MAP_FLIP_HORIZONTAL));
			
		}
		
		private function vHandle_oFlipVertical_CLICK(evt:MouseEvent):void
		{
			trace("MapUI::vHandle_oFlipVertical_CLICK()");
			dispatchEvent(new UIEvent(UIEvent.MAP_FLIP_VERTICAL));
			
		}
		
		private function vHandle_oAddRow_CLICK(evt:MouseEvent):void
		{
			trace("MapUI::vHandle_oAddRow_CLICK()");
			dispatchEvent(new UIEvent(UIEvent.MAP_ADD_ROW));
		}
		
		private function vHandle_oAddColumn_CLICK(evt:MouseEvent):void
		{
			trace("MapUI::vHandle_oAddColumn_CLICK()");
			dispatchEvent(new UIEvent(UIEvent.MAP_ADD_COLUMN));			
		}
		
		private function vHandle_oDeleteRow_CLICK(evt:MouseEvent):void
		{
			trace("MapUI::vHandle_oDeleteRow_CLICK()");
			dispatchEvent(new UIEvent(UIEvent.MAP_DELETE_ROW))
		}
		
		private function vHandle_oDeleteColumn_CLICK(evt:MouseEvent):void
		{
			trace("MapUI::vHandle_oDeleteColumn_CLICK()");
			dispatchEvent(new UIEvent(UIEvent.MAP_DELETE_COLUMN))
		}
		
		
		
		//////////////////////////////////////////////
		//
		//	PRIVATE METHODS
		//
		//////////////////////////////////////////////
		
		
	}
}