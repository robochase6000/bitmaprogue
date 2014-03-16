///////////////////////////////////////////////////
//	XMLWriter
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
	import flash.geom.Rectangle;
	
	public class XMLWriter
	{
		
		//============================================
		//	CONSTANTS
		//============================================
		
		
		
		//============================================
		//	PUBLIC VARS
		//============================================
		private static var map:XML 					= new XML("<room></room>");
		private static var textureURL:XML 			= new XML("<texture></texture>");
		private static var regions:XML 				= new XML("<regions></regions>");
		
		
		
		//============================================
		//	PRIVATE VARS
		//============================================
		
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function XMLWriter():void
		{
			
		};

		
		//////////////////////////////////////////////
		//
		//	PUBLIC METHODS
		//
		//////////////////////////////////////////////
		
		public static function vReset():void
		{
			trace("XMLWriter::vReset()");
			map 					= new XML("<room></room>");
			textureURL 				= new XML("<texture></texture>");
			regions 				= new XML("<regions></regions>");
		}
		
		public static function vAddRegion(region:Room, nType:int):void
		{
			trace("XMLWriter::vAddRegion()");
			var r:XML = new XML();
			r = <region id={nType} x={region.x} y={region.y} w={region.width} h={region.height} />;
			regions = regions.appendChild(r);
		};
		
		public static function vSetTextureURL(szURL:String):void
		{
			trace("XMLWriter::vSetTextureURL()");
			textureURL = new XML();
			textureURL = <texture url={szURL} />
		};
		
		public static function vGenerateXML():XML
		{
			trace("XMLWriter::vGenerateXML()");
			map = new XML("<room></room>");
			map = map.appendChild(textureURL);
			map = map.appendChild(regions);
			return map;
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