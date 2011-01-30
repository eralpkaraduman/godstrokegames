package states 
{
	import actors.Captain;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class IntroState extends FlxState 
	{
		private var platform:FlxSprite;
		private var captain:Captain;
		
		[Embed(source="../../gfx/tiles.png")] private var gfx_tiles:Class;
		[Embed(source="../../gfx/map.png")] private var gfx_map:Class;
		[Embed(source="../../gfx/smokeTrailParticlesSmall.png")] private var gfx_pipeSmoke:Class;
		private var tileMap:FlxTilemap;
		private var minimap:MiniMap;
		private var pipeSmokeEmitter:FlxEmitter;
		
		public function IntroState() 
		{
			
		}
		
		override public function create():void {
			var versionInfo:FlxText = new FlxText(0, 0, 300, "Captains In Conflict : Animations Test\npress 'r' to reset\n'space' to jump\ncursor keys to move.");
			versionInfo.scrollFactor = new FlxPoint(0, 0);
			versionInfo.color = 0x000000;
			
			pipeSmokeEmitter = new FlxEmitter(0, 0);
			pipeSmokeEmitter.createSprites(gfx_pipeSmoke, 10, 1, true, 0);
			pipeSmokeEmitter.maxParticleSpeed = new FlxPoint(0, 2);
			pipeSmokeEmitter.gravity = -10;
			pipeSmokeEmitter.setXSpeed(0, 1);
			pipeSmokeEmitter.start(false,0,0);
			
			
			/*
			platform = new FlxSprite();
			platform.createGraphic(800, 40, 0xff1a1f2b);
			platform.y = FlxG.height/5*4;
			platform.x = 0;
			platform.fixed = true;
			add(platform);
			*/
			captain = new Captain(0, 0);
			captain.y = 300;
			captain.x = 100;
			pipeSmokeEmitter.x = captain.x;
			pipeSmokeEmitter.y = captain.y;
			
			FlxG.follow(captain, 2);
			FlxG.followAdjust(1, 0);
			FlxG.followBounds(0,0,50*54,30*54);
			
			//bgColor = 0xD0E4F2;
			bgColor = 0xC72A2A;
			
			tileMap = new FlxTilemap();
			//tileMap.auto = FlxTilemap.AUTO;
			//tileMap.loadMap(FlxTilemap.arrayToCSV(levelData, 50), gfx_hullTile,54,54);
			tileMap.loadMap(FlxTilemap.pngToCSV(gfx_map,false,1), gfx_tiles,54,54);
			//tileMap.loadMap(FlxTilemap.arrayToCSV(levelData, 10), FlxTilemap.);
			
			minimap = new MiniMap();
			add(tileMap);
			add(captain);
			add(pipeSmokeEmitter);
			add(minimap);
			add(versionInfo);
			
		}
		
		override public function update():void {
			//collide();
			
			if (FlxG.keys.R) {
				FlxG.state = new IntroState();
				return;
			}
			
			FlxU.collide(captain, tileMap);
			if (captain.facing == FlxSprite.RIGHT) {
				pipeSmokeEmitter.x = captain.x + 41;
				pipeSmokeEmitter.y = captain.y + 13;
			}else {
				pipeSmokeEmitter.x = captain.x + 13;
				pipeSmokeEmitter.y = captain.y + 13;
			}
			
			minimap.updatePos(new FlxPoint(captain.x, captain.y));
			super.update();
		}
		
	}

}