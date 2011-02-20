package  
{
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class Crate extends FlxSprite 
	{
		[Embed(source = '../gfx/crate.png')] private var crate_gfx:Class;
		
		public function Crate(_x:Number, _y:Number) 
		{
			super(_x,_y);
			loadGraphic(crate_gfx, false, true, 8, 8);
			
			acceleration.y = 160;
			drag.x = 50;
		}
		
	}

}