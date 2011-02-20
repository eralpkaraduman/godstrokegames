package  
{
	import org.flixel.FlxState;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class ConnectionState extends FlxState 
	{
		
		public function ConnectionState() 
		{
			super();
			
		}
		
		override public function create():void {
			
			MultiplayManager.connect();
			
			
		}
		
	}

}