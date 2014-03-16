///////////////////////////////////////////////////
//	Minimap
//	CREATED: 2009-09-10.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//
//
//////////////////////////////////////////////////


package com.chasedelanguillette.roguish.maps
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	import com.chasedelanguillette.roguish.maps.sections.Tile;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	
	public class Minimap
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		
		public var nMapWidth:int;
		public var nMapHeight:int;
		public var aoMapLayout:Array;
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function Minimap(aoLayout:Array, nWidth:int, nHeight:int):void
		{
			this.aoMapLayout 		= aoLayout;
			nMapWidth 				= nWidth;
			nMapHeight 				= nHeight;
			
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public function newMap(width:int, height:int):void
		{
			cleanUp();
			nMapWidth = width;
			nMapHeight = height;
			aoMapLayout = new Array();
			for (var i:int = 0; i < nMapHeight; i++)
			{
				aoMapLayout[i] = new Array();
				for (var j:int = 0; j < nMapWidth; j++)
				{
					aoMapLayout[i][j] = new Tile();
				}
			}
		};
		
		public function cleanUp():void
		{
			//
			if ( aoMapLayout != null )
			{
				for (var i:int = 0; i < aoMapLayout.length; i++)
				{
					if ( aoMapLayout[i] != null )
					{
						for (var j:int = 0; j < aoMapLayout[i].length; j++)
						{
							aoMapLayout[i][j] = null;
						}
						aoMapLayout[i] = null;
					}
				}
				aoMapLayout = null;
			}
		};
		
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