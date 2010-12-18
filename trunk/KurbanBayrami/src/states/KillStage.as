package states 
{
	import actors.Haci;
	import actors.Kurbanlik;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class KillStage extends FlxState 
	{
		[Embed(source = "../../gfx/kurban_bayrami_tiles.png")] private var gfx_tilemap:Class;
		private var haci:Haci;
		private var _haciBringsKurbanlik:FlxObject;
		private var kurbanlikGroup:FlxGroup = new FlxGroup();
		private var tilemap:FlxTilemap;
		private var uncollidingMap:FlxTilemap;
		private var ladderPosRect:Rectangle;
		private var dropZoneRect:Rectangle;
		
		public function KillStage(haciBringsKurbanlik:FlxObject=null) 
		{
			_haciBringsKurbanlik = haciBringsKurbanlik;
			//empty
		}
		
		override public function create():void
		{
			loadTMX();
			super.create();
		}
		
		override public function update():void {
			
			//collide();
			
			FlxU.collide(haci, tilemap);
			FlxU.collide(kurbanlikGroup, tilemap);
			
			if (FlxG.keys.justReleased("C")) {
				if (haci.caughtSomething) {
					Kurbanlik(haci.caughtSomething).released(haci);
				}
			}
			
			checkIfKurbansInTheDropZone();
			
			
			haci.canClimb = isInRect(haci, ladderPosRect);
			
			
			//haci.canClimb = false;
			//FlxU.overlap(haci,uncollidingMap,haciIsOnLadder);
			
			super.update();
			
		}
		
		private function checkIfKurbansInTheDropZone():void
		{
			for each( var k:Kurbanlik in kurbanlikGroup.members) {
				if (isInRect(k, dropZoneRect) && !k.markCollected) {
					k.markCollected = true;
					RAM.addSacrificable(k);
				}
			}
		}
		
		private function isInRect(ob:FlxObject,rect:Rectangle):Boolean {
			if ((ob.right) >= rect.x 
				&& (ob.left) <= (rect.x + rect.width)
				&& ob.bottom >= rect.y
				&& ob.bottom <= rect.y + rect.height 
			) {
				return true;
			}else {
				return false;
			}
		}
		
		/*
		private function haciIsOnLadder(o1:FlxObject,o2:FlxObject):void
		{
			haci.canClimb = true;
		}
		*/
		
		//******** MAP GENERATION *********//
		private function loadTMX():void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onTMXLoaded);
			loader.load(new URLRequest('../gfx/rageMap.tmx'));
		}
		
		private function onTMXLoaded(e:Event):void 
		{
			var xml:XML = new XML(e.target.data);
			var tmx:TmxMap = new TmxMap(xml);
			loadStateFromTMX(tmx);
		}
		
		private function loadStateFromTMX(tmx:TmxMap):void
		{
			FlxState.bgColor = 0xffacbcd7;
			
			//level
			tilemap = new FlxTilemap();
			var mapCSV:String = tmx.getLayer('map').toCsv(tmx.getTileSet('generic'));
			tilemap.loadMap(mapCSV, gfx_tilemap);
			add(tilemap);
			
			//tools - uncolliding map
			uncollidingMap = new FlxTilemap();
			var uncollidingMapCSV:String = tmx.getLayer('tools').toCsv(tmx.getTileSet('generic'));
			uncollidingMap.loadMap(uncollidingMapCSV, gfx_tilemap);
			add(uncollidingMap);
			//
			var objectGroup:TmxObjectGroup = tmx.getObjectGroup("objects");
			parseMapObjects(objectGroup);
			//
			add(kurbanlikGroup);
			
			mapReady();
		}
		
		private function parseMapObjects(objectGroup:TmxObjectGroup):void
		{
			var o:TmxObject = getTMXObjectByName("Ladder", objectGroup);
			ladderPosRect = new Rectangle(o.x, o.y, o.width, o.height);
			o = getTMXObjectByName("DropZone", objectGroup);
			dropZoneRect = new Rectangle(o.x, o.y, o.width, o.height);
			/*
			var fs:FlxSprite = new FlxSprite(o.x, o.y,null);
			add(fs);
			var fs2:FlxSprite = new FlxSprite(o.x+o.width, o.y+o.height,null);
			add(fs2);
			*/
			
		}
		
		private function getTMXObjectByName(name:String, objectGroup:TmxObjectGroup):TmxObject
		{
			var r:TmxObject = null;
			for each(var o:TmxObject in objectGroup.objects) { 
				if (o.name == name) {
					r = o;
					return r;
				}
			}
			return r;
		}
		
		//******** [X] MAP GENERATION *********//
		
		private function mapReady():void
		{
			// make hacı
			haci = new Haci(354,10);
			add(haci);
			
			if (_haciBringsKurbanlik) {
				var kurbanType:String = String(_haciBringsKurbanlik);
				
				var kurbanClass:Class = Class(getDefinitionByName(kurbanType));
				var kurban:Kurbanlik = new kurbanClass() as Kurbanlik;
				kurban.caught(haci);
				kurban.x = haci.x;
				kurban.y = haci.y;
				kurban.released(haci);
				kurbanlikGroup.add(kurban);
			}
		}
		
		public function haciLeftTheMap(fromRight:Boolean):void {
			if (fromRight) {
				FlxG.state = new CityState();
			}
		}
		
	}

}