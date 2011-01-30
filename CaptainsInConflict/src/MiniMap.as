package  
{
	import flash.display.Bitmap;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class MiniMap extends FlxGroup 
	{
		[Embed(source="../gfx/map.png")] private var gfx_map:Class;
		private var player:FlxSprite;
		private var mmap:FlxSprite;
		public function MiniMap() 
		{
			player = new FlxSprite(0, 0);
			player.createGraphic(3, 6, 0xffff0000);
			player.scrollFactor = new FlxPoint(0, 0);
			add(player);
			
			
			mmap = new FlxSprite(FlxG.width - 125, FlxG.height - 85);
			mmap.loadGraphic(gfx_map);
			mmap.alpha = .4
			mmap.scale = new FlxPoint(3, 3);
			mmap.scrollFactor = new FlxPoint(0, 0);
			add(mmap);
			
			updatePos(new FlxPoint(0,0));
		}
		
		public function updatePos(p:FlxPoint) {
			p.x = p.x / 54 * 3;
			p.y = (p.y / 54 * 3)-1;
			
			player.x = mmap.x + p.x -50;
			player.y = mmap.y + p.y -30;
		}
		
	}

}