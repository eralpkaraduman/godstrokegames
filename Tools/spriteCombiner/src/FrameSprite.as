package  
{
	import com.greensock.TweenMax;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.ByteArray;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class FrameSprite extends Sprite 
	{
		public var loader:Loader;
		private var border:Shape;
		private var redBorder:Shape;
		private var dragging:Boolean = false;
		public function get fileName():String {
			return fileNameTF.text;
		}
		private var fileNameTF:TextField = new TextField();
		public function set fileName(value:String):void {
			fileNameTF.text = value;
		}
		
		
		public function FrameSprite() 
		{
			border = new Shape();
			border.visible = false;
			redBorder = new Shape();
			redBorder.alpha = 0;
			
			fileNameTF.selectable = false;
			fileNameTF.autoSize = TextFieldAutoSize.LEFT;
			fileNameTF.height = 10;
			fileNameTF.x = -3;
			fileNameTF.visible = false;
			addChild(fileNameTF);
			
			loader = new Loader();
			
			//addChild(loader);
			
			addEventListener(MouseEvent.MOUSE_OVER, omo);
			addEventListener(MouseEvent.MOUSE_OUT, omou);
			addEventListener(MouseEvent.MOUSE_DOWN, mdown);
			addEventListener(MouseEvent.MOUSE_UP, mup);
			
			addEventListener(Event.ENTER_FRAME, dragLoop);
		}
		
		private function mup(e:MouseEvent):void 
		{
			dragging = false;
		}
		
		private function dragLoop(e:Event):void {
			if (!dragging) return;
			
			this.x = Math.round( stage.mouseX - (this.parent.x) - 20 );
			this.y = Math.round( stage.mouseY - (this.parent.y) - 20 );
		}
		
		private function mdown(e:MouseEvent):void 
		{
			border.visible = true;
			dragging = true;
			parent.addChild(this);
			
		}
		
		private function omou(e:MouseEvent):void 
		{
			fileNameTF.visible = false;
			border.visible = false;
		}
		
		private function omo(e:MouseEvent):void 
		{
			fileNameTF.visible = true;
			border.visible = true;
		}
		
		public function loadByteArray(ba:ByteArray):void {
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBALoadComplete);
			loader.loadBytes(ba);
		}
		
		private function onBALoadComplete(e:Event):void 
		{
			addChild(loader);
			
			border.graphics.lineStyle(0, 0x000000, 1);
			border.graphics.drawRect(0, 0, loader.width, loader.height);
			
			redBorder.graphics.lineStyle(0, 0xFF0000, 1);
			redBorder.graphics.drawRect(0, 0, loader.width, loader.height);
			
			addChild(border);
			addChild(redBorder);
			
			fileNameTF.y = - fileNameTF.height;
		}
		
		override public function toString():String {
			
			return "[FrameSprite : " + fileName + "]";
		}
		
		public function highLightRed():void 
		{
			TweenMax.to(redBorder, 0, { alpha:1, onComplete:function():void {
				TweenMax.to(redBorder,0, { alpha:0, delay:.3 } );
			}})
		}
		
		public function get frameWidth():int {
			return loader.width;
		}
		
		public function get frameHeight():int {
			return loader.height;
		}
	}

}