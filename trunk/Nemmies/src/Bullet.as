package  
{
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class Bullet extends FlxSprite 
	{
		public var retired:Boolean = false;
		
		public function Bullet(_x:Number=0, _y:Number=0,color:uint=0xff000000) 
		{
			super(_x, _y);
			createGraphic(1, 1, color);
		}
		
		public function go(shooter:FlxSprite):void {
			
			retired = false;
			dead = false;
			visible = true;
			this.x = shooter.x + ((shooter.facing == LEFT) ? 0 : shooter.width);
			this.y = shooter.y + 2;
			velocity.x = 200 * ((shooter.facing == LEFT) ? -1 : 1);
			
		}
		
		
		
		//
		override public function hitLeft(Contact:FlxObject,Velocity:Number):void
		{
			super.hitLeft(Contact, Velocity);
			retire(Contact,Velocity);
		}
		
		override public function hitBottom(Contact:FlxObject,Velocity:Number):void
		{
			super.hitLeft(Contact, Velocity);
			retire(Contact,Velocity);
		}
		
		override public function hitRight(Contact:FlxObject,Velocity:Number):void
		{
			super.hitLeft(Contact, Velocity);
			retire(Contact,Velocity);
		}
		
		override public function hitTop(Contact:FlxObject,Velocity:Number):void
		{
			super.hitLeft(Contact, Velocity);
			retire(Contact,Velocity);
		}
		//
		
		
		private function retire(contact:FlxObject, velocity:Number):void 
		{
			retired = true;
			dead = true;
			visible = false;
			velocity = 0;
		}
		
		
		
		
	}

}