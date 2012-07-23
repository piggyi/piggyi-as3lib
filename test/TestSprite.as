package com.happyelements.test
{
	import flash.display.Sprite;

	/**
	 * @author dongpiggyi
	 */
	public class TestSprite extends Sprite
	{
		public function TestSprite()
		{
		}
		
		public function drawRect(x:Number, y:Number, width:Number, height:Number, color:uint):void
		{
			graphics.beginFill(color);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();
		}
		
	}
}
