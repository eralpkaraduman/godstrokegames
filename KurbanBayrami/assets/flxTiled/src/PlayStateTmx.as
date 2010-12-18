package
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	
	import org.flixel.*;
	
	public class PlayStateTmx extends FlxState
	{
		[Embed(source="data/map.png")] private var ImgMap:Class;
		[Embed(source="data/tiles.png")] private var ImgTiles:Class;
		[Embed(source="data/bg.png")] private var ImgBG:Class;
		[Embed(source="data/gibs.png")] private var ImgGibs:Class;
		
		protected var _fps:FlxText;
		protected var _player:FlxSprite;
		protected var _elevator:FlxSprite;
		
		override public function create():void
		{
			loadTmxFile();
		}
		
		override public function update():void
		{
			_fps.text = FlxU.floor(1/FlxG.elapsed).toString()+"fps";
			super.update();
			if(FlxG.keys.justReleased("ENTER"))
				FlxG.state = new PlayStateTmx();
			collide();
		}
		
		private function loadTmxFile():void
		{
			var loader:URLLoader = new URLLoader(); 
			loader.addEventListener(Event.COMPLETE, onTmxLoaded); 
			loader.load(new URLRequest('data/map01.tmx')); 
		}
		
		private function onTmxLoaded(e:Event):void
		{
			var xml:XML = new XML(e.target.data);
			var tmx:TmxMap = new TmxMap(xml);
			loadStateFromTmx(tmx);
		}
		
		private function loadStateFromTmx(tmx:TmxMap):void
		{			
			//Background
			FlxState.bgColor = 0xffacbcd7;
			var decoration:FlxSprite = new FlxSprite(256,159,ImgBG);
			decoration.moves = false;
			decoration.solid = false;
			add(decoration);			
			add(new FlxText(32,36,96,"collision").setFormat(null,16,0x778ea1,"center"));
			add(new FlxText(32,60,96,"DEMO").setFormat(null,24,0x778ea1,"center"));
			
			//create the flixel implementation of the objects specified in the ObjectGroup 'objects'
			var group:TmxObjectGroup = tmx.getObjectGroup('objects');
			for each(var object:TmxObject in group.objects)
				spawnObject(object)
			
			//Basic level structure
			var t:FlxTilemap = new FlxTilemap();
			//generate a CSV from the layer 'map' with all the tiles from the TileSet 'tiles'
			var mapCsv:String = tmx.getLayer('map').toCsv(tmx.getTileSet('tiles'));
			t.loadMap(mapCsv,ImgTiles);
			t.follow();
			add(t);
			
			//Instructions and stuff
			_fps = new FlxText(FlxG.width-60,0,40).setFormat(null,8,0x778ea1,"right",0x233e58);
			_fps.scrollFactor.x = _fps.scrollFactor.y = 0;
			add(_fps);
			var tx:FlxText;
			tx = new FlxText(2,0,FlxG.width,"TMX Loader Demonstration");
			tx.scrollFactor.x = tx.scrollFactor.y = 0;
			tx.color = 0x778ea1;
			tx.shadow = 0x233e58;
			add(tx);
			tx = new FlxText(2,FlxG.height-12,FlxG.width,"Interact with ARROWS + SPACE. Press ENTER to reload TMX.");
			tx.scrollFactor.x = tx.scrollFactor.y = 0;
			tx.color = 0x778ea1;
			tx.shadow = 0x233e58;
			add(tx);
		}
		
		
		private function spawnObject(obj:TmxObject):void
		{
			//Add game objects based on the 'type' property
			switch(obj.type)
			{
				case "elevator":
					add(new Elevator(obj.x, obj.y, obj.height));
					return;
				case "pusher":
					add(new Pusher(obj.x, obj.y, obj.width));
					return;
				case "player":
					add(new Player(obj.x,obj.y));
					return;
				case "crate":
					add(new Crate(obj.x,obj.y));
					return;
			}
		
			//This is the thing that spews nuts and bolts
			if(obj.type == "dispenser")
			{
				var dispenser:FlxEmitter = new FlxEmitter(obj.x,obj.y);
				dispenser.setSize(obj.width,obj.height);
				dispenser.setXSpeed(obj.custom['minvx'],obj.custom['maxvx']);
				dispenser.setYSpeed(obj.custom['minvy'],obj.custom['maxvy']);
				dispenser.createSprites(ImgGibs,120,16,true,0.8);
				dispenser.start(false,obj.custom['quantity']);
				add(dispenser);
			}
		}
		
		

	}
}