package com.happyelements.display
{
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
			child.setStage(stage);
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
			return child.parent ? true : false;
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
				throw new Error("RemoveChild Error: Child " + child.debugName + " is not in the " + this.debugName);
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
				// /TODO throw get child at error
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
			
			for each (var child:HEDisplayObject in _childrenList)
			{
				child.update(canvas, rect);

				// calculateChildSize(child);
			}
		}

		private function calculateChildSize(child:HEDisplayObject):void
		{
			var childRect:Rectangle = child.getRect(this);
			if (childRect.x < 0)
			{
			}
		}

		override public function toString():String
		{
			return "[HEDisplayObjectContainer]";
		}
	}
}
