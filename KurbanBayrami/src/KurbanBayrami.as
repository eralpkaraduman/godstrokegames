package 
{
	import actors.Koyun;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import org.flixel.FlxU;
	import states.CityState;
	import states.CollectState;
	import states.KillStage;
	import states.IntroState;
	
	
	/**
	* ...
	* @author eralp
	*/
	[SWF(width="720", height="240", backgroundColor="#000000",frameRate="60")]
	[Frame(factoryClass="Preloader")]
	public class KurbanBayrami extends FlxGame 
	{
		
		public function KurbanBayrami():void 
		{
			//60 20
			//super(60*6, 20*6,CityState,2);
			
			//FlxG.pa
			
			
			
			//super(60*6, 20*6,CollectState,2);
			//super(60*6, 20*6,KillStage,2);
			super(60*6, 20*6,IntroState,2);
		}
		
	}
	
}