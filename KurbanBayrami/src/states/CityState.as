package states 
{
	import actors.Haci;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import net.pixelpracht.tmx.TmxMap;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	
	/**
	$(CBI)* ...
	$(CBI)* @author eralp
	$(CBI)*/
	public class CityState extends FlxState 
	{
		[Embed(source="../../gfx/kurban_bayrami_tiles.png")] private var gfx_tilemap:Class;
		private var haci:Haci;
		
		public function CityState() 
		{
			// keep empty
		}
		
		override public function create():void {
			loadTMX();
			super.create();
		}
		
		override public function update():void {
			super.update();
			
			collide();
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
			var tilemap:FlxTilemap = new FlxTilemap();
			var mapCSV:String = tmx.getLayer('map').toCsv(tmx.getTileSet('generic'));
			tilemap.loadMap(mapCSV, gfx_tilemap);
			add(tilemap);
			mapReady();
		}
		//******** [X] MAP GENERATION *********//
		
		
		private function mapReady():void
		{
			// make hacı
			haci = new Haci(10,20);
			add(haci);
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