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

//            var childOnly:HEDisplayObject = new HEDisplayObject();
//			childOnly.drawRect(0, 0, 78, 78, 0x336699);
//			childOnly.x = childOnly.y = 10;
//			
//			var containerOnly:HEDisplayObjectContainer = new HEDisplayObjectContainer();
//			containerOnly.drawRect(0, 0, 86, 86, 0xFF6600);
//			containerOnly.x = containerOnly.y = 20;
//			
//			containerOnly.addChild(childOnly);
//			heStage.addChild(containerOnly);
//			heStage.update(canvas, windowRect);
//			
//			trace("getRect: " + containerOnly.getGlobalRect().x, containerOnly.getGlobalRect().width);
//			trace("getRect: " + childOnly.getGlobalRect().x, childOnly.getGlobalRect().width);
			
//			testBitmapRender();
			testOriginRender();
		}
		
		private function testOriginRender():void
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
		
		private function testBitmapRender():void
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
			
			var drawingGraphicsContainer1:DrawingGraphics = new DrawingGraphics();
			var drawingGraphicsContainer2:DrawingGraphics = new DrawingGraphics();
			var drawinggraphicsChild1:DrawingGraphics = new DrawingGraphics();
			var drawinggraphicsChild2:DrawingGraphics = new DrawingGraphics();
			var drawinggraphicsChild3:DrawingGraphics = new DrawingGraphics();
			var drawinggraphicsChild4:DrawingGraphics = new DrawingGraphics();
			var drawinggraphicsChild5:DrawingGraphics = new DrawingGraphics();
			
			drawingGraphicsContainer1.drawRect(0, 0, 100, 100, 0xFF0000);
			drawingGraphicsContainer2.drawRect(0, 0, 100, 100, 0x0000FF);
			drawinggraphicsChild1.drawRect(0, 0, 40, 40, 0x3333FF);
			drawinggraphicsChild2.drawRect(0, 0, 40, 40, 0x33FF33);
			drawinggraphicsChild3.drawRect(0, 0, 40, 40, 0xFFFF00);
			drawinggraphicsChild4.drawRect(0, 0, 40, 40, 0xFF6666);
			drawinggraphicsChild5.drawRect(0, 0, 40, 40, 0xFF99FF);
            
//            container1.drawRect(0, 0, 100, 100, 0xFF0000);
//            container2.drawRect(0, 0, 100, 100, 0x0000FF);
            container1.displaySource = drawingGraphicsContainer1;
            container2.displaySource = drawingGraphicsContainer2;
			
            child1.displaySource = drawinggraphicsChild1;
			child2.displaySource = drawinggraphicsChild2;
			child3.displaySource = drawinggraphicsChild3;
			child4.displaySource = drawinggraphicsChild4;
			child5.displaySource = drawinggraphicsChild5;
//            child1.drawRect(0, 0, 40, 40, 0x3333FF);
//            child2.drawRect(0, 0, 40, 40, 0x33FF33);
//            child3.drawRect(0, 0, 40, 40, 0xFFFF00);
//            child4.drawRect(0, 0, 40, 40, 0xFF6666);
//            child5.drawRect(0, 0, 40, 40, 0xFF99FF);
            
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
