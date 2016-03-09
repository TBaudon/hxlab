package;

import neko.Lib;
import sys.net.Host;
import sys.net.Socket;

/**
 * ...
 * @author TBaudon
 */
class Main {
	
	var mSocket : Socket;
	
	static function main() {
		
		new Main();
		
	}
	
	public function new() {
		mSocket = new Socket();
		mSocket.bind(new Host("localhost"), 80);
		mSocket.listen(100);
		
		while (true) {
			try {
				
				var client = mSocket.accept();
				
				var request = new Request(client);
				Sys.println(request.url);
				request.end("Bonjour grosse merde!", 200, "OK");
			
			}catch (e : Dynamic) {
				trace("merde");
			}
		}
		
	}
	
}