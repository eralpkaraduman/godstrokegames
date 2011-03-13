package 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxU;
	
	/**
	* ...
	* @author GodStroke
	*/
	public class Main extends FlxGame 
	{
		[SWF(width="480", height="320", backgroundColor="0x626c46",frameRate="60")]
		[Frame(factoryClass="Preloader")]
		
		public function Main():void 
		{
			
			
			super(240, 160, IntroState, 2);
			
			useDefaultHotKeys = false;
		}
		
	}
	
}