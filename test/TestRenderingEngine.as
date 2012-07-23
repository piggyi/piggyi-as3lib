package com.happyelements.test
{
	import com.happyelements.display.DrawingGraphics;
	import flash.geom.Rectangle;
	import flash.display.Bitmap;
	import com.happyelements.display.HEDisplayObject;
	import com.happyelements.display.HEDisplayObjectContainer;

	import flash.display.BitmapData;

	import com.happyelements.display.HEStage;

	import flash.display.Sprite;

	/**
	 * @author dongpiggyi
	 */
	public class TestRenderingEngine extends Sprite
	{
		private var windowRect:Rectangle;
		
		public function TestRenderingEngine()
		{
			testBitmapRendering();
//			testOriginRendering();
		}
		
		private function testOriginRendering():void
		{
			var container1:TestSprite = new TestSprite();
            var container2:TestSprite = new TestSprite();
            var child1:TestSprite = new TestSprite();
            var child2:TestSprite = new TestSprite();
            var child3:TestSprite = new TestSprite();
            var child4:TestSprite = new TestSprite();
            var child5:TestSprite = new TestSprite();
            
            container1.drawRect(0, 0, 100, 100, 0xFF0000);
            container2.drawRect(0, 0, 100, 100, 0x0000FF);
            
            child1.drawRect(0, 0, 40, 40, 0x3333FF);
            child2.drawRect(0, 0, 40, 40, 0x33FF33);
            child3.drawRect(0, 0, 40, 40, 0xFFFF00);
            child4.drawRect(0, 0, 40, 40, 0xFF6666);
            child5.drawRect(0, 0, 40, 40, 0xFF99FF);
            
            container1.x = container1.y =  50;
            child1.x = child1.y = 10;
            child2.x = child2.y = 20;
            child3.x = child3.y = 30;
            child4.x = child4.y = 20;
            child5.x = child5.y = 40;

            container1.addChild(child1);
            container1.addChild(child2);
            container1.addChild(child3);

            container2.addChild(child4);
            container2.addChild(child5);

            addChild(container1);
			addChild(container2);
			
		}
		
		private function testBitmapRendering():void
		{
			var heStage:HEStage = HEStage.getInstance();
            heStage.width = stage.stageWidth;
            heStage.height = stage.stageHeight;
            
            windowRect = new Rectangle(0, 0, heStage.width, heStage.height);

            var canvas:BitmapData = new BitmapData(heStage.width, heStage.height);

            var container1:HEDisplayObjectContainer = new HEDisplayObjectContainer();
            var container2:HEDisplayObjectContainer = new HEDisplayObjectContainer();
            var child1:HEDisplayObject = new HEDisplayObject();
            var child2:HEDisplayObject = new HEDisplayObject();
            var child3:HEDisplayObject = new HEDisplayObject();
            var child4:HEDisplayObject = new HEDisplayObject();
            var child5:HEDisplayObject = new HEDisplayObject();
			
			container1.displaySource = new DrawingGraphics();
			container2.displaySource = new DrawingGraphics();
			child1.displaySource = new DrawingGraphics();
			child2.displaySource = new DrawingGraphics();
			child3.displaySource = new DrawingGraphics();
			child4.displaySource = new DrawingGraphics();
			child5.displaySource = new DrawingGraphics();
			
			DrawingGraphics(container1.displaySource).drawRect(0, 0, 100, 100, 0xFF0000);
			DrawingGraphics(container2.displaySource).drawRect(0, 0, 100, 100, 0x0000FF);
			DrawingGraphics(child1.displaySource).drawRect(0, 0, 40, 40, 0x3333FF);
			DrawingGraphics(child2.displaySource).drawRect(0, 0, 40, 40, 0x33FF33);
			DrawingGraphics(child3.displaySource).drawRect(0, 0, 40, 40, 0xFFFF00);
			DrawingGraphics(child4.displaySource).drawRect(0, 0, 40, 40, 0xFF6666);
			DrawingGraphics(child5.displaySource).drawRect(0, 0, 40, 40, 0xFF99FF);
            
            container1.x = container1.y =  50;
            child1.x = child1.y = 10;
            child2.x = child2.y = 20;
            child3.x = child3.y = 30;
            child4.x = child4.y = 20;
            child5.x = child5.y = 40;

            container1.addChild(child1);
            container1.addChild(child2);
            container1.addChild(child3);

            container2.addChild(child4);
            container2.addChild(child5);

            heStage.addChild(container1);
            heStage.addChild(container2);
            
            heStage.update(canvas, windowRect);
			
			var bitmap:Bitmap = new Bitmap(canvas);
            addChild(bitmap);
		}
	}
}
