package  
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.WheelMenu;
	import com.bit101.components.Window;
	import flash.display.Sprite;
	import flash.events.Event;
	
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
		
		var btn_ok:PushButton;
		private var lbl_name:Label;
		private var tf_name:InputText;
		
		public function AnimationPreview() 
		{
			addEventListener(Event.ADDED_TO_STAGE, oats);
			
		}
		
		private function oats(e:Event):void 
		{
			
			
			org_title = win().title;
			
			removeEventListener(Event.ADDED_TO_STAGE, oats);
			lbl_name = new Label(this, 5, 5, "Name");
			lbl_name.width = 30;
			tf_name = new InputText(this, lbl_name.x + lbl_name.width, 5, win().title, nameChangeHandler);
			tf_name.restrict = "a-zA-Z";
			frameCbxContainer.y = (tf_name.height + tf_name.y + 5);
			frameCbxContainer.x = 5;
			addChild(frameCbxContainer);
			
			var toggle:CheckBox = new CheckBox(frameCbxContainer, 0, 0, "1", onFRCbx);
			
			/*
			btn_ok = new PushButton(this, 0, 0, "OK");
			btn_ok.width = 30;
			*/
			win().width = 280;
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