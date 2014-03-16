///////////////////////////////////////////////////
//	Camera
//	CREATED: 2009-10-01.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//	
//	
//	
//	
//	
//
//////////////////////////////////////////////////

/*

In the diagram shown below, the region outlined by - and | would be the world region.
the region outlined by * is the view region.
the focal point is F.
Assuming we know the position of F, 
the camera class really just figures out the x and y position of the region outlined by *
The x and y info helps us figure out what we actually need to draw every frame.
For example, all the n's in the diagram might represent other sprites, but since they dont' fall in the view region,
we shouldn't have to draw them!

-----------------------------------------
|			n							|
|       *********                n      |
|       *       *   n                   |
|  n    *   F   * 						|
|		*		*         n             |
|       *********                       |
|     n                     n           |
-----------------------------------------

*/



package com.chasedelanguillette.utils
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	/**
	*	Helps figures out draw region in a grid-based world if the camera is meant to be centered on some thing.
	*	
	*	<p>you give it world dimensions and dimensions for your draw region, then tell it to focus on a point in that world.
	*	you can then use the view offsets to figure out what parts of the scene you actually need to draw.</p>
	*	
	*	<p>The camera class is smart enough to keep the view window within the world's boundaries, which is useful if the camera</p>
	*	
	*/
	public class Camera
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
		private var _nWorldWidth:int;
		private var _nWorldHeight:int;
		
		private var _nWorldBoundaryRight:int;
		private var _nWorldBoundaryBottom:int;
		
		private var _nViewWidth:int;
		private var _nViewHeight:int;
		
		private var _nHalfViewWidth:int;
		private var _nHalfViewHeight:int;
		
		private var _nViewOffsetX:int;
		private var _nViewOffsetY:int;
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		/**
		*	@constructor
		*/
		public function Camera(nWorldWidth:int, nWorldHeight:int, nViewWidth:int, nViewHeight:int, nFocusX:int = 0, nFocusY:int = 0):void
		{
			setWorldSize(nWorldWidth, nWorldHeight);
			setViewSize(nViewWidth, nViewHeight);
			focusOn(nFocusX, nFocusY);
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		/**
		*	Sets the world's dimensions.
		*	
		*	<p>If the world dimensions are set to be smaller than the current view port's size, the 
		*	viewport size is automatically sized down to the size of the world.<p>
		*	
		*	<p>An improvement might be to include a flag that sets whether you want the viewport to resize proportionately or not.</p>
		*/
		public function setWorldSize(w:int, h:int):void
		{
			_nWorldWidth = nWorldWidth;
			_nWorldHeight = nWorldHeight;
			
			validateViewDimensions();
		};
		
		
		/**
		*	Sets the viewport's dimensions.
		*	
		*	<p>If the world dimensions are set to be smaller than the current view port's size, the 
		*	viewport size is automatically sized down to the size of the world.<p>
		*	
		*	<p>An improvement might be to include a flag that sets whether you want the viewport to resize proportionately or not.</p>
		*/
		public function setViewSize(w:int, h:int):void
		{
			_nViewWidth = nViewWidth;
			_nViewHeight = nViewHeight;
			
			validateViewDimensions();
		};
		
		
		/**
		*	Sets the Camera's focal point to x, y
		*	
		*	<p>If you know you only need to be setting x or y, focusX and focusY should be more effecient.</p>
		*/
		public function focusOn(x:int, y:int):void
		{
			focusX(x);
			focusY(y);
		};
		
		
		/**
		*	Sets the Camera's x focal point.
		*/
		public function focusX(x:int):void
		{
			_nViewOffsetX = x - _nHalfViewWidth;
			if ( _nViewOffsetX < 0 ) _nViewOffsetX = 0;
			if ( _nViewOffsetX > _nWorldBoundaryRight ) _nViewOffsetX = _nWorldBoundaryRight;
		};
		
		
		/**
		*	Sets the Camera's y focal point.
		*/
		public function focusY(y:int):void
		{
			_nViewOffsetY = y - _nViewHeight;
			if ( _nViewOffsetY < 0 ) _nViewOffsetY = 0;
			if ( _nViewOffsetY > _nWorldBoundaryBottom ) _nViewOffsetY = _nWorldBoundaryBottom;
		};
		
		
		//////////////////////////////////////////////
		//
		//	GETTERS
		//
		//////////////////////////////////////////////
	
		/**
		*	Gets the view region's x position.
		*/
		public function get nViewOffsetX():int{
			return _nViewOffsetx;
		};
		
		
		/**
		*	Gets the view region's y position.
		*/
		public function get nViewOffsetY():int{
			return _nViewOffsetY;
		};
		
		
		/**
		*	Gets the view region's position as an object {x:int, y:int}
		*/
		public function get oViewOffset():Object{
			return {x:_nViewOffsetx, y:_nViewOffsetY};
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
		
		/**
		*	Ensures the view region can be contained within the world's boundaries.
		*/
		private function validateViewDimensions():void
		{
			_nViewWidth = Math.min(_nViewWidth, _nWorldWidth);
			_nViewHeight = Math.min(_nViewHeight, _nWorldHeight);
			
			_nHalfViewWidth = _nViewWidth / 2;
			_nHalfViewHeight = _nViewHeight / 2;
			
			_nWorldBoundaryRight = _nWorldWidth - _nViewWidth;
			_nWorldBoundaryBottom = _nWorldHeight - _nViewHeight;
		};
	}
}