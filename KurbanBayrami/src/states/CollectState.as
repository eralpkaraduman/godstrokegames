package states 
{
	import actors.Haci;
	import actors.Koyun;
	import actors.Kurbanlik;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import net.pixelpracht.tmx.TmxMap;
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
	public class CollectState extends FlxState 
	{
		
		[Embed(source = "../../gfx/kurban_bayrami_tiles.png")] private var gfx_tilemap:Class;
		private var haci:Haci;
		private var tilemap:FlxTilemap;
		private var kurbanliklar:FlxGroup;
		
		override public function create():void
		{
			kurbanliklar = new FlxGroup();
			loadTMX();
			
			// testkoyun
			var koyun:Koyun = new Koyun();
			var koyun1:Koyun = new Koyun();
			var koyun2:Koyun = new Koyun();
			var koyun3:Koyun = new Koyun();
			koyun.x = 15;
			koyun.y = 15;
			kurbanliklar.add(koyun);
			
			koyun1.x = 165;
			koyun1.y = -15;
			kurbanliklar.add(koyun1);
			
			koyun2.x = 165;
			koyun2.y = -45;
			kurbanliklar.add(koyun2);
			
			koyun3.x = 200;
			koyun3.y = 15;
			kurbanliklar.add(koyun3);
			
			//koyun.canMove = false;
			
			
			
			super.create();
		}
		
		override public function update():void {
			
			FlxU.overlap(haci,kurbanliklar,overlap_haci_kurbanlik);
			FlxU.collide(kurbanliklar,tilemap);
			FlxU.collide(haci, tilemap);
			
			if (FlxG.keys.justReleased("C")) {
				if (haci.caughtSomething) {
					Kurbanlik(haci.caughtSomething).released(haci);
				}
			}
			
			//collide();
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
			loader.load(new URLRequest('../gfx/ruralMap.tmx'));
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
			add(kurbanliklar);
			mapReady();
		}
		//******** [X] MAP GENERATION *********//
		
		private function mapReady():void
		{
			// make hacı
			haci = new Haci(10,80);
			add(haci);
		}
		
		public function haciLeftTheMap(fromRight:Boolean):void {
			
			if (!fromRight) {
				FlxG.state = new CityState(false,haci.caughtSomething);
			}
			
			
		}
	}

}