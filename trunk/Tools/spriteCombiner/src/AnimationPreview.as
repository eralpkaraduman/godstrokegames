package  
{
	import adobe.utils.CustomActions;
	import com.bit101.components.CheckBox;
	import com.bit101.components.InputText;
	import com.bit101.components.Knob;
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.ListItem;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.WheelMenu;
	import com.bit101.components.Window;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	
	
	
	public class AnimationPreview extends Sprite 
	{
		private var org_title:String;
		private var frameCbxContainer:Sprite = new Sprite();
		
		private function win():Window {
			//trace(parent.parent.parent);
			return parent.parent.parent as  Window;
		}
		
		private var lbl_name:Label;
		private var tf_name:InputText;
		private var stepp:NumericStepper;
		private var btn_add:PushButton;
		private var itemsArray:Array;
		private var list:List;
		private var inputFR:InputText;
		public var fps:int = 12;
		
		
		public function AnimationPreview() 
		{
			addEventListener(Event.ADDED_TO_STAGE, oats);
			
			addEventListener(Event.ENTER_FRAME, oef);
			
		}
		
		private var t_lastFrame:Number = getTimer();
		private var panel:Panel;
		private var animationBuffer:Bitmap;
		private var bufferBMP:BitmapData;
		private var bufferSpriteIndex:int = 0;
		private var fpsKnob:Knob;
		private function oef(e:Event):void 
		{
			if (win().minimized) return;
			
			var curTime:Number = getTimer();
			if ((curTime - t_lastFrame) >= (1000 / fps)) {
				
				if (panel && list.items.length>0 && win().visible) {
					
					
					if (bufferSpriteIndex >= itemsArray.length) bufferSpriteIndex = 0;
					if (bufferSpriteIndex < 0) bufferSpriteIndex = 0;
					
					var spriteIndexO:Object = list.items[bufferSpriteIndex];
					var spriteIndex:int = spriteIndexO.data;
					var mspr:* = Main.sprites;
					var mainSprite:FrameSprite = Main.sprites[spriteIndex];
					trace(bufferSpriteIndex,spriteIndex);
					var l:Loader = Main.sprites[spriteIndex].loader;
					//bufferBMP.
					//bufferBMP.
					//animationBuffer.bitmapData.
					
					bufferBMP.fillRect(bufferBMP.rect, 0);
					bufferBMP.draw(l.content, null, null, null, null, false);
					
					//animationBuffer.bitmapData = Bitmap(l.content).bitmapData;
					//trace("step");
					
					//nxt
					bufferSpriteIndex++;
				}
				
				t_lastFrame = curTime;
			}
			
			
		}
		
		private function oats(e:Event):void 
		{
			org_title = win().title;
			
			removeEventListener(Event.ADDED_TO_STAGE, oats);
			lbl_name = new Label(this, 5, 5, "Name");
			lbl_name.width = 30;
			tf_name = new InputText(this, lbl_name.x + lbl_name.width, 5, win().title, nameChangeHandler);
			tf_name.restrict = "a-zA-Z";
			tf_name.width = 60;
			frameCbxContainer.y = (tf_name.height + tf_name.y + 5);
			frameCbxContainer.x = 5;
			addChild(frameCbxContainer);
			
			
			/*
			var t_x:int = 0;
			var t_y:int = 0;
			var t_w:int = 30;
			var t_h:int = 15;
			
			for (var i:int = 0 ; i < Main.sprites.length ; i++ ) {
				
				
				
				var toggle:CheckBox = new CheckBox(frameCbxContainer, 0, 0, "1", onFRCbx);
				toggle.width = t_w;
				toggle.height = t_h;
				
			}
			*/
			frameCbxContainer.y = (tf_name.height + tf_name.y + 5);
			frameCbxContainer.x = 5;
			stepp = new NumericStepper(this,5,(tf_name.height + tf_name.y + 5),onStep);
			stepp.width = 55;
			stepp.maximum = Main.sprites.length - 1;
			stepp.minimum = 0;
			stepp.step = 1;
			btn_add = new PushButton(this, stepp.x + stepp.width + 5, stepp.y, "Add", onAdd);
			btn_add.width = 30
			btn_add.height = 16;
			/*
			btn_ok = new PushButton(this, 0, 0, "OK");
			btn_ok.width = 30;
			*/
			
			itemsArray = new Array();
			list = new List(this, 5, btn_add.y + btn_add.height + 5, itemsArray);
			list.addEventListener(Event.SELECT, onListSelect);
			list.autoHideScrollBar = true;
			list.alternateRows = true;
			list.width = 33;
			list.height = 130;
			
			var btn_remove:PushButton = new PushButton(this, list.x + list.width + 5, list.y, "Remove",onRemove);
			btn_remove.width = 52;
			
			inputFR = new InputText(this,btn_remove.x,btn_remove.y+btn_remove.height+5,"",onFRInpChanged)
			inputFR.width = 52;
			inputFR.restrict = "0-9";
			
			panel = new Panel(this, tf_name.x + tf_name.width + 5, 5);
			panel.width = Main.sprites[0].loader.width;
			panel.height = Main.sprites[0].loader.height;
			bufferBMP = new BitmapData(Main.sprites[0].loader.width, Main.sprites[0].loader.height, true);
			
			
			fpsKnob = new Knob(this, inputFR.x + 7, inputFR.height + 5 + inputFR.y, "FPS", onFpsKnob);
			fpsKnob.value = fps;
			fpsKnob.minimum = 1;
			fpsKnob.maximum = stage.frameRate;
			fpsKnob.labelPrecision = 0;
			fpsKnob.mode = Knob.ROTATE;
			//bufferBMP.lock();
			//animationBuffer = new Bitmap(bufferBMP,PixelSnapping.NEVER,false);
			animationBuffer = new Bitmap(bufferBMP);
			panel.content.addChild(animationBuffer);
			//panel.addChild(animationBuffer);
			//addChild(animationBuffer);
			win().width = panel.x+panel.width+5;
			var lscl:Number = list.y + list.height + 5 + parent.parent.y;
			var pncl:Number = panel.height + panel.y + 5 + parent.parent.y;
			
			win().height = (lscl > pncl)? lscl : pncl;
			
		}
		
		private function onFpsKnob(e:Event):void 
		{
			fps = fpsKnob.value;
			//trace(fpsKnob.value);
		}
		
		private function onFRInpChanged(e:Event):void 
		{
			trace("cn")
			
			if (list.selectedItem) {
				
				var cur:String = inputFR.text;
				var frn:Number = Number(cur);
				
				if (frn >= Main.sprites.length) frn = Main.sprites.length - 1;
				if (frn < 0) frn = 0;
				
				/*
				itemsArray[list.selectedIndex].data = frn;
				itemsArray[list.selectedIndex].label = frn + "";
				*/
				
				list.selectedItem.label = frn+"";
				list.selectedItem.data = frn;
				list.items = itemsArray;
				
				inputFR.text = list.selectedItem.data + "";
				
			}else {
				inputFR.text = "";
			}
			//if(list.selectedItem)
		}
		
		private function onRemove(e:MouseEvent):void 
		{
			if (list.selectedIndex > -1) {
				list.removeItemAt(list.selectedIndex);
			}
		}
		
		private function onListSelect(e:Event):void 
		{
			if (list.selectedItem) {
				Main.sprites[list.selectedItem.data].highLightRed();
				inputFR.text = list.selectedItem.data + "";
				
			}
		}
		
		private function onAdd(e:MouseEvent):void 
		{
			list.addItem( { label:stepp.value+"", data:stepp.value});
		}
		
		private function onStep(e:Event):void
		{
			
			Main.sprites[stepp.value].highLightRed();
		}
		
		private function onFRCbx(e:Event):void {
			trace(CheckBox(e.target).label);
		}
		
		private function nameChangeHandler(e:Event):void 
		{
			if (tf_name.text.length > 0) {
				win().title = tf_name.text;
			}else {
				win().title = org_title;
			}
			
		}
		
		
		
	}

}