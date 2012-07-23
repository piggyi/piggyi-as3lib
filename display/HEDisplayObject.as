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
		private var _globalRect:Rectangle;
		
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

		public function get displaySource():AbstractDisplaySource
		{
			return _displaySource;
		}

		public function set displaySource(displaySource:AbstractDisplaySource):void
		{
			_displaySource = displaySource;
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
		// 获取显示对象在全局的位置，未计算内部图形偏移量
		private function getGlobalPosition():Point
		{
			var currentDO:HEDisplayObject = this;
			var position:Point = new Point();

			while (!(currentDO is HEStage))
			{
				position.x += currentDO.x;
				position.y += currentDO.y;

				currentDO = currentDO.parent;
			}

			return position;
		}

		// 获取显示对象在全局的矩形位置，计算了内部图形偏移量
		public function getGlobalRect():Rectangle
		{
			if (!_globalRect)
			{
				_globalRect = new Rectangle();
			}
			_globalRect.x += displaySource.ownRect.x;
			_globalRect.y += displaySource.ownRect.y;
			_globalRect.width = displaySource.ownRect.height;
			_globalRect.height = displaySource.ownRect.height;
			
			return _globalRect.clone();
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
				calculateSize();
			}
		}

		private function calculateSize():void
		{
			width = displaySource.width;
			height = displaySource.height;
		}

		private function _draw(canvas:BitmapData, rect:Rectangle):void
		{
			var globalRect:Point = getGlobalPosition();
			var x:Number = globalRect.x;
			var y:Number = globalRect.y;

			_displaySource.drawToStage(canvas, rect, x, y);
		}

		public function toString():String
		{
			return "[HEDisplayObject]";
		}
	}
}
