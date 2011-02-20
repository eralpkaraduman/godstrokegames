package  
{
	import flash.accessibility.Accessibility;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class PlayState extends FlxState 
	{
		[Embed(source = '../gfx/map.png')]private var gfx_map:Class;
		private var player:Player;
		private var playerNames:Array = new Array();
		
		public function PlayState() 
		{
			
		}
		
		override public function create():void {
			var level:FlxTilemap = new FlxTilemap();
			level.auto = FlxTilemap.AUTO;
			level.loadMap(FlxTilemap.pngToCSV(gfx_map), FlxTilemap.ImgAuto);
			add(level);
			
			player = new Player();
			player.x = 15;
			player.y = 15;
			add(player);
			//playerNames[]
			
			
			FlxG.follow(player, 2);
			FlxG.followAdjust(1, 0);
			FlxG.followBounds(0, 0, level.width, level.height);
		}
		
		override public function update():void {
			collide();
			super.update();
		}
		
	}
	
	

}