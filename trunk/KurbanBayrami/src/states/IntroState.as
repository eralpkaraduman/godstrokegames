package states 
{
	import actors.Koyun;
	import org.flixel.FlxG;
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
			/*
			for (var i:int = 0; i < 8; i++) 
			{
				RAM.sacrificables.push(new Koyun());
			}
			*/
			
			FlxG.state = new CityState();
		}
		
	}

}