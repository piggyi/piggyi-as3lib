package com.happyelements.display
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import com.happyelements.display.AbstractDisplaySource;

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

		override public function get ownRect():Rectangle
		{
			ownRect = new Rectangle(_x, _y, _width, _height);
			
			return ownRect;
		}


	}
}
