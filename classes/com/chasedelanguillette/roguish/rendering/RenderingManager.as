package com.chasedelanguillette.roguish.rendering
{	
	public class RenderingManager
	{
		private var _nRenderWindowWidth:int;
		private var _nRenderWindowHeight:int;
		
		private var _aoDrawLayers:Array = new Array();
		
		
		/**
		*	@constructor
		*/
		public function RenderingManager(width:int, height:int):void
		{
			_nRenderWindowWidth = width;
			_nRenderWindowHeight = height;
		};
		
		
		/**
		*	to be executed every frame.	
		*/
		public function frameUpdate():void
		{
			
		};
		
		public function setRenderWindow(width:int, height:int):void
		{
			_nRenderWindowWidth = width;
			_nRenderWindowHeight = height;
		};
		
		public function setDrawLayer(nLayerId:int, aoGroup:Array, szName:String = "drawLayer"):void
		{
			_aoDrawLayers[nLayerId] = 
		}
	}
}