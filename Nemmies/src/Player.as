package  
{
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import org.flixel.FlxG;
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class Player extends Kipchak 
	{
		{[Embed(source = '../gfx/kipchak.png')]}private var kipchak_sprite:Class;
		
		
		public function Player(_x:Number=0, _y:Number = 0) 
		{
			//loadGraphic(kipchak_sprite, true, true, 16, 16);
			super(kipchak_sprite, _x, _y, new Rectangle(1, 5, 16, 16));
			width = 14;
			height = 11;
			addAnimation("run", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 14,true);
			addAnimation("idle", [0], 0,false);
			addAnimation("jump", [13], 8,false);
			
		}
		
		override public function update():void {
			handleUserInput();
			
			if (velocity.y != 0) {
				play("jump");
			}else {
				if (velocity.x == 0) {
					play("idle");
				}else {
					play("run");
				}
			}
			super.update();
			
			
			
			
		}
		
	}

}