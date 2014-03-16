///////////////////////////////////////////////////
//	BitmapRenderer
//	CREATED: 2009-08-21.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.rendering
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	import com.chasedelanguillette.roguish.characters.Mobile;// change path
	import com.chasedelanguillette.roguish.rendering.animation.Animation;
	import com.chasedelanguillette.roguish.rendering.animation.characters.CharacterAnimation;
	import com.chasedelanguillette.LerpMachine;
	import com.chasedelanguillette.geom.SimplePoint;
	
	import com.chasedelanguillette.roguish.objects.physicalObjects.PhysicalObject;
	import com.chasedelanguillette.roguish.objects.properties.RenderData;
	import com.chasedelanguillette.roguish.objects.properties.Action;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	
	public class BitmapRendererLite
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		// sprite offsets.
		// the renderer will place the sprites where they need to be, 
		// but these offsets present a quick and easy way to shift them in any direction if needed
		// for example, in 3/4 top down, you may want to slide your sprite up a little bit so he appears to be in front of the tile above him
		public var nSpriteOffsetX:int = 0;
		public var nSpriteOffsetY:int = -15;
		
		public var nItemOffsetX:int = 0;
		public var nItemOffsetY:int = 0
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		private var _nTileWidth:int;
		private var _nTileHeight:int;
		
		private var _nTileSheetWidth:int;
		private var _nTileSheetHeight:int;
		private var _bmdTileSheet:BitmapData;
		private var _rectTileRectangle:Rectangle;
		private var _nTileSheet_TilesPerRow:int;
		
		private var _nMapWidth:int;
		private var _nMapHeight:int;
		private var _nMapWidthInPixels:int;
		private var _nMapHeightInPixels:int;
		private var _aoMapData:Array;
		
		private var _nCanvasTileWidth:int;
		private var _nCanvasTileHeight:int;
		private var _nCanvasWidth:int;
		private var _nCanvasHeight:int;
		private var _bmdCanvas:BitmapData;
		private var _rectCanvasRectangle:Rectangle;
		private var _ptCanvasPoint:Point;
		
		private var _nBufferTileWidth:int;
		private var _nBufferTileHeight:int;
		private var _nBufferWidth:int;
		private var _nBufferHeight:int;
		private var _bmdBuffer:BitmapData;
		private var _ptBufferPoint:Point;
		
		// BUFFER REGION
		private var _nBufferLeftEdge:int;
		private var _nBufferTopEdge:int;
		private var _nBufferRightEdge:int;
		private var _nBufferBottomEdge:int;
		
		// VIEW OFFSET
		private var _nViewOffsetX:int;
		private var _nViewOffsetY:int;
		
		private var _nStartTileX:int = -1;
		private var _nStartTileY:int = -1;
		private var _nBufferOffsetX:int = -1;
		private var _nBufferOffsetY:int = -1;
		
		// LERP MACHINES!
		public var oLerpX:LerpMachine;
		public var oLerpY:LerpMachine;
		
		private var _oSpriteCopyPoint:Point = new Point(0,0)
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		/**
		*	@constructor
		*/
		public function BitmapRendererLite(map:Array, tileset:BitmapData, screenWidth:int, screenHeight:int, tileWidth:int, tileHeight:int, bmdCanvas:BitmapData = null):void
		{
			_nTileWidth = tileWidth;
			_nTileHeight = tileHeight;
			
			_nTileSheetWidth = tileset.width;
			_nTileSheetHeight = tileset.height;
			_nTileSheet_TilesPerRow = _nTileSheetWidth / _nTileWidth;
		
			_bmdTileSheet = tileset;
			_rectTileRectangle = new Rectangle(0,0,_nTileWidth,_nTileHeight);
			
			_aoMapData = map;
			_nMapWidth = _aoMapData[0].length;
			_nMapHeight = _aoMapData.length;
			_nMapWidthInPixels = _nMapWidth * _nTileWidth;
			_nMapHeightInPixels = _nMapHeight * _nTileHeight;
			
			_nCanvasWidth = screenWidth;
			_nCanvasHeight = screenHeight;
			_nCanvasTileWidth = Math.ceil(_nCanvasWidth / _nTileWidth);
			_nCanvasTileHeight = Math.ceil(_nCanvasHeight / _nTileHeight);
			
			
			if ( bmdCanvas == null )
			{
				_bmdCanvas = new BitmapData(_nCanvasWidth, _nCanvasHeight, false);
			}
			else
			{
				_bmdCanvas = bmdCanvas;
			}
			
			_rectCanvasRectangle = new Rectangle(0,0,_nCanvasWidth,_nCanvasHeight);
			_ptCanvasPoint = new Point(0,0);
			
			_nBufferTileWidth = _nCanvasTileWidth + 1;
			_nBufferTileHeight = _nCanvasTileHeight + 1;
			
			_nBufferWidth = _nBufferTileWidth * _nTileWidth;
			_nBufferHeight = _nBufferTileHeight * _nTileHeight;
			
			_bmdBuffer = new BitmapData(_nBufferWidth,_nBufferHeight, false);
			_ptBufferPoint = new Point(0,0);
			
			_nBufferLeftEdge = _nStartTileX;
			_nBufferRightEdge = _nBufferTileWidth;
			_nBufferTopEdge = _nStartTileY;
			_nBufferBottomEdge = _nBufferTileHeight;
			
			_nViewOffsetX = _nViewOffsetY = 0;
		};
		
		
		/**
		*	Sets the tilesheet to be used for world rendering.
		*/
		public function set bmdTileSheet(value:BitmapData):void {
			_bmdTileSheet = value;
		}
		
		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		/**
		*	
		*/
		public function cleanUp():void
		{
			_bmdCanvas.dispose();
			_bmdBuffer.dispose();
			
			_rectTileRectangle = null;
			_aoMapData = null;
			
			_rectCanvasRectangle = null;
			_ptCanvasPoint = null;
	
			_ptBufferPoint = null;			
		};
		
				
		/**
		*	updates the view.	
		*/
		public function viewUpdate(newX:int, newY:int):void
		{
			//
			_nViewOffsetX = newX;
			_nViewOffsetY = newY;
			
			//
			_nStartTileX = Math.floor(_nViewOffsetX / _nTileWidth);
			_nStartTileY = Math.floor(_nViewOffsetY / _nTileHeight);
			
			//
			_nBufferLeftEdge 		= _nStartTileX;
			_nBufferRightEdge 		= _nStartTileX + _nBufferTileWidth;
			_nBufferTopEdge 		= _nStartTileY;
			_nBufferBottomEdge 		= _nStartTileY + _nBufferTileHeight;
		}
		
		
		/**
		*	
		*/
		public function drawTiles(aoMapData:Array = null, bmdTileSet:BitmapData = null):void
		{
			if (!aoMapData) return;
			
			// draw the tiles!!! move this!!
			for (var i:int = 0; i < _nBufferTileHeight; i++)
			{
				for (var j:int = 0; j < _nBufferTileWidth; j++)
				{
					if ( i < _nCanvasTileWidth && j < _nCanvasTileHeight )
					{
						var tx:int = _nStartTileX + j;
						var ty:int = _nStartTileY + i;
										
						// find which tile to retrieve!
						var t:int = aoMapData[ty][tx];
						var row:int = Math.floor((t * _nTileWidth) / _nTileSheetWidth);
						var col:int = (t) - ((row * _nTileWidth) * _nTileSheetWidth);
						 
						_rectTileRectangle.x = int((t % _nTileSheet_TilesPerRow)) * _nTileWidth;
						_rectTileRectangle.y = int((t / _nTileSheet_TilesPerRow)) * _nTileHeight;
						_ptBufferPoint.x = j * _nTileWidth;
						_ptBufferPoint.y = i * _nTileHeight;
						_bmdBuffer.copyPixels(bmdTileSet, _rectTileRectangle, _ptBufferPoint);
					}
				}
			};
			
			// now figure out which region of the buffer to copy to the canvas
			_nBufferOffsetX = _nStartTileX * _nTileWidth;
			_nBufferOffsetY = _nStartTileY * _nTileHeight;
			_rectCanvasRectangle.x = _nViewOffsetX - _nBufferOffsetX;
			_rectCanvasRectangle.y = _nViewOffsetY - _nBufferOffsetY;
			_bmdCanvas.copyPixels(_bmdBuffer, _rectCanvasRectangle, _ptCanvasPoint);
		};
		
		
		/**
		*	This point contains the x, y position of the sprite sheet we need to copy from.  Made into a member var to cut down on instantiation time.
		*/
		private var _oSpriteSheetPoint:SimplePoint = new SimplePoint(0,0);
		
		/**
		*	
		*/
		private var _bmdCopyToBuffer:BitmapData = new BitmapData(32, 32);
		
		/**
		*	
		*/
		private var _oTargetObject:PhysicalObject;
		
		/**
		*	
		*/
		private var _oTargetRenderData:RenderData;
		
		
		/**
		*	Renders a group of physical objects	to a bmdCanvas.
		*	
		*	<p>This should allow a little flexibility - you define which group of PhysicalObject instances you want rendered to which canvas.
		*	Now, controlling layers should be very simple.</p>
		*/
		public function renderGroup(bmdCanvas:BitmapData, group:Array):void
		{
			//trace("BitmapRendererLite::renderGroup()");
			
			if (!group) return;
			
			for (var nGroupMemberIndex:int = 0; nGroupMemberIndex < group.length; nGroupMemberIndex++)
			{
				_oTargetObject = group[nGroupMemberIndex] as PhysicalObject;
				
				var tx:int = _oTargetObject.oDimensions.x;
				var ty:int = _oTargetObject.oDimensions.y;
				
				// check if the object will be on screen!
				if ( tx >= _nBufferLeftEdge && tx <= _nBufferRightEdge && ty >= _nBufferTopEdge && ty <= _nBufferBottomEdge )
				{
					// get the render data for the physical object
					_oTargetRenderData = _oTargetObject.oRenderData;
					
					// see if the thing animates; if it does, we'll want to update its animation here.
					if ( _oTargetRenderData.animates ) {
						RenderData.updateAnimation(_oTargetRenderData);
						_oSpriteSheetPoint = RenderData.getSpriteSheetCopyPoint(_oTargetRenderData);
						
						// update copy rectangle here since it should be the same for every layer in the thing.
						_rectTileRectangle.x = _oSpriteSheetPoint.x * _nTileWidth;
					 	_rectTileRectangle.y = _oTargetObject.oDimensions.direction * _nTileHeight;
					}
					else
					{
						// set the copy rectangle to (0,0) for this thing since there is only one frame to display.
						_rectTileRectangle.x = _rectTileRectangle.y = 0;
					}
					
					// figure out where to paste this thing here since it ought to be the same for every layer.
					_oSpriteCopyPoint = oGetDrawPoint(_oTargetObject.oDimensions.x, _oTargetObject.oDimensions.y);
					_oSpriteCopyPoint.x += nSpriteOffsetX;// Sun Dec  6 12:58:24 CST 2009 CMD TODO: nSpriteOffsetX is a global offset.  Ideally, you'd make an additional offset for every game object.
					_oSpriteCopyPoint.y += nSpriteOffsetY;
					
					// if the object currently being rendered is being lerped, we have to add the lerp value to position the object correctly.
					// only lerp if we need it to lerp.  we use the lerp machines for other things to, like attacks and stuff.
					switch (_oTargetObject.nCurrentAction)
					{
						case Action.MOVE :
							if ( oLerpX.target == _oTargetObject ) _oSpriteCopyPoint.x += oLerpX.currentValue;
							if ( oLerpY.target == _oTargetObject ) _oSpriteCopyPoint.y += oLerpY.currentValue;
						break;
					}
					
					// ok, we're going to run a while loop while we do this crap.
					var bRendering:Boolean = true;
					var nSpriteSheetIndex:int = 0;
					
					// mark down how many render layers we have to draw.
					var nRenderLayers:int = 0;
					if ( _oTargetRenderData.spriteSheets ) nRenderLayers = _oTargetRenderData.spriteSheets.length;
					
					while (bRendering)
					{
						// check if the thing animates.
						if ( _oTargetRenderData.animates )
						{
							_bmdCopyToBuffer = _oTargetRenderData.spriteSheets[nSpriteSheetIndex];
							nSpriteSheetIndex++
							
							// if we've drawn all the layers we need to, then stop rendering.
							if ( nSpriteSheetIndex > nRenderLayers ) bRendering = false;
						}
						// if the thign doesn't animate, we're done rendering.
						else
						{
							// we're done rendering since this sprite only has one frame.
							bRendering = false;
							_bmdCopyToBuffer = _oTargetRenderData.icon;
							
						}
						
						// now copy that data
						if (_bmdCopyToBuffer)
							bmdCanvas.copyPixels(_bmdCopyToBuffer, _rectTileRectangle, _oSpriteCopyPoint );
					}					
				}
				else
				{
					// clear out the animation object since we don't need to render this guy!
					if ( _oTargetObject.oRenderData.animation != null ) _oTargetObject.oRenderData.animation = null;
				}
			}
		};
		
		
		/**
		*	gets the correct coordinates to draw the tile to the screen.	
		*/		
		public function oGetDrawPoint(tx:Number, ty:Number):Point
		{
			_oSpriteCopyPoint.x = tx - _nStartTileX
			_oSpriteCopyPoint.y = ty - _nStartTileY
			_oSpriteCopyPoint.x *= _nTileWidth;
			_oSpriteCopyPoint.y *= _nTileHeight;
			_oSpriteCopyPoint.x -= _rectCanvasRectangle.x;
			_oSpriteCopyPoint.y -= _rectCanvasRectangle.y;
			return _oSpriteCopyPoint;
		}
		
		
		/**
		*	figures out if the coordinates will be viewable in the buffer.
		*/
		public function bTileViewableInBuffer(tx:int, ty:int):Boolean
		{
			if ( tx >= _nBufferLeftEdge && tx <= _nBufferRightEdge && ty >= _nBufferTopEdge && ty <= _nBufferBottomEdge ) return true
			return false
		}
		
		
		//////////////////////////////////////////////
		//
		//	GETTERS
		//
		//////////////////////////////////////////////
		
		/**
		*	
		*/
		public function get bmdCanvas():BitmapData
		{
			return _bmdCanvas;
		};
		
		
		/**
		*	
		*/
		public function get nMapWidthInPixels():int{
			return _nMapWidthInPixels;
		};
		
		
		/**
		*	
		*/
		public function get nMapHeightInPixels():int{
			return _nMapHeightInPixels;
		};
		
		
		/**
		*	
		*/
		public function get nCanvasWidth():int{
			return _nCanvasWidth;
		};
		
		
		/**
		*	
		*/
		public function get nCanvasHeight():int{
			return _nCanvasHeight;
		};
		
		
		/**
		*	
		*/
		public function get nStartTileX():int{
			return _nStartTileX;
		};
		
		
		/**
		*	
		*/
		public function get nStartTileY():int{
			return _nStartTileY;
		};
	}
}