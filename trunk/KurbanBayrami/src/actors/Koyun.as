package actors 
{
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class Koyun extends Kurbanlik 
	{
		[Embed(source="../../gfx/koyun.png")] private var gfx:Class;
		
		public function Koyun() 
		{
			loadGraphic(gfx, false, true);
			create();
		}
		
		override public function toString():String {
			return "actors.Koyun";
		}
		
		
	}

}