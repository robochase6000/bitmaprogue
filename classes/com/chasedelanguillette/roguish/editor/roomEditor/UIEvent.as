///////////////////////////////////////////////////
//	UIEvent
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
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.events.Event	
	
	public class UIEvent extends Event
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		public static const MAP_FLIP_HORIZONTAL:String 		= "mapFlipHorizontal";
		public static const MAP_FLIP_VERTICAL:String 		= "mapFlipVertical";
		public static const MAP_ROTATE_RIGHT:String 		= "mapRotateRight";
		public static const MAP_ROTATE_LEFT:String 			= "mapRotateLeft";
		public static const MAP_ADD_ROW:String				= "mapAddRow";
		public static const MAP_ADD_COLUMN:String			= "mapAddColumn";		
		public static const MAP_DELETE_ROW:String			= "mapDeleteRow";
		public static const MAP_DELETE_COLUMN:String		= "mapDeleteColumn";
		
		
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
		
		public function UIEvent(type:String):void
		{
			super(type);
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		
		
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
		
		
		
		//////////////////////////////////////////////
		//
		//	PRIVATE METHODS
		//
		//////////////////////////////////////////////
		
		
	}
}