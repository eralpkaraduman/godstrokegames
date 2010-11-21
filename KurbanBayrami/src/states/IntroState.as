package states 
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class IntroState extends FlxState 
	{
		
		public function IntroState() 
		{
			
		}
		
		override public function create():void {
			add(new FlxText(0, 0, 100, "Kurban Bayramı"));
		}
		
	}

}