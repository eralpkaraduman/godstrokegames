package actors 
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class Haci extends FlxSprite 
	{
		[Embed(source="../../gfx/haci.png")] private var gfx_haci:Class;
		
		public var caughtSomething:FlxObject = null;
		
		public function Haci(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(gfx_haci, false, true, 8, 12);
			maxVelocity.x = 50;
			acceleration.y = 300;
			drag.x = maxVelocity.x*4; // deceleration - sliding to a stop
		}
		
		override public function update():void {
			acceleration.x = 0;
			
			if (FlxG.keys.LEFT) {
				acceleration.x -= drag.x;
				facing = LEFT;
			}
			if (FlxG.keys.RIGHT) {
				acceleration.x += drag.x;
				facing = RIGHT;
			}
			
			
			if (onFloor) 
			{
				if (FlxG.keys.justPressed("X")) {
					//velocity.y = -acceleration.y * 0.51;
					velocity.y = -acceleration.y * 0.42;
					// play jump
				}else if (velocity.x > 0) {
					// play walk
				}else if (velocity.x < 0) {
					// play walk back
				}else {
					//play idle
				}
			}else if (velocity.y < 0) {
				// play jump
			}else {
				// play fall
			}
			
			
			
			super.update();
			
			if (!onScreen()) {
				if (this.x > FlxG.width) {
					FlxG.state["haciLeftTheMap"](true);
					return;
				}else if(this.x<0){
					FlxG.state["haciLeftTheMap"](false);
					return;
				}
			}
			
			
			
			
		}
		
		
		
	}

}