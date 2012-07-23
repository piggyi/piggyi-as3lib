package com.happyelements.display
{
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	/**
	 * @author dongpiggyi
	 */
	public class AbstractDisplaySource
	{
		private var _width:Number;
		private var _height:Number;
		private var _ownRect:Rectangle;
		
		public function drawToStage(canvas:BitmapData, windowRect:Rectangle, globalX:Number, globalY:Number):void
		{
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(height:Number):void
		{
			_height = height;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(width:Number):void
		{
			_width = width;
		}

		public function get ownRect():Rectangle
		{
			return _ownRect;
		}

		public function set ownRect(globalRect:Rectangle):void
		{
			_ownRect = globalRect;
		}
		
	}
}
