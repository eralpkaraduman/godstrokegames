package  
{
	import org.flixel.FlxG;
	import playerio.Client;
	import playerio.Connection;
	import playerio.Message;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;
	/**
	$(CBI)* ...
	$(CBI)* @author GodStroke
	$(CBI)*/
	public class MultiplayManager 
	{
		
		public function MultiplayManager() 
		{
			
		}
		
		public static function connect():void 
		{
			FlxG.log("connecting...");
			
			PlayerIO.connect(
				FlxG.stage,
				"nemmies-wxokm1sv0kw9hugssqau1a",
				"public",
				Registry.player_name,
				"",
				onConnected,
				onConnectionFailed
			);
		}
		
		//**connected
		private static function onConnected(client:Client):void 
		{
			FlxG.log("connected");
			FlxG.log("joining...");
			client.multiplayer.developmentServer = "88.242.230.12:8184";
			client.multiplayer.createJoinRoom(
				"test",
				"Nemmies",
				true,
				{},
				{},
				onJoin,
				onJoinError
			)
		}
		
		
		//**join
		private static function onJoin(connection:Connection):void 
		{
			FlxG.log("joined");
			connection.addDisconnectHandler(onDisconnect);
			connection.addMessageHandler("hello", function(m:Message):void {
				FlxG.log("Server:Hello");
			})
			connection.addMessageHandler("UserJoined", function(m:Message, userid:uint):void{
				FlxG.log("Player with the userid "+userid+" just joined the room");
			})
			connection.addMessageHandler("UserLeft", function(m:Message, userid:uint):void{
				FlxG.log("Player with the userid "+userid+" just left the room");
			})
			connection.addMessageHandler("*", handleMessages)
		}
		
		// all messages
		private static function handleMessages(m:Message):void 
		{
			FlxG.log("Server:" + m);
		}
		
		//disconnection
		private static function onDisconnect():void 
		{
			FlxG.log("disconnected from server");
		}
		
		
		// fail
		private static function onConnectionFailed(error:PlayerIOError):void 
		{
			FlxG.log("connection failed "+error.message);
		}
		
		private static function onJoinError(error:PlayerIOError):void 
		{
			FlxG.log("join failed "+error.message);
		}
		
	}

}