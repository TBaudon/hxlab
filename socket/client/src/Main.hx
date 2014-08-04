package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.events.IOErrorEvent;
import openfl.events.ProgressEvent;
import openfl.net.Socket;

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
		mSocket.connect("localhost", 5000);
		mSocket.addEventListener(Event.CONNECT, onConnect);
		mSocket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		mSocket.addEventListener(ProgressEvent.SOCKET_DATA, onResponse);
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
}
