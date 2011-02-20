package  
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import playerio.Client;
	import playerio.Connection;
	import playerio.Message;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;
	
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class IntroState extends FlxState 
	{
		
		[Embed(source = '../gfx/start-btn-over.png')]private var gfx_startBTN_over:Class;
		[Embed(source = '../gfx/start-btn-up.png')]private var gfx_startBTN_up:Class;
		[Embed(source='../gfx/enter_name.png')]private var gfx_enter_name:Class;
		private var textField:TextField;
		private var startButton:FlxButton;
		private var gfx_enter_name_spr:FlxSprite;
		
		public function IntroState() 
		{
			
		}
		
		override public function create():void {
			
			gfx_enter_name_spr = new FlxSprite(0, 0, gfx_enter_name);
			gfx_enter_name_spr.x = FlxG.width / 2 - gfx_enter_name_spr.width / 2;
			gfx_enter_name_spr.y = 37;
			add(gfx_enter_name_spr);
			
			startButton = new FlxButton(0, 0, onStartBTN);
			var flxspr_up:FlxSprite = new FlxSprite(0, 0, gfx_startBTN_up);
			var flxspr_over:FlxSprite = new FlxSprite(0, 0, gfx_startBTN_over);
			startButton.loadGraphic(flxspr_over,flxspr_up );
			startButton.x = FlxG.width / 2 - flxspr_up.width / 2;
			startButton.y = FlxG.height / 2 - flxspr_up.height / 2;
			add(startButton);
			
			textField = new TextField();
			textField.x = 120 + 30 - 15 + 5;
			textField.maxChars = 9;
			textField.restrict = "a-zA-Z"
			textField.y = 55*2 - 20 + 10 - 2-1;
			textField.embedFonts = true;
			textField.sharpness = 100;
			textField.height = 20;
			textField.multiline = false;
			textField.width = 200;
			textField.wordWrap = false;
			var tf:TextFormat = new TextFormat("system", 8 * 2, 0x4a5039);
			tf.align = TextFormatAlign.CENTER
			textField.defaultTextFormat = tf;
			textField.setTextFormat(tf);
			/*textField.width = textField.width * 2;
			textField.height = textField.height * 2;*/
			
			textField.type = TextFieldType.INPUT;
			textField.text = ""
			textField.addEventListener(MouseEvent.MOUSE_OVER, onTFmov);
			textField.addEventListener(MouseEvent.MOUSE_OUT, onTFmou);
			FlxG.stage.addChild(textField);
			
			
			bgColor = 0x626c46;
			FlxG.mouse.show();
			
		}
		
		private function onTFmou(e:MouseEvent):void 
		{
			FlxG.mouse.show();
		}
		
		private function onTFmov(e:MouseEvent):void 
		{
			FlxG.mouse.hide();
		}
		
		private function onStartBTN():void 
		{
			if (textField.text.length > 0) {
				
				startButton.visible = false;
				FlxG.stage.removeChild(textField);
				gfx_enter_name_spr.visible = false;
				Registry.player_name = textField.text;
				FlxG.state = new ConnectionState();
				
			}
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

}