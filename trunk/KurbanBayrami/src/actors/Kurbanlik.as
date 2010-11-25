package actors 
{
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class Kurbanlik extends FlxSprite 
	{
		public var canMove:Boolean = true;
		private var activeTimerLimit:Number = 4;
		private var activeTimer:Number = 0;
		protected var resting:Boolean = false;
		protected var restTimer:Number = 0;
		protected var restTimerLimit:Number = 2;
		protected var canJump:Boolean; //see: create()
		protected var movingLeft:Boolean; //see: create()
		
		
		protected var lastPosition:Point = new Point(0, 0);
		
		public function Kurbanlik() 
		{
			
		}
		
		protected function create():void {
			maxVelocity.x = 50;
			acceleration.y = 300;
			drag.x = maxVelocity.x * 4; // deceleration - sliding to a stop
			movingLeft = trueOrFalse();
			canJump = trueOrFalse();
		}
		
		protected function trueOrFalse():Boolean
		{
			return Math.round(Math.random() * 1) == 0 ? true : false;
		}
		
		
		
		override public function update():void {
			acceleration.x = 0;
			
			if (!canMove) {
				super.update();
				return;
			}
			
			var TurnBackLimits:Number = 25;
			if (this.x < 0 + TurnBackLimits) {
				movingLeft = false;
			}
			if (this.x > FlxG.width-TurnBackLimits) {
				movingLeft = true;
			}
			
			
			
			restTimerLimit = (2 + Math.random() * 2); // time to spend on resting
			if (restTimer > restTimerLimit) { 
				restTimer = 0;
				restTimer += FlxG.elapsed;
				activeTimer = 0;
				super.update();
				return; // <-- do you see this? This is a fucking RETURN STATEMENT
			}else {
				activeTimerLimit = (2 + Math.random() * 4);
				activeTimer += FlxG.elapsed;
				restTimer = 0;
			}
			
			
			
			if (movingLeft) { //L
				acceleration.x -= drag.x;
				facing = RIGHT;
			}else { //R
				acceleration.x += drag.x;
				
				facing = LEFT;
			}
			
			if (onFloor) {
				if (canJump) {
					
					velocity.y = -acceleration.y * 0.42; // hop!
					canJump = false;
				}
			}
			
			if (isStuck()) {
				//choose
				if (trueOrFalse()) { //walk
					movingLeft = !movingLeft;
				}else { // jump
					canJump = true;
				}
			}
			
			if (activeTimer > activeTimerLimit) {
				resting = true;
			}
			
			super.update();
			
			
		}
		
		protected function isStuck():Boolean
		{
			if (lastPosition.x != this.x || lastPosition.y != this.y) {
				
				lastPosition.x = this.x;
				lastPosition.y = this.y;
				return false;
				
				
			}else {
				
				lastPosition.x = this.x;
				lastPosition.y = this.y;
				return true;
			}
		}
		
	}

}