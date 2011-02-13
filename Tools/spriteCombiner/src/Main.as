package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.errors.IOError;
	import flash.events.Event;
	import com.bit101.components.*;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import com.greensock.TweenMax;
	
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
		private var spriteContents:Vector.<FrameSprite> = new Vector.<FrameSprite>();
		private var stackHeight:Number = 0;
		private var btn_orderByFN:PushButton;
		private var loadBtn:PushButton;
		private var btn_orderByCurX:PushButton;
		private var btn_defineNewAnim:PushButton;
		private var closedWinsCount:int = 0;
		private var last_vr:int = 0;
		
		public var animations:Vector.<Vector.<FrameSprite>> = new Vector.<Vector.<FrameSprite>>();
		public var animationPreviews:Vector.<Window> = new Vector.<Window>();
		
		
		public static var sprites:Vector.<FrameSprite>;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			sprites = spriteContents;
			
		}
		
		private function init(e:Event = null):void 
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			ff = new FileFilter("PNG files as frames", "*.png");
			
			state1 = new Sprite();
			spriteSheetDisplay = new Sprite();
			loadBtn = new PushButton(state1, 0,0,"Load PNG Sequence",loadSequenceBTN);
			btn_orderByFN = new PushButton(state1, loadBtn.width+10, 0, "Order By Filename", onOrderByFileName);
			btn_orderByCurX = new PushButton(state1, btn_orderByFN.x + btn_orderByFN.width+10, 0, "Order By Current X", onOrderByCurX);
			btn_defineNewAnim = new PushButton(state1, btn_orderByCurX.x + btn_orderByCurX.width+10, 0, "Define New Animation", onDefineNewAnim);
			btn_orderByFN.enabled = false;
			btn_orderByCurX.enabled = false;
			btn_defineNewAnim.enabled = false;
			/*
			var animsAccordeonWin:Window = new Window(state1, 400, 300, "Animations");
			animsAccordeonWin.hasMinimizeButton = true;
			*/
			
			addChild(spriteSheetDisplay);
			addChild(state1);
			
			
			spriteSheetDisplay.x = 20;
			spriteSheetDisplay.y = 80;
			
			state1.x = 20;
			state1.y = 20;
			
		}
		
		private function onDefineNewAnim(e:MouseEvent):void 
		{
			
			var mpl:int = (animationPreviews.length + 1);
			
			
			/*var vr:int = (mpl / 8);
			if (vr == 0);
			
			trace(vr);
			var y_mul:int = 0;
			if (vr == 0) {
				y_mul = 0;
			}else {
				y_mul = ((mpl - closedWinsCount) * 20);
			}*/
			
			var y_mul:int = 100 + Math.random() * (stage.stageHeight - 400);
			var x_mul:int = 100 + Math.random() * (stage.stageWidth - 400);
			
			var animsAccordeonWin:Window = new Window(state1,x_mul, y_mul, "Animation" + (mpl));
			animsAccordeonWin.hasCloseButton = true;
			animsAccordeonWin.addEventListener(Event.CLOSE, onAnimClosed);
			animsAccordeonWin.hasMinimizeButton = true;
			var ap:AnimationPreview = new AnimationPreview();
			animsAccordeonWin.content.addChild(ap);
			animationPreviews.push(animsAccordeonWin);
		}
		
		private function onAnimClosed(e:Event):void 
		{
			trace("close");
			var t:Window = e.target as Window;
			t.visible = false;
			closedWinsCount++;
		}
		
		private function onOrderByCurX(e:MouseEvent):void 
		{
			spriteContents.sort(fByCurX);
			ordering();
		}
		
		private function onOrderByFileName(e:MouseEvent):void 
		{
			spriteContents.sort(fByFileName);
			ordering();
			
		}
		
		private function fByCurX(_x:FrameSprite, _y:FrameSprite):Number {
			
			if (_x.x < _y.x) {
				return -1;
			}else if (_x.x > _y.x) {
				return +1;
			}else {
				return 0;
			}
			
		}
		
		
		
		
		private function ordering():void 
		{
			var sizeRect:Rectangle = new Rectangle();
			var fs:FrameSprite;
			
			for each(fs in spriteContents) {
				if (fs.frameWidth > sizeRect.width) sizeRect.width = fs.frameWidth;
				if (fs.frameHeight > sizeRect.height) sizeRect.height = fs.frameHeight;
			}
			
			stackWidth = 0;
			stackHeight = 0;
			for each(fs in spriteContents) {
				fs.x = stackWidth;
				fs.y = stackHeight;
				
				stackWidth += sizeRect.width;
			}
		}
		
		
		private function fByFileName(_x:FrameSprite, _y:FrameSprite):Number {
			//trace(_x)
			//trace("x: "+_x.fileName);
			//trace("y: " + _y.fileName);
			
			//trace(_x.fileName, ">", _y.fileName, (_x.fileName > _y.fileName)?_x.fileName:_y.fileName );
			
			if (_x.fileName < _y.fileName) {
				return -1;
			}else if (_x.fileName > _y.fileName) {
				return +1;
			}else {
				return 0;
			}
		}
		
		private function loadSequenceBTN(e:MouseEvent):void 
		{
			files = new FileReferenceList();
			
			files.addEventListener(Event.SELECT,onSel);
			files.browse([ff]);
			
			
		}
		
		private function onSel(e:Event):void 
		{
			btn_orderByFN.enabled = true;
			btn_orderByCurX.enabled = true;
			btn_defineNewAnim.enabled = true;
			
			//trace("sel");
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
			
			var f:FileReference = FileReference(e.target);
			
			var fs:FrameSprite = new FrameSprite();
			fs.loadByteArray(f.data);
			fs.fileName = f.name;
			
			//trace(Bitmap(f.data.));
			
			/*
			var l:Loader = new Loader();
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, onLLoCompl);
			l.loadBytes(f.data);
			*/
			/*
			var bitmapData:BitmapData = new BitmapData(l.width, l.height, true);
			bitmapData.draw(l);
			var frame:Bitmap = new Bitmap(bitmapData);
			*/
			
			//bitmapData.se
			//var bmp:Bitmap = new Bitmap();
			//bitmapData.
			
			
			//var fs:FileStream
			
			fs.x = stackWidth;
			fs.y = stackHeight;
			stackWidth += 10;
			stackHeight += 10;
			spriteSheetDisplay.addChild(fs);
			spriteContents.push(fs);
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