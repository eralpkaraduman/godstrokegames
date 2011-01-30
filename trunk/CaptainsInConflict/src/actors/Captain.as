package actors 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class Captain extends FlxSprite 
	{
		[Embed(source="../../gfx/blueCapSpriteSheet.png")] private var gfx_blueCaptain:Class;
		
		public function Captain(x:Number,y:Number) 
		{
			super(x, y);
			
			maxVelocity.x = 230;
			maxVelocity.y = 300;
			acceleration.y = 600;
			drag.x = maxVelocity.x * 8;
			
			offset.y = -2 + 108-90;
			offset.x = 13;
			
			loadGraphic(gfx_blueCaptain, true, true, 82, 108);
			width = 54;
			height = 90;
			addAnimation("idle", [0], 12, false);
			//addAnimation("walk", [1, 2, 3, 4, 5, 6, 7, 8], 12, true);
			addAnimation("walk", [1, 8, 7, 6, 5, 4, 3, 2], 12, true);
			
		}
		
		override public function update():void {
			acceleration.x = 0;
			
			if (FlxG.keys.LEFT) {
				acceleration.x = -drag.x;
				facing = LEFT;
			}else if (FlxG.keys.RIGHT) {
				acceleration.x = drag.x;
				facing = RIGHT;
			}
			
			if (FlxG.keys.SPACE && onFloor) {
				velocity.y = -(acceleration.y*0.51);
			}
			
			if (Math.abs(acceleration.x) > 0) {
				play("walk");
			}else {
				play("idle", true);
			}
			
			super.update();
			
		}
		
	}

}