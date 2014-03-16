///////////////////////////////////////////////////
//	RenderData
//	CREATED: 2009-11-10.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.objects.properties
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.rendering.animation.Animation;
	import com.chasedelanguillette.roguish.rendering.animation.characters.CharacterAnimation;
	
	import com.chasedelanguillette.geom.SimplePoint;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	import flash.display.BitmapData;
	
	
	
	/**
	*	The RenderData object contains information about a physical object's display.
	*	
	*	<p>The PhysicalObject is the model, essentially.  The render data is the view, and the game manager/renderer is the controller.</p>
	*/
	public class RenderData
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		/**
		*	A static point that determines where from the sprite sheet to copy from.  No sense in having a million of these floating around, to it's static.
		*/
		private static var _oSpriteSheetCopyPoint:SimplePoint = new SimplePoint(0,0);
		
		
		/**
		*	default icon in case we never set one.  Made static so we don't have a skajillion defaults lying around.
		*/
		public static var defaultIcon:BitmapData = new BitmapData(1, 1);
		
		
		/**
		*	Ideally, every game object could be represented as an icon if we didn't want it to animate.
		*/
		public var icon:BitmapData = RenderData.defaultIcon;
		
		
		/**
		*	Indicates whether this thing animates.
		*/
		public var animates:Boolean = true;
		
		
		/**
		*	Animation Object to hold info about its animation state.
		*/
		public var animation:Animation = null;
		
		
		public static var defaultSpriteSheet:Blob_Black = new Blob_Black(640, 640);
		
		/**
		*	Array contains every sprite sheet to use when rendering this object.
		*	
		*	<p>When the renderer gets to drawing this object, it will first look at the animation object to figure out which tile to copy from the sprite sheet.
		*	Then, the renderer will loop through this array of sprite sheets and copy the correct tile, once from EVERY sprite sheet contained in this array.</p>
		*	
		*	<p>The idea here is that this allows us to stack things.  For example, we'll first copy the hero's body from one sprite sheet, the draw his clothes on top of the hero's body, then his armor, etc.</p>
		*/
		public var spriteSheets:Array = [defaultSpriteSheet];
		
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function RenderData():void
		{
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public static function updateAnimation(oRenderData:RenderData):void
		{
			// Tue Dec  8 08:57:13 CST 2009 CMD TODO: update animation for oRenderData
			
			// if the object isn't animating, then it probably just entered the screen for the first time, play it's walking animation
			if (oRenderData.animation == null){
				// Tue Dec  8 09:09:06 CST 2009 CMD TODO: initiate a unique animation for the object.  
				// don't just create a CharacterAnimation!  You may have like a VFX animation or something else.
				oRenderData.animation = new CharacterAnimation() as Animation;
				oRenderData.animation.play(CharacterAnimation.WALK, 0);
			}
			
			// Tue Dec  8 09:12:58 CST 2009 CMD TODO: revise this, it's a little gimped.  nSpriteX should be calculated by RenderData.getSpriteSheetCopyPoint() !!!
			var nSpriteX:int = oRenderData.animation.update();
			if ( nSpriteX == Animation.COMPLETE )
			{
				// Tue Dec  8 09:14:35 CST 2009 CMD TODO: change it so it doesn't loop back to character walk cycle..what if we were to animate vfx?
				oRenderData.animation.play(CharacterAnimation.WALK, 0);
				nSpriteX = oRenderData.animation.update();
			}
		};
		
		public static function getSpriteSheetCopyPoint(oRenderData:RenderData):SimplePoint
		{
			// Sun Dec  6 13:17:19 CST 2009 CMD TODO: figure out what point to copy from
			if ( !_oSpriteSheetCopyPoint ) _oSpriteSheetCopyPoint = new SimplePoint(0,0);
			_oSpriteSheetCopyPoint.x = oRenderData.animation.currentFrame;
			_oSpriteSheetCopyPoint.y = 0;
			return _oSpriteSheetCopyPoint;
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
		
		
		
		//////////////////////////////////////////////
		//
		//	PRIVATE METHODS
		//
		//////////////////////////////////////////////
		
		
	}
}