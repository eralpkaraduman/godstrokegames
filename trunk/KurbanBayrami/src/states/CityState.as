package states 
{
	import actors.Haci;
	import actors.Koyun;
	import actors.Kurbanlik;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class CityState extends FlxState 
	{
		[Embed(source="../../gfx/kurban_bayrami_tiles.png")] private var gfx_tilemap:Class;
		private var haci:Haci;
		private var _fromleft:Boolean; // haci mape soldanmı sağdanmı girdi?
		private var HaciSpawnLeftPoint:Point;
		private var HaciSpawnRightPoint:Point;
		private var _haciHasKurbanlik:FlxObject;
		private var tilemap:FlxTilemap;
		
		// collision / overlaping lists 
		private var kurbanlikGroup:FlxGroup = new FlxGroup();
		private var enemyGroup:FlxGroup = new FlxGroup();
		
		public function CityState(fromleft:Boolean=true,haciHasKurbanlik:FlxObject=null) 
		{
			_haciHasKurbanlik = haciHasKurbanlik;
			trace("fromleft",fromleft);
			_fromleft = fromleft;
			// keep empty
		}
		
		override public function create():void {
			loadTMX();
			super.create();
			
			
		}
		
		override public function update():void {
			//collide();
			
			FlxU.collide(haci, tilemap);
			FlxU.collide(kurbanlikGroup, tilemap);
			FlxU.collide(enemyGroup, tilemap);
			//
			FlxU.overlap(haci, kurbanlikGroup,overlap_haci_kurbanlik);
			
			
			
			super.update();
			
			
		}
		
		private function overlap_haci_kurbanlik(o1:FlxObject,o2:FlxObject):void
		{
			
			if (FlxG.keys.C && haci.caughtSomething == null) {
				Kurbanlik(o2).caught(haci);
				//trace(o2);
			}
		}
		
		//******** MAP GENERATION *********//
		private function loadTMX():void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onTMXLoaded);
			loader.load(new URLRequest('../gfx/cityMap.tmx'));
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
			//
			var objectGroup:TmxObjectGroup = tmx.getObjectGroup("objects");
			parseMapObjects(objectGroup);
			//
			tilemap.loadMap(mapCSV, gfx_tilemap);
			add(tilemap);
			
			add(kurbanlikGroup);
			add(enemyGroup);
			
			mapReady();
		}
		//******** [X] MAP GENERATION *********//
		
		
		private function mapReady():void
		{
			// make hacı
			if (_fromleft) {
				haci = new Haci(HaciSpawnLeftPoint.x,HaciSpawnLeftPoint.y);
			}else {
				haci = new Haci(HaciSpawnRightPoint.x,HaciSpawnRightPoint.y);
			}
			//trace("_haciHasKurbanlik",_haciHasKurbanlik);
			
			add(haci);
			
			if (_haciHasKurbanlik) 
			{
				
				var kurbanType:String = String(_haciHasKurbanlik);
				//trace();
				
				var kurbanClass:Class = Class(getDefinitionByName(kurbanType));
				var kurban:Kurbanlik = new kurbanClass() as Kurbanlik;
				//kurban.x = FlxG.width / 2;
				//kurban.y = FlxG.height / 2;
				//kurban.dead = false;
				kurban.caught(haci)
				//kurban.canMove = false;
				kurbanlikGroup.add(kurban);
				
				
			}
			
			//haci = new Haci(10,20);
			
		}
		
		private function parseMapObjects(objectGroup:TmxObjectGroup):void
		{	
			var o:TmxObject = getTMXObjectByName("HaciSpawnLeft", objectGroup);
			HaciSpawnLeftPoint = new Point(o.x, o.y);
			o = getTMXObjectByName("HaciSpawnRight", objectGroup);
			HaciSpawnRightPoint = new Point(o.x, o.y);
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
		
		public function haciLeftTheMap(fromRight:Boolean):void {
			if (fromRight) {
				FlxG.state = new CollectState();
				return;
			}else {
				FlxG.state = new KillStage();
				return;
			}
		}
	}

}