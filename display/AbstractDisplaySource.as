package com.happyelements.display
{
	import flash.geom.Rectangle;
	import flash.display.BitmapData;

	/**
	 * @author dongpiggyi
	 * 
	 * 该类为显示图像的源信息抽象类，具体实现类可以是可绘图形、位图或是动画
	 * 用来辅助计算显示对象的getGlobalRect()中图形内部的偏移量
	 * 每次渲染时图形的绘制在该类的实现中完成，从而分离职责
	 */
	public class AbstractDisplaySource
	{
		private var _width:Number;
		private var _height:Number;

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

		public function getOwnRect():Rectangle
		{
			return null;
		}
	}
}
