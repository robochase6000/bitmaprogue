package debug
{
	import flash.display.*;
	import flash.events.*;
	
	public class DebugManager extends Object
	{
		public static var stageRef:Stage;
		public static var debugLayer:Sprite;
		
		public static var width:int;
		public static var height:int;
		
		public static function init(stageRef:Stage):void
		{
			DebugManager.stageRef = stageRef;
			if (!DebugManager.stageRef) throw(new Error("trying to initialize DebugManager without first setting a stage reference"));
			
			debugLayer = new Sprite();
			width = stageRef.stageWidth;
			height = stageRef.stageHeight
			DebugManager.stageRef.addChild(debugLayer);
			
			ScreenPrint.init(DebugManager.debugLayer);
		}
		
		public static function update():void
		{
			ScreenPrint.update();
		}
	}
}