package com.happyelements.display
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	/**
	 * @author dongpiggyi
	 */
	public class HEDisplayObject
	{
		private var _width:Number;
		private var _height:Number;
		private var _x:Number;
		private var _y:Number;
		private var _alpha:Number;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _parent:HEDisplayObjectContainer;
		
		// point to the root stage
		private var _stage:HEStage;
		
		// point to the display source info of this HEDisplayObject, such as Image and Animation  
		private var _displaySource:AbstractDisplaySource;
		
		// for debug
		private var _debugName:String;

		public function HEDisplayObject()
		{
			_x = 0;
			_y = 0;
			_alpha = 1;
			_width = 0;
			_height = 0;
			_scaleX = 1;
			_scaleY = 1;
		}

		/* Public Properties */
		public function get width():Number
		{
			return _width;
		}

		public function set width(width:Number):void
		{
			_width = width;
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(height:Number):void
		{
			_height = height;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(x:Number):void
		{
			_x = x;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(y:Number):void
		{
			_y = y;
		}

		public function get alpha():Number
		{
			return _alpha;
		}

		public function set alpha(alpha:Number):void
		{
			_alpha = alpha;
		}

		public function get scaleX():Number
		{
			return _scaleX;
		}

		public function set scaleX(scaleX:Number):void
		{
			_scaleX = scaleX;
		}

		public function get scaleY():Number
		{
			return _scaleY;
		}

		public function set scaleY(scaleY:Number):void
		{
			_scaleY = scaleY;
		}

		public function get parent():HEDisplayObjectContainer
		{
			return _parent;
		}

		internal function setParent(parent:HEDisplayObjectContainer):void
		{
			_parent = parent;
		}

		public function get debugName():String
		{
			return _debugName;
		}

		public function set debugName(debugName:String):void
		{
			_debugName = debugName;
		}

		/* Public Methods*/
		public function getGlobalRect():Rectangle
		{
			var currentDO:HEDisplayObject = this;
			var rect:Rectangle = new Rectangle();

			while (!(currentDO is HEStage))
			{
				rect.x += currentDO.x;
				rect.y += currentDO.y;

				currentDO = currentDO.parent;
			}

			return rect;
		}

		public function getRect(targetCoordinateSpace:HEDisplayObject):Rectangle
		{
			return null;
		}

		public function get stage():HEStage
		{
			return _stage;
		}
		
		internal function setStage(stage:HEStage):void
		{
			_stage = stage;
		}

		/**
		 * 每次渲染时调用
		 * canvas 全局位图数据的引用
		 * rect   窗口位置，用来屏蔽窗口外的显示对象以及计算窗口边缘交集显示对象
		 */
		public function update(canvas:BitmapData, rect:Rectangle):void
		{
			if (displaySource)
			{
    			_draw(canvas, rect);
			}
				
			calculateSize();
		}

		private function calculateSize():void
		{
//			width = graphicsRect.width;
//			height = graphicsRect.height;
		}

		private function _draw(canvas:BitmapData, rect:Rectangle):void
		{
			var globalRect:Rectangle = getGlobalRect();
			var x:Number = globalRect.x;
			var y:Number = globalRect.y;
//			var width:Number = graphicsRect.width;
//			var height:Number = graphicsRect.height;

//			var tmpBitmapData:BitmapData = new BitmapData(width, height, true, color | 0xFF000000);
//			canvas.copyPixels(tmpBitmapData, new Rectangle(0, 0, width, height), new Point(x, y));
            
			_displaySource.drawToStage(canvas, rect, x, y);

//			tmpBitmapData.dispose();
//			tmpBitmapData = null;
		}

		private var graphicsRect:Rectangle;
		private var color:uint;

		public function drawRect(x:Number, y:Number, width:Number, height:Number, color:uint = 0x000000):void
		{
			if (graphicsRect)
			{
				graphicsRect.x = x;
				graphicsRect.y = y;
				graphicsRect.width = width;
				graphicsRect.height = height;
			}
			else
			{
				graphicsRect = new Rectangle(x, y, width, height);
			}
			this.color = color;
		}

		public function toString():String
		{
			return "[HEDisplayObject] " + debugName;
		}

		public function get displaySource():AbstractDisplaySource
		{
			return _displaySource;
		}

		public function set displaySource(displaySource:AbstractDisplaySource):void
		{
			_displaySource = displaySource;
		}
	}
}
