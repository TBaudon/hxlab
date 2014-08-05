package ;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.ProgressEvent;
import openfl.net.Socket;
import sys.net.Host;

/**
 * ...
 * @author TBaudon
 */

class Main extends Sprite 
{
	var mSocket:Socket;
	
	public function new() {
		super();
		
		mSocket = new Socket();
		mSocket.connect(Macros.getBuilderIp(), 5000);
		mSocket.addEventListener(Event.CONNECT, onConnect);
		mSocket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		mSocket.addEventListener(ProgressEvent.SOCKET_DATA, onResponse);
		
		sendMessage(Protocol.ASK_SCRIPT);
	}
	
	private function onResponse(e:Event):Void 
	{
		trace(mSocket.readUTFBytes(mSocket.bytesAvailable));
	}
	
	private function onError(e:Event):Void 
	{
		trace("error");
	}
	
	private function onConnect(e:Event):Void 
	{
		trace("connected");
	}
	
	private function sendMessage(message : Dynamic) {
		for (field in Reflect.fields(message)) {
			trace(Reflect.field(message, field));
		}
	}
}
