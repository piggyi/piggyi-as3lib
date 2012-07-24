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
		private var _visible:Boolean;
		private var _parent:HEDisplayObjectContainer;
		internal var globalRect:Rectangle;
		// 对于添加到显示列表中的对象，此对象指向舞台根对象，否则为空指针
		private var _stage:HEStage;
		// 指向图形源信息抽象类[AbstractDisplaySource]的具体实现类，可能是图形、位图或是动画类
		private var _displaySource:AbstractDisplaySource;

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

		/* Public Getter and Setter */
		public function get width():Number
		{
			return _width;
		}

		public function set width(width:Number):void
		{
			// /TODO associate to scaleX
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(height:Number):void
		{
			// /TODO associate to scaleY
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

		public function get visible():Boolean
		{
			return _visible;
		}

		public function set visible(visible:Boolean):void
		{
			_visible = visible;
		}

		/* Public Methods*/
		// 获取显示对象在全局的位置，未计算内部图形偏移量
		public function getGlobalPosition():Point
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

		// 获取显示对象在全局的位置及宽高，计算了内部图形偏移量
		public function getGlobalRect():Rectangle
		{
			return globalRect.clone();
		}

		internal function setGlobalRect(globalRect:Rectangle):void
		{
			this.globalRect = globalRect;
		}

		public function getRect(targetCoordinateSpace:HEDisplayObject):Rectangle
		{
			var rect:Rectangle = new Rectangle();
			var globalRect:Rectangle = getGlobalRect();
			var targetGlobalPosition:Point = targetCoordinateSpace.getGlobalPosition();

			rect.x = globalRect.x - targetGlobalPosition.x;
			rect.y = globalRect.y - targetGlobalPosition.y;
			rect.width = globalRect.width;
			rect.height = globalRect.height;

			return rect;
		}

		public function get stage():HEStage
		{
			return _stage;
		}

		/**
		 * 使用internal访问控制符，是为了保证在引擎包内的类诸如HEDisplayObjectContainer及HEStage可以在添加子对象时设置舞台根对象
		 * 而外部继承HEDisplayObject的对象不可写stage，只能读取
		 */
		internal function setStage(stage:HEStage):void
		{
			_stage = stage;
		}

		/**
		 * 每次渲染时调用
		 * @param canvas  全局位图数据的引用
		 * @param rect    窗口位置，用来屏蔽窗口外的显示对象以及计算窗口边缘交集显示对象
		 */
		public function update(canvas:BitmapData, rect:Rectangle):void
		{
			if (displaySource)
			{
				_draw(canvas, rect);
				calculateSize();
				calculateGlobalRect();
			}
		}

		private function calculateGlobalRect():void
		{
			if (!globalRect)
			{
				globalRect = new Rectangle();
			}

			var ownRect:Rectangle = displaySource ? displaySource.getOwnRect() : new Rectangle();

			globalRect.x = getGlobalPosition().x + ownRect.x;
			globalRect.y = getGlobalPosition().y + ownRect.y;
			globalRect.width = displaySource.getOwnRect().width;
			globalRect.height = displaySource.getOwnRect().height;
		}

		internal function setWidth(width:Number):void
		{
			_width = width;
		}

		internal function setHeight(height:Number):void
		{
			_height = height;
		}

		public function toString():String
		{
			return "[HEDisplayObject]";
		}

		private function calculateSize():void
		{
			setWidth(displaySource.width);
			setHeight(displaySource.height);
		}

		private function _draw(canvas:BitmapData, rect:Rectangle):void
		{
			var globalRect:Point = getGlobalPosition();
			var x:Number = globalRect.x;
			var y:Number = globalRect.y;

			_displaySource.drawToStage(canvas, rect, x, y);
		}
	}
}
