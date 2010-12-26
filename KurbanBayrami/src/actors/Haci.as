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
		private var climbSpeed:Number = 0.8;
		private var canAirJump:Boolean = false;
		private var airJumping:Boolean = false;
		private var speedX:Number;
		
		public function Haci(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(gfx_haci, false, true, 8, 12);
			height = 12;
			width = 8;
			
			maxVelocity.x = 120;
			
			maxVelocity.y = 140;
			
			acceleration.y = 400; // gravity
			
			drag.x = maxVelocity.x * 4 // deceleration - sliding to a stop
			speedX = 15;
			
			//drag.x = maxVelocity.x / 4 // deceleration - sliding to a stop
			//drag.y = maxVelocity.y * 4;
			
			//FlxG.keys.reset();
			//FlxG.keys.update();
		}
		
		override public function update():void {
			acceleration.x = 0;
			//acceleration.y = 0;
			
			
			
			if (FlxG.keys.LEFT) {
				//acceleration.x -= drag.x;
				//acceleration.x -= speedX;
				velocity.x -= speedX;
				facing = LEFT;
			}else if (FlxG.keys.RIGHT) {
				//acceleration.x += drag.x;
				//acceleration.x += speedX;
				velocity.x += speedX;
				facing = RIGHT;
			}
			
			// ladder& climb
			if (FlxG.keys.UP && canClimb) {
				//facing = UP;
				airJumping = false;
				y -= climbSpeed;
				//velocity.x = 0;
			}else if (FlxG.keys.DOWN && canClimb) {
				//facing = UP;
				airJumping = false;
				y += climbSpeed;
				//velocity.x = 0;
			}
			
			if (airJumping) {
				var rot_spd:uint = 5;
				//angle =  angle + ( (facing == LEFT)? -1 : 1 ) * rot_spd;
				
				FlxG.log("velocity.x" + velocity.x);
				//angle +=  rot_spd * ( -velocity.x*0.05 );
				angle +=  ( (facing == LEFT)? -1 : 1 ) * rot_spd;
			}else {
				angle = 0;
			}
			
			if (onFloor) 
			//if (true) 
			{
				if (FlxG.keys.justPressed("X")) {
				//if (FlxG.keys.X) {
					//velocity.y = -acceleration.y * 0.51;
					velocity.y = -acceleration.y * 0.51;
					canAirJump = true;
					// play jump
				}else if (velocity.x > 0) {
					// play walk
				}else if (velocity.x < 0) {
					// play walk back
				}else {
					//play idle
				}
				
				
				airJumping = false;
				
			}else if (velocity.y < 0) {
				// play jump
				
				
				// airjump
				//if (canAirJump && FlxG.keys.justPressed("X") && Math.abs(velocity.x) > 0) {
				if (canAirJump && FlxG.keys.justPressed("X") && Math.abs(velocity.x) > 0) {
					
					velocity.y = -acceleration.y * 0.51;
					//acceleration.x = acceleration.x + ( (facing == LEFT)? -1 : 1 )*drag.x*2;
					//acceleration.x += acceleration.x;
					airJumping = true;
					// play airjump
					
					canAirJump = false;
				}
				
			}else {
				
				canAirJump = false;
				// play fall
			}
			
			FlxG.keys.update();
			super.update();
			
			if ( airJumping && Math.abs(angle) > 360) {
				airJumping = false;
			}
			
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
				airJumping = false;
				canAirJump = false;
			}else {
				acceleration.y = 300;
			}
			_canClimb = value;
		}
		
		
		
	}

}