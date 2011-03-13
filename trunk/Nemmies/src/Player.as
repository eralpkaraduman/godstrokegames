package  
{
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class Player extends Kipchak 
	{
		{[Embed(source = '../gfx/spriteSheet_wCrouchWalk.png')]}private var kipchak_sprite:Class;
		private var crouched_down:Boolean = false;
		private var crouched_up:Boolean = true;
		private var crouch_up_complete:Boolean = true;
		private var jump_complete:Boolean = true;
		private var in_air_time:Number = 0;
		private var crouch_down_complete:Boolean = true;
		
		public function Player(_x:Number=0, _y:Number = 0) 
		{
			//loadGraphic(kipchak_sprite, true, true, 16, 16);
			super(kipchak_sprite, _x, _y, new Rectangle(5, 5, 16, 16));
			width = 6;
			height = 11;
			addAnimation("run", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 14,true);
			addAnimation("idle", [0], 14,false);
			addAnimation("jump", [13], 14, false);
			addAnimation("crouch_down", [0,14,15,16], 14, false);
			addAnimation("crouch_up", [16, 15, 14, 0], 14, false);
			addAnimation("crouch_walk", [16, 17, 18, 19], 6, true);
			addAnimation("crouch_idle", [16],14 ,false);
			
			addAnimationCallback(animCallBack);
			
			
		}
		
		private function animCallBack(name:String,fr:uint,fr_id:uint):void 
		{
			if (name == "crouch_up" && fr_id == 0) {
				crouch_up_complete = true;
			}else if (name == "crouch_down" && fr_id==16) {
				crouch_down_complete = true;
			}
		}
		
		override public function update():void {
			
			handleUserInput();
			
			if (!onFloor) {
				play("jump"); /*trace("60");*/
				jump_complete = false;
				in_air_time += FlxG.elapsed;
				crouch_up_complete = true;
				
				
				
			}else {
				
				if (!jump_complete) {
					
					if (in_air_time>0.6 &&!crouch) {
						crouch_up_complete = false;
						play("crouch_up", true); /*trace("71");*/
					}
				}
				
				if (crouch) {
					if (!crouched_down) {
						crouch_down_complete = false;
						play("crouch_down",true); /*trace("91");*/
						crouched_down = true;
						crouched_up = false;
					}
					
					if (velocity.x != 0) {
						play("crouch_walk"); /*trace("126");*/
					}else {
						if(crouch_down_complete)play("crouch_idle"); /*trace("128");*/
					}
					
				}else if(!crouch){
					if (!crouched_up) {
						crouch_up_complete = false;
						play("crouch_up",true); /*trace("99");*/
						crouched_up = true;
						crouched_down = false;
					}else {
						if (velocity.x == 0) {
							if(crouch_up_complete)play("idle"); /*trace("107");*/
						}else {
							play("run"); /*trace("110");*/
							crouch_up_complete = true;
						}
					}
					
				}
				
				jump_complete = true;
				in_air_time = 0;
			}
			
			// fixes
			if (crouch && onFloor && velocity.x != 0) {
				crouch_down_complete = true;
				crouch_up_complete = true;
			}
			
			super.update();
			
			//trace(velocity.y);
		}
		
		
		
	}

}