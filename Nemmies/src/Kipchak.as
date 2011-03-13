package  
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class Kipchak extends FlxSprite 
	{
		static private const MAX_VEL_X_NORMAL:Number = 40;
		static private const MAX_VEL_X_CROUCH:Number = 15;
		private var _rectC:FlxRect;
		private var canCrouchUp:Boolean = true;
		protected var canWalk:Boolean = true;
		public var crouch:Boolean = false;
		protected var _attack_counter:Number = 0;
		protected var bulletsInGame:Array = new Array();
		protected var tileMap:FlxTilemap;
		
		public function Kipchak(_gfx:Class,_x:Number=0, _y:Number = 0,rectC:FlxRect=null,spriteWH:Point=null) 
		{
			super(_x, _y);
			_rectC = rectC;
			
			if (!spriteWH) spriteWH = new Point(16, 16);
			
			loadGraphic(_gfx, true, true, spriteWH.x, spriteWH.y);
			maxVelocity.x = MAX_VEL_X_NORMAL;
			maxVelocity.y = 200;
			acceleration.y = 200;
			drag.x = maxVelocity.x * 4;
			
			//offset = new FlxPoint(rectC.x, rectC.y);
			//width = rectC
			updateRect(_rectC,true);
			
		}
		
		protected function updateRect(rect:FlxRect,firsttime:Boolean = false):void {
			
			if (firsttime) {
				offset.x = rect.x;
				offset.y = rect.y;
				width = rect.width;
				height = rect.height;
				return;
			}
				
			//_rect = new FlxRect(rect.x, rect.y, rect.width, rect.height);
			
			
			if (rect.x != _rectC.x) offset.x = rect.x;
			if (rect.y != _rectC.y) offset.y = rect.y;
			if (rect.width != _rectC.width) width = rect.width;
			if(rect.height != _rectC.height) height = rect.height;
			
			_rectC = rect;
			
			
		}
		
		protected function handleUserInput():void {
			
			if (_attack_counter > 0) {
				_attack_counter = -FlxG.elapsed * 3;
			}
			
			
			
			// crouch? ///////////////////////////
			var crouchWas:Boolean = crouch;
			
			if (onFloor) {
				crouch = FlxG.keys.DOWN;
			}else {
				crouch = false;
			}
			
			if (crouchWas && !canWalk) {
				crouch = true;
				//canWalk = true;
			}
			///////////////////////////////////////
			
			
			
			if (crouch) {
				maxVelocity.x = MAX_VEL_X_CROUCH;
			}else {
				maxVelocity.x = MAX_VEL_X_NORMAL;
			}
			
			if (FlxG.keys.justPressed("C") && _attack_counter <= 0 /*&& !crouch*/) {
				shoot(facing,x,y);
			}
			
			
			
			acceleration.x = 0;
			if (FlxG.keys.LEFT) {
				facing = LEFT;
				acceleration.x = -maxVelocity.x * 4;
				
			}else if (FlxG.keys.RIGHT) {
				facing = RIGHT;
				acceleration.x = maxVelocity.x * 4;
			}
			if ( (FlxG.keys.justPressed("X")|| FlxG.keys.justPressed("UP"))  && onFloor) {
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