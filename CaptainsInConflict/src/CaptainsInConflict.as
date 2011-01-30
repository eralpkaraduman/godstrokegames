package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import states.IntroState;
	
	
	/**
	* ...
	* @author eralp
	*/
	[SWF(width="700", height="600", backgroundColor="0xFFFFFF",frameRate="60")]
	[Frame(factoryClass="Preloader")]
	
	public class CaptainsInConflict extends FlxGame 
	{
		
		public function CaptainsInConflict():void 
		{
			super(700, 600, IntroState, 1);
		}
		
	}
	
}