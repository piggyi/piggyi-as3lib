package com.happyelements.display
{
	/**
	 * @author dongpiggyi
	 */
	public class HEStage extends HEDisplayObjectContainer
	{
		private static var _instance:HEStage;

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

	}
}
class HEStageEntranceClass
{
}
