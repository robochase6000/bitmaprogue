package com.chasedelanguillette.system
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
	import flash.system.System;

    public class MemoryWatch extends Sprite
	{
		public static const LABEL_BYTES:String = "b";
		public static const LABEL_KILOBYTES:String = "kb";
		public static const LABEL_MEGABYTES:String = "mb";
		public static const LABEL_GIGABYTES:String = "gb";
		
        private var tf:TextField;
		private var fMemoryMultiplier:Number = 1;
		private var nDecimals:int = 0;
		private var szLabel:String = LABEL_KILOBYTES;

        public function MemoryWatch(nRoundTo:int, nDecimalPrecision:int, xPos:int=0, yPos:int=17, color:uint=0xffffff, fillBackground:Boolean=false, backgroundColor:uint=0x000000) 
		{
			fMemoryMultiplier = 1 / nRoundTo;
			nDecimals = nDecimalPrecision;
			switch (nRoundTo)
			{
				case 0 :
					szLabel = LABEL_BYTES;
				break;
				case 1000 :
					szLabel = LABEL_KILOBYTES;
				break;
				case 1000000 :
					szLabel = LABEL_MEGABYTES;
				break;
				case 1000000000 :
					szLabel = LABEL_GIGABYTES;
				break;
				default :
					szLabel = "";
				break;
			}
            x = xPos;
            y = yPos;
            tf = new TextField();
            tf.textColor = color;
            tf.text = "----- " + szLabel;
            tf.selectable = false;
            tf.background = fillBackground;
            tf.backgroundColor = backgroundColor;
            tf.autoSize = TextFieldAutoSize.LEFT;
            addChild(tf);
            width = tf.textWidth;
            height = tf.textHeight;
            addEventListener(Event.ENTER_FRAME, tick);
        }

        public function tick(evt:Event):void 
		{
			var nMemory:Number = System.totalMemory * fMemoryMultiplier;
			nMemory *= Math.pow(10, nDecimals);
			nMemory = Math.round(nMemory);
			nMemory /= Math.pow(10, nDecimals);
			tf.text = nMemory  + " " + szLabel;
        }
    }
}