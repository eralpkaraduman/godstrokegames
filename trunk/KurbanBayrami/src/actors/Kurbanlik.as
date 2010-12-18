package actors 
{
	import actors.Haci;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class Kurbanlik extends FlxSprite 
	{
		private var stuckCounter:Number = 0;
		private var isCaught:Boolean = false;
		private var _haci:Haci;
		private var _justReleased:Boolean = false;;
		public var canMove:Boolean = true;
		//private var activeTimerLimit:Number = 4;
		//private var activeTimer:Number = 0;
		//protected var resting:Boolean = false;
		//protected var restTimer:Number = 0;
		//protected var restTimerLimit:Number = 2;
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
		
		//override public function 
		
		override public function update():void {
			acceleration.x = 0;
			
			if (!canMove) {
				super.update();
				return;
			}
			
			if (isCaught) {
				//dead = true;
				super.update();
				
				this.x = _haci.x;
				this.y = _haci.y - _haci.height/2;
				
				
				return;
			}
			
			
			
			var TurnBackLimits:Number = 25;
			if (this.x < 0 + TurnBackLimits) {
				movingLeft = false;
			}
			if (this.x > FlxG.width-TurnBackLimits) {
				movingLeft = true;
			}
			
			// MOVE MOVE.. GET TO THA CHOPPA
			if (_justReleased) {
				
				facing = (movingLeft)? RIGHT : LEFT;
				velocity.y = -acceleration.y * 0.21;
				velocity.x = -acceleration.x * 0.21;
				
				
				
				_justReleased = false;
				
			}else if (movingLeft) { //L
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
			
			
			super.update(); // is stuck sorgulanmadan önce, update etmek lazım ki, yeni yerine gitsin
			
			// "abi kurtar kendini" algoritması
			if (isStuck()) {
				
				
				if (stuckCounter > 10) {
					stuckCounter = 0;
				}else {
					stuckCounter++;
					return;
				}
				
				
				if (Math.random()*10>=3) { //walk // %30 ithimalle zıplar, yoksa öbür yöne yürür
					movingLeft = !movingLeft;
				}else { // jump
					canJump = true;
				}
			}
			
		}
		
		public function caught(haci:Haci):void
		{
			if (isCaught) return;
			
			_haci = haci;
			_haci.caughtSomething = this;
			//this.dead = true;
			isCaught = true;
		}
		
		public function released(haci:Haci):void
		{
			if (!isCaught) return;
			
			_haci = haci;
			_haci.caughtSomething = null;
			isCaught = false;
			
			//canJump = true;
			movingLeft = (_haci.facing == LEFT)? true : false;
			_justReleased = true;
			
			//acceleration = haci.acceleration;
		}
		
		protected function isStuck():Boolean
		{
			var ret:Boolean;
			if (lastPosition.x != this.x && lastPosition.y != this.y) {
			//if (Math.abs(lastPosition.x - this.x)< && lastPosition.y != this.y) {
			//if (lastPosition.x != this.x) {
				ret = false;
			}else {
				ret = true;
			}
			
			lastPosition.x = this.x;
			lastPosition.y = this.y;
			
			return ret;
		}
		
		
		
		
	}

}