package ;

import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.ProgressEvent;
import openfl.net.Socket;
import openfl.utils.ByteArray;
import openfl.utils.Endian;

/**
 * ...
 * @author TBaudon
 */

class Main extends Sprite 
{
	
	var mServer : Server;
	
	public function new() {
		super();
		mServer = new Server(Macros.getBuilderIp(), 5000);
	}
}
