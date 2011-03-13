package  
{
	import flash.accessibility.Accessibility;
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
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
		private var level:FlxTilemap;
		private var crateGroup:FlxGroup;
		
		public function PlayState() 
		{
			
		}
		
		override public function create():void {
			level = new FlxTilemap();
			level.auto = FlxTilemap.AUTO;
			level.loadMap(FlxTilemap.pngToCSV(gfx_map), FlxTilemap.ImgAuto);
			add(level);
			
			
			crateGroup = new FlxGroup();
			var crateKey:uint = 0xffba00;
			var spawnPointKey:uint = 0xFF00E1;
			
			var cratePosArray:Array = PNGTileMap.parse(gfx_testMap, crateKey, new Point(level.width, level.height),new Point(8,8));
			
			var spawnPointPosArray:Array = PNGTileMap.parse(gfx_testMap, spawnPointKey, new Point(level.width, level.height),new Point(8,8));
			
			for (var i:uint = 0; i < cratePosArray.length ; i++ ) {
				var pn:Point = cratePosArray[i];
				var crate:Crate = new Crate(pn.x, pn.y);
				crateGroup.add(crate);
			}
			add(crateGroup);
			
			var spawnPoint:Point = spawnPointPosArray[0];
			//trace("a",spawnPoint);
			//trace("b",spawnPointPosArray);
			
			if (!spawnPoint) spawnPoint = new Point(15, 15);
			
			player = new Player(0,0,level);
			player.x = spawnPoint.x;
			player.y = spawnPoint.y;
			add(player);
			//playerNames[]
			
			
			FlxG.follow(player, 4);
			FlxG.followAdjust(0, 0);
			FlxG.followBounds(0, 0, level.width, level.height);
		}
		
		override public function update():void {
			
			
			
			FlxU.collide(player, crateGroup);
			FlxU.collide(crateGroup,level);
			FlxU.collide(level, player);
			
			
			super.update();
			
			//collide();
			
			
			//collide();
		}
		
		
	}
	
	

}