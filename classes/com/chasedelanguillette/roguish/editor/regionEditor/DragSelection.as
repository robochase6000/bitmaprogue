﻿package com.chasedelanguillette.roguish.editor.regionEditor{	import flash.events.MouseEvent;	import flash.display.Sprite;	import flash.display.Stage;	import flash.events.Event;	import flash.events.EventDispatcher;		import com.chasedelanguillette.roguish.editor.regionEditor.InputEvent;		public class DragSelection extends EventDispatcher	{		public static const DRAW_REGION_DISABLED:int = 0;				private var mouse:Object 				= {down:false, clickX:-1, clickY:-1};		private var selection:Object 			= {color:0x6666ff};		private var stageRef:Stage;				public function DragSelection(stageRef:Stage, drawRegion:Sprite, snapx:Number, snapy:Number):void		{			this.stageRef	 				= stageRef;						selection.drawRegion 			= drawRegion;			selection.outline 				= {weight:1, color:selection.color, alpha:1.0};			selection.fill 					= {color:selection.color, alpha:selection.outline.alpha/2};			selection.dragRegion 			= {x1:0, y1:0, x2:0, y2:0};						var snapxEnabled:Boolean 		= false;			var snapyEnabled:Boolean 		= false;			if (snapx > 0) snapxEnabled 	= true;			if (snapy > 0) snapyEnabled 	= true;			selection.snapping 				= {x:{enabled:snapxEnabled, pixels:snapx}, y:{enabled:snapyEnabled, pixels:snapy}};		}						//======================================================		//	PUBLIC		//======================================================				public function vSetEnabled(bEnabled:Boolean):void		{			if ( bEnabled )			{				stageRef.addEventListener(MouseEvent.MOUSE_DOWN, vMouseDown);				stageRef.addEventListener(MouseEvent.MOUSE_UP, vMouseUp);				stageRef.addEventListener(MouseEvent.MOUSE_MOVE, vMouseMove);			}			else			{				stageRef.removeEventListener(MouseEvent.MOUSE_DOWN, vMouseDown);				stageRef.removeEventListener(MouseEvent.MOUSE_UP, vMouseUp);				stageRef.removeEventListener(MouseEvent.MOUSE_MOVE, vMouseMove);			}		};				public function vResetSelection():void		{			// reset selection			if (selection.drawRegion){				selection.drawRegion.graphics.clear();				selection.dragRegion.x1 = 0;				selection.dragRegion.y1 = 0;				selection.dragRegion.x2 = 0;				selection.dragRegion.y2 = 0;			} else {				vReportError(DRAW_REGION_DISABLED);			}		};				public function oGetSelection():Object		{			var object:Object = new Object();			object.x1 = selection.dragRegion.x1;			object.y1 = selection.dragRegion.y1;			object.x2 = selection.dragRegion.x2;			object.y2 = selection.dragRegion.y2;			return object;		};				private function vReportError(nErrorCode:int):void		{			trace("DragSelection :: vReportErrorCode(nErrorCode: " + nErrorCode);					}						//======================================================		//	EVENTS		//======================================================				private function vMouseDown(evt:MouseEvent):void		{			mouse.down = true;			mouse.clickX = stageRef.mouseX;			mouse.clickY = stageRef.mouseY;						// update x (snap, if enabled)			var divisions:int;			if (selection.snapping.x.enabled){				divisions = Math.floor(mouse.clickX / selection.snapping.x.pixels);				selection.dragRegion.x1 = divisions * selection.snapping.x.pixels;			} else {				selection.dragRegion.x1 = mouse.clickX;			}						// update y (snap, if enabled)			if (selection.snapping.y.enabled){				divisions = Math.floor(mouse.clickY / selection.snapping.y.pixels);				selection.dragRegion.y1 = divisions * selection.snapping.y.pixels;			} else {				selection.dragRegion.y1 = mouse.clickY;			}		}				private function vMouseUp(evt:MouseEvent):void		{			mouse.down = false;						// let someone know how awesome we are!			dispatchEvent(new InputEvent(InputEvent.DRAG_SELECTION_COMPLETE));		}				private function vMouseMove(evt:MouseEvent):void		{			if (mouse.down)			{				vUpdateDragRegion(stageRef.mouseX, stageRef.mouseY);			}		}						//======================================================		//	PRIVATES		//======================================================				function vUpdateDragRegion(x2:Number, y2:Number):void		{			// update x (snap, if enabled)			var divisions:int;			if (selection.snapping.x.enabled){				divisions = Math.floor(x2 / selection.snapping.x.pixels);				selection.dragRegion.x2 = divisions * selection.snapping.x.pixels;			} else {				selection.dragRegion.x2 = x2;			}						// update y (snap, if enabled)			if (selection.snapping.y.enabled){				divisions = Math.floor(y2 / selection.snapping.y.pixels);				selection.dragRegion.y2 = divisions * selection.snapping.y.pixels;			} else {				selection.dragRegion.y2 = y2;			}						if (selection.drawRegion){				selection.drawRegion.graphics.clear();				selection.drawRegion.graphics.lineStyle(selection.outline.weight, selection.outline.color, selection.outline.alpha);				selection.drawRegion.graphics.beginFill( selection.fill.color, selection.fill.alpha);				vDrawRectFromPoints(selection.drawRegion, selection.dragRegion.x1, selection.dragRegion.y1, selection.dragRegion.x2, selection.dragRegion.y2);				selection.drawRegion.graphics.endFill();			} else {				vReportError(DRAW_REGION_DISABLED);			}		}				function vDrawRectFromPoints(drawRegion:Sprite, x1:Number, y1:Number, x2:Number, y2:Number):void		{			drawRegion.graphics.moveTo(x1, y1)			drawRegion.graphics.lineTo(x2, y1);			drawRegion.graphics.lineTo(x2, y2);			drawRegion.graphics.lineTo(x1, y2);			drawRegion.graphics.lineTo(x1, y1);		}	}}