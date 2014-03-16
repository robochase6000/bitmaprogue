///////////////////////////////////////////////////
//	Region
//	CREATED: 2009-08-13.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.editor.regionEditor
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	import com.chasedelanguillette.roguish.maps.sections.Room;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	
	public class Region extends Sprite
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
		private var _region:Room;
		private var _type:int;
		private var _color:uint;
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function Region(type:int, color:uint, rectx:Number, recty:Number, rectw:Number, recth:Number):void
		{
			_region = new Room(rectx, recty, rectw, recth);
			this.graphics.lineStyle(1, color, 1.0);
			this.graphics.beginFill(color, 0.5);
			this.graphics.drawRect(_region.x, _region.y, _region.width, _region.height);
			this.graphics.endFill();
			
			_type = type;
			_color = color;
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
		
		public function get region():Room{
			return _region;
		};
		
		public function get type():int{
			return _type;
		};
		
		public function get color():uint{
			return _color;
		};
		
		
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