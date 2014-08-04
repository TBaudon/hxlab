package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.events.IOErrorEvent;
import openfl.net.Socket;

/**
 * ...
 * @author TBaudon
 */

class Main extends Sprite 
{
	public function new() {
		super();
		
		var socket : Socket = new Socket();
		socket.connect("localhost", 5000);
		socket.addEventListener(Event.CONNECT, onConnect);
		socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		
		
	}
	
	private function onError(e:Event):Void 
	{
		trace("error");
	}
	
	private function onConnect(e:Event):Void 
	{
		trace("connect");
	}
}
