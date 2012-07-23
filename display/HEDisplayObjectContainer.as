package com.happyelements.display
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	/**
	 * @author dongpiggyi
	 */
	public class HEDisplayObjectContainer extends HEDisplayObject
	{
		public var _childrenList:Vector.<HEDisplayObject>;

		public function HEDisplayObjectContainer()
		{
			super();
			_childrenList = new Vector.<HEDisplayObject>();
		}

		public function addChild(child:HEDisplayObject):HEDisplayObject
		{
			if (!childHasParent(child))
			{
				_childrenList.push(child);
				child.setStage(stage);
			}
			else if (_childrenList.indexOf(child) != -1)
			{
				setChildIndex(child, numChildren - 1);
			}
			else
			{
				child.parent.removeChild(child);
				_childrenList.push(child);
			}

			child.setParent(this);
			return child;
		}

		private function setChildIndex(child:HEDisplayObject, index:int):void
		{
			var preIndex:int = _childrenList.indexOf(child);
			_childrenList.splice(preIndex, 1);
			_childrenList.splice(index, 0, child);
		}

		private function childHasParent(child:HEDisplayObject):Boolean
		{
			return child.parent ? true:false;
		}

		public function removeChild(child:HEDisplayObject):HEDisplayObject
		{
			if (isChildIn(child))
			{
				var childIndex:int = _childrenList.indexOf(child);
				_childrenList.splice(childIndex, 1);
				child.setParent(null);
			}
			else
			{
				// /TODO throw remove child error
				throw new Error("RemoveChild Error: Child is not in the this container");
			}

			return child;
		}

		private function isChildIn(child:HEDisplayObject):Boolean
		{
			return child.parent == this;
		}

		public function get numChildren():int
		{
			return _childrenList.length;
		}

		public function getChildAt(index:int):HEDisplayObject
		{
			if (index > numChildren - 1)
			{
				// /TODO throw overflow error
				throw new Error();
			}
			else
			{
				return _childrenList[index];
			}
		}

		override public function update(canvas:BitmapData, rect:Rectangle):void
		{
			super.update(canvas, rect);

			// /TODO calculate container size after child added
			for each (var child:HEDisplayObject in _childrenList)
			{
				child.update(canvas, rect);
			}
			// calculateContainerGlobalRect();
		}

		override public function getGlobalRect():Rectangle
		{
            var displaySourceRect:Rectangle = new Rectangle();
            var ownRect:Rectangle = (displaySource != null) ? displaySource.getOwnRect() : new Rectangle();

            displaySourceRect.x = getGlobalPosition().x + ownRect.x;
            displaySourceRect.y = getGlobalPosition().y + ownRect.y;
            displaySourceRect.width = displaySource.getOwnRect().width;
            displaySourceRect.height = displaySource.getOwnRect().height;
			
			var rect:Rectangle = displaySourceRect;
			var tempChildRect:Rectangle;

			// 获取容器（包含子对象及自身图形）的全局位置，计算了图形内偏移量
			for each (var childForPosition:HEDisplayObject in _childrenList)
			{
				tempChildRect = childForPosition.getGlobalRect();
				if (rect.x > tempChildRect.x)
				{
					rect.x = tempChildRect.x;
				}

				if (rect.y > tempChildRect.y)
				{
					rect.y = tempChildRect.y;
				}
			}
			
			rect.width = rect.width + displaySourceRect.x - rect.x;
			rect.height = rect.height + displaySourceRect.y - rect.y;

			for each (var childForSize:HEDisplayObject in _childrenList)
			{
				tempChildRect = childForSize.getGlobalRect();
				if (tempChildRect.width + tempChildRect.x - rect.x > rect.width)
				{
					rect.width = tempChildRect.width + tempChildRect.x - rect.x;
				}

				if (tempChildRect.height + tempChildRect.y - rect.y > rect.height)
				{
					rect.height = tempChildRect.height + tempChildRect.y - rect.y;
				}
			}

			setGlobalRect(rect);
			return rect;
		}

		private function calculateContainerGlobalRect():void
		{
			var rect:Rectangle = getGlobalRect();
			var tempChildRect:Rectangle;

			// 获取容器（包含子对象及自身图形）的全局位置，计算了图形内偏移量
			for each (var childForPosition:HEDisplayObject in _childrenList)
			{
				tempChildRect = childForPosition.getGlobalRect();
				if (rect.x > tempChildRect.x)
				{
					rect.x = tempChildRect.x;
				}

				if (rect.y > tempChildRect.y)
				{
					rect.y = tempChildRect.y;
				}
			}

			rect.width = rect.width + getGlobalRect().x - rect.x;
			rect.height = rect.height + getGlobalRect().y - rect.y;

			for each (var childForSize:HEDisplayObject in _childrenList)
			{
				tempChildRect = childForSize.getGlobalRect();
				if (tempChildRect.width + tempChildRect.x - rect.x > rect.width)
				{
					rect.width = tempChildRect.width + tempChildRect.x - rect.x;
				}

				if (tempChildRect.height + tempChildRect.y - rect.y > rect.height)
				{
					rect.height = tempChildRect.height + tempChildRect.y - rect.y;
				}
			}

			setGlobalRect(rect);
			setWidth(rect.width);
			setHeight(rect.height);
		}

		override public function toString():String
		{
			return "[HEDisplayObjectContainer]";
		}
	}
}
