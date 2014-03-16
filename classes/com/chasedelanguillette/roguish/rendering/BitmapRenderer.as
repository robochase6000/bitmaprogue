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
	
	import com.chasedelanguillette.roguish.objects.physicalObjects.PhysicalObject;
	import com.chasedelanguillette.roguish.objects.properties.RenderData;
	import com.chasedelanguillette.roguish.objects.properties.Action;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	
	public class BitmapRenderer
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
		
		public function BitmapRenderer(map:Array, tileset:BitmapData, screenWidth:int, screenHeight:int, tileWidth:int, tileHeight:int):void
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
			_bmdCanvas = new BitmapData(_nCanvasWidth, _nCanvasHeight, false);
			_rectCanvasRectangle = new Rectangle(0,0,_nCanvasWidth,_nCanvasHeight);
			_ptCanvasPoint = new Point(0,0);
			
			_nBufferTileWidth = _nCanvasTileWidth + 1;
			_nBufferTileHeight = _nCanvasTileHeight + 1;
			_nBufferWidth = _nBufferTileWidth * _nTileWidth;
			_nBufferHeight = _nBufferTileHeight * _nTileHeight;
			_bmdBuffer = new BitmapData(_nBufferWidth,_nBufferHeight, false);
			_ptBufferPoint = new Point(0,0);
			
			_nBufferLeftEdge 		= _nStartTileX;
			_nBufferRightEdge 		= _nBufferTileWidth;
			_nBufferTopEdge 		= _nStartTileY;
			_nBufferBottomEdge 		= _nBufferTileHeight;
			
			_nViewOffsetX = _nViewOffsetY = 0;
						
			// trace( "_nMapWidthInPixels::" + _nMapWidthInPixels );
			// trace( "_nMapHeightInPixels::" + _nMapHeightInPixels );
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
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
		
		public function get nStartTileX():int{
			return _nStartTileX;
		};
		
		public function get nStartTileY():int{
			return _nStartTileY;
		};
		
		// re-renders everything
		public function renderTiles(x:int, y:int):void
		{
			_nViewOffsetX = x;
			_nViewOffsetY = y;
			
			_nStartTileX = Math.floor(_nViewOffsetX / _nTileWidth);
			_nStartTileY = Math.floor(_nViewOffsetY / _nTileHeight);
			
			// update buffer region!
			_nBufferLeftEdge 		= _nStartTileX;
			_nBufferRightEdge 		= _nStartTileX + _nBufferTileWidth;
			_nBufferTopEdge 		= _nStartTileY;
			_nBufferBottomEdge 		= _nStartTileY + _nBufferTileHeight;
			
			//trace( "nStartTileX::" + nStartTileX );
			//trace( "nStartTileY::" + nStartTileY );
			
			for (var i:int = 0; i < _nBufferTileHeight; i++)
			{
				for (var j:int = 0; j < _nBufferTileWidth; j++)
				{
					if ( i < _nCanvasTileWidth && j < _nCanvasTileHeight )
					{
						var tx:int = _nStartTileX + j;
						var ty:int = _nStartTileY + i;
					
						//trace( "tx: " + tx + " , " + ty )
					
						// find which tile to retrieve!
						var t:int = _aoMapData[ty][tx];
						//trace(t);
						var row:int = Math.floor((t * _nTileWidth) / _nTileSheetWidth);
						var col:int = (t) - ((row * _nTileWidth) * _nTileSheetWidth);
						 
						_rectTileRectangle.x = int((t % _nTileSheet_TilesPerRow)) * _nTileWidth;
						_rectTileRectangle.y = int((t / _nTileSheet_TilesPerRow)) * _nTileHeight;
						_ptBufferPoint.x = j * _nTileWidth;
						_ptBufferPoint.y = i * _nTileHeight;
						_bmdBuffer.copyPixels(_bmdTileSheet, _rectTileRectangle, _ptBufferPoint);
						
						/*
						if ( t == 11 )
						{
							trace("BitmapRenderer::update() _rectTileRectangle: " + _rectTileRectangle.x + ", " + _rectTileRectangle.y + " grid: " + col + " , " + row);
						}
						*/
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
		*	renders items to the canvas
		*/
		public function renderItems(itemList:Array):void
		{
			if (!itemList) return;
			for (var nItemIndex:int = 0; nItemIndex < itemList.length; nItemIndex++)
			{
				var oItem:PhysicalObject = itemList[nItemIndex] as PhysicalObject;
				
				// get the render data for the physical object
				var oRenderData:RenderData = oItem.oRenderData;
				
				if ( bTileViewableInBuffer(oItem.oDimensions.x, oItem.oDimensions.y) )
				{
					switch (oItem.type)
					{
						//case Item.HERB_HEALING :
							
						//break;
						//case Item.WEAPON_SWORD_BLACKFANG :
							
						//break;
						//case Item.ARMOR_SHIELD_IRON :
						default :
							_rectTileRectangle.x = 0;//oItem.nDroppedSpriteSheetX * _nTileWidth;
						 	_rectTileRectangle.y = 0;//oItem.nDroppedSpriteSheetY * _nTileHeight;
														
							_oSpriteCopyPoint = oGetDrawPoint(oItem.oDimensions.x, oItem.oDimensions.y);
							
							// apply offset to copy point for fine tuning the look/placement of things
							_oSpriteCopyPoint.x += nItemOffsetX;
							_oSpriteCopyPoint.y += nItemOffsetY;
							
							var bmdSource:BitmapData = oRenderData.icon;
							if ( !oRenderData.icon ) bmdSource = new BitmapData(_nTileWidth, _nTileHeight);
							
							_bmdCanvas.copyPixels(bmdSource, _rectTileRectangle, _oSpriteCopyPoint );
						break;
					}
				}
			}
		};
		
		
		/**
		*	renders a group of sprites.  updates their animations too.
		*/
		public function renderSprites(spriteList:Array):void
		{
			if (!spriteList) return;
			
			for (var i:int = 0; i < spriteList.length; i++)
			{
				var oSprite:PhysicalObject = spriteList[i] as PhysicalObject;// Wed Sep 16 12:54:58 CDT 2009 CMD TODO: define a base class
				
				// get the render data for the physical object
				var oRenderData:RenderData = oSprite.oRenderData;
				
				// check if the monster will be on screen!
				if ( bTileViewableInBuffer(oSprite.oDimensions.x, oSprite.oDimensions.y) )
				{
					// if the object isn't animating, then it probably just entered the screen for the first time, play it's walking animation
					if (oRenderData.animation == null){
						oRenderData.animation = new CharacterAnimation() as Animation;
						oRenderData.animation.play(CharacterAnimation.WALK, 0);
					}
					
					var nSpriteX:int = oRenderData.animation.update();
					if ( nSpriteX == Animation.COMPLETE )
					{
						oRenderData.animation.play(CharacterAnimation.WALK, 0);
						nSpriteX = oRenderData.animation.update();
					}
					
					// render the sprite!
					var id:int = 0
					switch (id)//(oSprite.id)
					{
					
						//case Mobile.MONSTER:
						//break;
						//case Mobile.HERO:
						default :
							_rectTileRectangle.x = nSpriteX * _nTileWidth;
						 	_rectTileRectangle.y = oSprite.oDimensions.direction * _nTileHeight;
							
							_oSpriteCopyPoint = oGetDrawPoint(oSprite.oDimensions.x, oSprite.oDimensions.y);
							_oSpriteCopyPoint.x += nSpriteOffsetX;
							_oSpriteCopyPoint.y += nSpriteOffsetY;
							
							switch (oSprite.nCurrentAction)
							{
								case Action.MOVE :
									if ( oLerpX.target == oSprite ) _oSpriteCopyPoint.x += oLerpX.currentValue;
									if ( oLerpY.target == oSprite ) _oSpriteCopyPoint.y += oLerpY.currentValue;
								break;
							}
							
							var bmdSource:BitmapData = oRenderData.spriteSheet;
							if ( !oRenderData.spriteSheet ) bmdSource = new BitmapData(_nTileWidth, _nTileHeight);
							
							// copy pixels multiple times.
							// 1 - body body
							_bmdCanvas.copyPixels(bmdSource, _rectTileRectangle, _oSpriteCopyPoint );
							// 2 - body armor pass
							_bmdCanvas.copyPixels(bmdSource, _rectTileRectangle, _oSpriteCopyPoint );
							// 3 - shield pass
							_bmdCanvas.copyPixels(bmdSource, _rectTileRectangle, _oSpriteCopyPoint );
							// 4 weapon pass
							_bmdCanvas.copyPixels(bmdSource, _rectTileRectangle, _oSpriteCopyPoint );
							// 5 head pass 1
							_bmdCanvas.copyPixels(bmdSource, _rectTileRectangle, _oSpriteCopyPoint );
							// 6 head pass 2
							_bmdCanvas.copyPixels(bmdSource, _rectTileRectangle, _oSpriteCopyPoint );
						break;
					}
				}
				else
				{
					// clear out the animation object since we don't need to render this guy!
					if ( oRenderData.animation != null ) oRenderData.animation = null;
				}
			}
		};
		
		public function renderVFX(vfxList:Array):void
		{
			if (!vfxList) return;
			
			for (var i:int = 0; i < vfxList.length; i++)
			{
				// render some vfx!
				
			}
		}
				
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
		
		public function get bmdCanvas():BitmapData
		{
			return _bmdCanvas;
		};
		
		public function get nMapWidthInPixels():int{
			return _nMapWidthInPixels;
		};
		
		public function get nMapHeightInPixels():int{
			return _nMapHeightInPixels;
		};
		
		public function get nCanvasWidth():int{
			return _nCanvasWidth;
		};
		
		public function get nCanvasHeight():int{
			return _nCanvasHeight;
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