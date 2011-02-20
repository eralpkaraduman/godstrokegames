package com.godstroke.flixel 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class PNGTileMap 
	{
		public static const OFFSET_TOP_LEFT:String = "OFFSET_TOP_LEFT";
		
		public static function parse(pngFile:Class,colorKey:uint,levelSize:Point,tileSize:Point,offset:String = OFFSET_TOP_LEFT):Array {
			var layout:Bitmap = new pngFile();
			var bmpd:BitmapData =  layout.bitmapData;
			var mapTileSize:Point = new Point((levelSize.x / layout.width), (levelSize.y / layout.height));
			trace("mapTileSize ", mapTileSize);
			var indexes_2d:Array = new Array();
			var w:uint = layout.width;
			var h:uint = layout.height;
			var r:uint;
			var c:uint;
			var p:uint;
			for(r = 0; r < h; r++){
				for(c = 0; c < w; c++)
				{
					p = bmpd.getPixel(c, r);
					if (p == colorKey) {
						
						var r_t:uint = r;
						var c_t:uint = c;
						if (offset == OFFSET_TOP_LEFT) {
							r_t = r_t * mapTileSize.y;
							c_t = c_t * mapTileSize.x;
						}
						
						indexes_2d.push(new Point(c_t,r_t ));
					}
				}
			}
			return indexes_2d;
		}
		
	}

}