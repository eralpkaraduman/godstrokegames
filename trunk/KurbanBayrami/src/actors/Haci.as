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
		private var _canClimb:Boolean = false;
		private var climbSpeed:Number = 0.5;
		
		public function Haci(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(gfx_haci, false, true, 8, 12);
			height = 12;
			width = 8;
			
			maxVelocity.x = 50;
			//maxVelocity.y = 400;
			acceleration.y = 300;
			drag.x = maxVelocity.x * 4; // deceleration - sliding to a stop
			//drag.y = maxVelocity.y * 4;
		}
		
		override public function update():void {
			acceleration.x = 0;
			//acceleration.y = 0;
			
			if (FlxG.keys.LEFT) {
				acceleration.x -= drag.x;
				facing = LEFT;
			}
			if (FlxG.keys.RIGHT) {
				acceleration.x += drag.x;
				facing = RIGHT;
			}
			// ladder& climb
			if (FlxG.keys.UP && canClimb) {
				//facing = UP;
				y -= climbSpeed;
			}
			if (FlxG.keys.DOWN && canClimb) {
				//facing = UP;
				y += climbSpeed;
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
		
		public function get canClimb():Boolean { return _canClimb; }
		
		public function set canClimb(value:Boolean):void 
		{
			if (value) {
				acceleration.y = 0;
				velocity.y = 0;
			}else {
				acceleration.y = 300;
			}
			_canClimb = value;
		}
		
		
		
	}

}