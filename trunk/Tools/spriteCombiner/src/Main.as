package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import com.bit101.components.*;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class Main extends Sprite 
	{
		private var state1:Sprite;
		private var spriteSheetDisplay:Sprite;
		private var files:FileReferenceList;
		private var ff:FileFilter;
		private var file:FileReference;
		private var stackWidth:Number = 0;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			ff = new FileFilter("PNG files as frames", "*.png");
			
			state1 = new Sprite();
			spriteSheetDisplay = new Sprite();
			var loadBtn:PushButton = new PushButton(state1, 0,0,"Load PNG Sequence",loadSequenceBTN);
			
			addChild(state1);
			addChild(spriteSheetDisplay);
			
			spriteSheetDisplay.x = 20;
			spriteSheetDisplay.y = 80;
			
			state1.x = 20;
			state1.y = 20;
			
		}
		
		private function loadSequenceBTN(e:MouseEvent):void 
		{
			files = new FileReferenceList();
			
			files.addEventListener(Event.SELECT,onSel);
			files.browse([ff]);
			
			
			
			
		}
		
		private function onSel(e:Event):void 
		{
			trace("sel");
			for each(file in files.fileList) {
				file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);    
				file.addEventListener(ProgressEvent.PROGRESS, progressHandler);  
				file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);         
				file.addEventListener(Event.COMPLETE, completeHandler);
				file.load();
			}
			
			stackWidth = 0;
		}
		
		private function completeHandler(e:Event):void 
		{
			
			var f:FileReference = FileReference(e.target)
			//trace(Bitmap(f.data.));
			
			var l:Loader = new Loader();
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, onLLoCompl);
			l.loadBytes(f.data);
			/*
			var bitmapData:BitmapData = new BitmapData(l.width, l.height, true);
			bitmapData.draw(l);
			var frame:Bitmap = new Bitmap(bitmapData);
			*/
			
			//bitmapData.se
			//var bmp:Bitmap = new Bitmap();
			//bitmapData.
			
			
			//var fs:FileStream
		}
		
		private function onLLoCompl(e:Event):void 
		{
			var l:Loader = LoaderInfo(e.target).loader;
			l.x = stackWidth;
			stackWidth += l.width;
			spriteSheetDisplay.addChild(l);
			
			
			//trace(e.target);
			/*
			var bitmapData:BitmapData = new BitmapData(l.width, l.height, true);
			bitmapData.draw(l);
			var frame:Bitmap = new Bitmap(bitmapData);
			*/
		}
		
		public function securityErrorHandler(e:SecurityErrorEvent):void 
		{
			
		}
		
		private function progressHandler(e:ProgressEvent):void 
		{
			
		}
		
		public function ioErrorHandler(e:IOError):void 
		{
			
		}
		
		
		
	}
	
}