package  
{
	import flash.geom.Rectangle;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class Kipchak extends FlxSprite 
	{
		public var crouch:Boolean = false;
		protected var _attack_counter:Number = 0;
		protected var bulletsInGame:Array = new Array();
		
		public function Kipchak(_gfx:Class,_x:Number=0, _y:Number = 0,rect:Rectangle=null) 
		{
			super(_x, _y);
			
			if (!rect) rect = new Rectangle(0, 0, 16, 16);
			
			loadGraphic(_gfx, true, true, rect.width, rect.height);
			maxVelocity.x = 80;
			maxVelocity.y = 200;
			acceleration.y = 200;
			drag.x = maxVelocity.x * 4;
			offset = new FlxPoint(rect.x, rect.y);
			
		}
		
		protected function handleUserInput():void {
			
			if (_attack_counter > 0) {
				_attack_counter = -FlxG.elapsed * 3;
			}
			
			crouch = FlxG.keys.DOWN;
			
			if (FlxG.keys.justPressed("C") && _attack_counter <= 0 && !crouch) {
				shoot(facing,x,y);
			}
			
			
			
			acceleration.x = 0;
			if (FlxG.keys.LEFT && !crouch) {
				facing = LEFT;
				acceleration.x = -maxVelocity.x * 4;
				
			}else if (FlxG.keys.RIGHT && !crouch) {
				facing = RIGHT;
				acceleration.x = maxVelocity.x * 4;
			}
			if (FlxG.keys.X && onFloor) {
				velocity.y = -maxVelocity.y / 2;
				crouch = false;
			}
			
			
		}
		
		protected function handleServerInput(input:ServerInput):void { // re-do this
			/*
			if (_attack_counter > 0) {
				_attack_counter = -FlxG.elapsed * 3;
			}*/
			
			if (input.SHOOT && ! crouch) {
				shoot(facing,x,y);
			}
			
			acceleration.x = 0;
			if (input.MOVING_LEFT ) {
				facing = LEFT;
				acceleration.x = -maxVelocity.x * 4;
				
			}else if (input.MOVING_RIGHT) {
				facing = RIGHT;
				acceleration.x = maxVelocity.x * 4;
			}
			
			if (input.JUMP) {
				velocity.y = -maxVelocity.y / 2;
			}
			
		}
		
		private function shoot(facing:uint, x:Number, y:Number):void 
		{
			var b2go:Bullet;
			
			for (var i:int = 0 ; i < bulletsInGame.length ; i++ ) {
				var b:Bullet = bulletsInGame[i] as Bullet;
				if (b.retired) {
					b2go = b;
					break;
				}
			}
			
			if (!b2go) {
				b2go = new Bullet();
				FlxG.state.add(b2go);
				bulletsInGame[bulletsInGame.length] = b2go;
			}
			
			b2go.go(this);
			//trace("pew " + bulletsInGame.length);
		}
		
		
		
	}

}