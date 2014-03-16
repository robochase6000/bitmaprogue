///////////////////////////////////////////////////
//	MapLoader
//	CREATED: 2009-08-14.
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
	
	import com.chasedelanguillette.roguish.editor.roomEditor.MapLoaderEvent;
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	public class MapLoader extends EventDispatcher
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
		
		private var _xmlMap:XML = new XML();
		private var myLoader:URLLoader;
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function MapLoader(szURL:String = "", bEnabled:Boolean = false):void
		{			
			var _xmlMap:XML = new XML();
			var XML_URL:String = szURL;
			var myXMLURL:URLRequest = new URLRequest(XML_URL);
			myLoader = new URLLoader(myXMLURL);
			myLoader.addEventListener(Event.COMPLETE, xmlLoaded);	
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
		
		public function get xmlMap():XML{
			return _xmlMap;
		}
		
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
		
		private function xmlLoaded(event:Event):void
		{
			myLoader.removeEventListener(Event.COMPLETE, xmlLoaded);
		    _xmlMap = XML(myLoader.data);
			trace(_xmlMap);
		    trace("Data loaded.");
			//
			dispatchEvent(new MapLoaderEvent(MapLoaderEvent.MAP_LOAD_COMPLETE));
		}
		
		
		//////////////////////////////////////////////
		//
		//	PRIVATE METHODS
		//
		//////////////////////////////////////////////
		
		
	}
}