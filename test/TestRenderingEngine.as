package com.happyelements.test
{
	import com.happyelements.display.DrawingGraphics;
	import com.happyelements.display.HEDisplayObject;
	import com.happyelements.display.HEDisplayObjectContainer;
	import com.happyelements.display.HEStage;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	/**
	 * @author dongpiggyi
	 */
	public class TestRenderingEngine extends Sprite
	{
		private var windowRect:Rectangle;
		private var heStage:HEStage;
		private var canvas:BitmapData;

		public function TestRenderingEngine()
		{
			testBitmapRendering();
			// testOriginRendering();
		}

		private function testOriginRendering():void
		{
			var container1:TestSprite = new TestSprite();
			var container2:TestSprite = new TestSprite();
			var container3:TestSprite = new TestSprite();
			var child1:TestSprite = new TestSprite();
			var child2:TestSprite = new TestSprite();
			var child3:TestSprite = new TestSprite();
			var child4:TestSprite = new TestSprite();
			var child5:TestSprite = new TestSprite();

			container1.drawRect(10, 0, 100, 100, 0xFF0000);
			container2.drawRect(0, 0, 100, 100, 0x0000FF);
			container3.drawRect(0, 0, 120, 110, 0x66CC00);

			child1.drawRect(0, 0, 40, 40, 0x55AA99);
			child2.drawRect(0, 0, 40, 40, 0x33FF33);
			child3.drawRect(0, 10, 40, 40, 0xFFFF00);
			child4.drawRect(0, 0, 40, 40, 0xFF6666);
			child5.drawRect(0, 0, 40, 40, 0xFF99FF);

			container1.x = container1.y = 50;
			container2.x = container2.y = 20;
			container3.x = 100;
			child1.x = child1.y = 20;
			child2.x = child2.y = 30;
			child3.x = child3.y = 80;
			child4.x = child4.y = 20;
			child5.x = child5.y = 40;

			container1.addChild(child1);
			container1.addChild(child2);
			container1.addChild(child3);

			container2.addChild(child4);
			container2.addChild(child5);

			container3.addChild(container1);

			addChild(container3);
			addChild(container2);
		}

		private function testBitmapRendering():void
		{
			heStage = HEStage.getInstance();
			heStage.stageWidth = stage.stageWidth;
			heStage.stageHeight = stage.stageHeight;

			windowRect = new Rectangle(0, 0, heStage.width, heStage.height);

			canvas = new BitmapData(heStage.stageWidth, heStage.stageHeight);

			var container1:HEDisplayObjectContainer = new HEDisplayObjectContainer();
			var container2:HEDisplayObjectContainer = new HEDisplayObjectContainer();
			var container3:HEDisplayObjectContainer = new HEDisplayObjectContainer();
			var child1:HEDisplayObject = new HEDisplayObject();
			var child2:HEDisplayObject = new HEDisplayObject();
			var child3:HEDisplayObject = new HEDisplayObject();
			var child4:HEDisplayObject = new HEDisplayObject();
			var child5:HEDisplayObject = new HEDisplayObject();

			container1.displaySource = new DrawingGraphics();
			container2.displaySource = new DrawingGraphics();
			container3.displaySource = new DrawingGraphics();
			child1.displaySource = new DrawingGraphics();
			child2.displaySource = new DrawingGraphics();
			child3.displaySource = new DrawingGraphics();
			child4.displaySource = new DrawingGraphics();
			child5.displaySource = new DrawingGraphics();

			DrawingGraphics(container1.displaySource).drawRect(10, 0, 100, 100, 0xFF0000);
			DrawingGraphics(container2.displaySource).drawRect(0, 0, 100, 100, 0x0000FF);
			DrawingGraphics(container3.displaySource).drawRect(0, 0, 120, 110, 0x66CC00);
			DrawingGraphics(child1.displaySource).drawRect(0, 0, 40, 40, 0x55AA99);
			DrawingGraphics(child2.displaySource).drawRect(0, 0, 40, 40, 0x33FF33);
			DrawingGraphics(child3.displaySource).drawRect(0, 10, 40, 40, 0xFFFF00);
			DrawingGraphics(child4.displaySource).drawRect(0, 0, 40, 40, 0xFF6666);
			DrawingGraphics(child5.displaySource).drawRect(0, 0, 40, 40, 0xFF99FF);

			container1.x = container1.y = 50;
			container2.x = container2.y = 20;
			container3.x = 100;
			child1.x = child1.y = 20;
			child2.x = child2.y = 30;
			child3.x = child3.y = 80;
			child4.x = child4.y = 20;
			child5.x = child5.y = 40;

			container1.addChild(child1);
			container1.addChild(child2);
			container1.addChild(child3);

			container2.addChild(child4);
			container2.addChild(child5);

			container3.addChild(container1);

			heStage.addChild(container3);
			heStage.addChild(container2);

			var bitmap:Bitmap = new Bitmap(canvas);
			addChild(bitmap);

			heStage.update(canvas, windowRect);

			// startRendering();

			trace("child3 globalRect " + child3.getGlobalRect());
			trace("container1 globalRect " + container1.getGlobalRect());
			trace("container3 globalRect " + container3.getGlobalRect());
			trace("stage globalRect" + heStage.getGlobalRect());
		}

		private function startRendering():void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event:Event):void
		{
			stage.invalidate();
			heStage.update(canvas, windowRect);
		}
	}
}
