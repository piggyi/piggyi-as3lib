package com.happyelements.display
{
	/**
	 * @author dongpiggyi
	 */
	public class HEStage extends HEDisplayObjectContainer
	{
		private static var _instance:HEStage;
		private var _stageWidth:Number;
		private var _stageHeight:Number;

		public function HEStage(entranceClass:HEStageEntranceClass)
		{
			super();
		}

		public static function getInstance():HEStage
		{
			if (!HEStage._instance)
			{
				HEStage._instance = new HEStage(new HEStageEntranceClass());
			}

			return HEStage._instance;
		}

		override public function toString():String
		{
			return "[HEStage]";
		}

		public function get stageWidth():Number
		{
			return _stageWidth;
		}

		public function set stageWidth(stageWidth:Number):void
		{
			_stageWidth = stageWidth;
		}

		public function get stageHeight():Number
		{
			return _stageHeight;
		}

		public function set stageHeight(stageHeight:Number):void
		{
			_stageHeight = stageHeight;
		}

	}
}

class HEStageEntranceClass
{
}
