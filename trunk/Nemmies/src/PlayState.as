package  
{
	import flash.accessibility.Accessibility;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import com.godstroke.flixel.PNGTileMap;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class PlayState extends FlxState 
	{
		[Embed(source = '../gfx/map.png')]private var gfx_map:Class;
		[Embed(source = '../gfx/objectLayout.png')] private var gfx_testMap:Class;
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
			
			
			
			var crateKey:uint = 0xffba00;
			var cratePosArray:Array = PNGTileMap.parse(gfx_testMap, crateKey, new Point(level.width, level.height),new Point(8,8));
			for (var i:uint = 0; i < cratePosArray.length ; i++ ) {
				var pn:Point = cratePosArray[i];
				var crate:Crate = new Crate(pn.x, pn.y);
				add(crate);
			}
			
			
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
			
			super.update();
			
			collide();
		}
		
	}
	
	

}