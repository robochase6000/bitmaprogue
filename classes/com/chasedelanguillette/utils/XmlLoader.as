///////////////////////////////////////////////////
//	XmlLoader
//	CREATED: 2009-08-17.
//	BY: CHASE DE LANGUILLETTE - chase.delanguillette@gmail.com
//
//	CLASS RESPONSIBILITES:
//	Your basic xml loader.  You tell it which xml file to load, it will load it, and fire an event complete when finished.
// 	Then, you can easily retrieve your xml file using the getter loadedXML()
//
//////////////////////////////////////////////////


package com.chasedelanguillette.utils
{
	//============================================
	//	CUSTOM IMPORTS
	//============================================
	
	
	//============================================
	//	STANDARD IMPORTS
	//============================================
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	
	public class XmlLoader extends EventDispatcher
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
		
		private var _loadedXML:XML;
		private var myLoader:URLLoader;
		private var _bLoaded:Boolean = false;
		private var _szURL:String;
		
		
		
		//////////////////////////////////////////////
		//
		//	CONSTRUCTOR
		//
		//////////////////////////////////////////////
		
		public function XmlLoader(szURL:String):void
		{		
			_szURL = szURL
			var myXMLURL:URLRequest = new URLRequest(_szURL);
			myLoader = new URLLoader(myXMLURL);
			myLoader.addEventListener(Event.COMPLETE, xmlLoaded);
		};
		
		public function get loadedXML():XML{
			return _loadedXML;
		}
		
		public function get bLoaded():Boolean{
			return _bLoaded;
		};
		
		public function get szURL():String{
			return _szURL;
		}
		
		private function xmlLoaded(event:Event):void
		{
			trace("Data loaded: " + _szURL + "\n: " + myLoader.data);
			_bLoaded = true;
			myLoader.removeEventListener(Event.COMPLETE, xmlLoaded);
		    _loadedXML = XML(myLoader.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}