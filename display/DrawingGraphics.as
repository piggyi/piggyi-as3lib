package com.happyelements.display
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author dongpiggyi
	 */
	public class DrawingGraphics extends AbstractDisplaySource
	{
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _color:uint;

		public function DrawingGraphics()
		{
			// set default value
			_x = 0;
			_y = 0;
			_width = 0;
			_height = 0;
		}

		override public function drawToStage(canvas:BitmapData, windowRect:Rectangle, globalX:Number, globalY:Number):void
		{
			globalX += _x;
			globalY += _y;
			var tmpBitmapData:BitmapData = new BitmapData(_width, _height, true, _color | 0xFF000000);
			canvas.copyPixels(tmpBitmapData, new Rectangle(0, 0, _width, _height), new Point(globalX, globalY));
		}

		public function drawRect(x:Number, y:Number, width:Number, height:Number, color:uint):void
		{
			_x = x;
			_y = y;
			_width = width;
			_height = height;
			_color = color;

			this.width = width;
			this.height = height;
		}

		override public function getOwnRect():Rectangle
		{
			var ownRect:Rectangle = new Rectangle(_x, _y, _width, _height);

			return ownRect;
		}
	}
}
