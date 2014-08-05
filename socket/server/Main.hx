package ;

import neko.Lib;
import neko.vm.Thread;
import sys.net.Host;
import sys.net.Socket;

/**
 * ...
 * @author TBaudon
 */

class Main 
{
	
	var mSocket : Socket;
	var mPeers : Array<Socket>;
	
	static function main() 
	{
		new Main();
		
	}
	
	public function new() {
		
		var host = new Host(Host.localhost());
		Lib.println("Server launched on : " + host);
		
		mSocket = new Socket();
		mSocket.bind(host, 5000);
		mSocket.listen(1);
		
		mPeers = new Array<Socket>();
		
		Lib.println("Waiting for peer.");
		while (true) {
			var c : Socket = mSocket.accept();
			Lib.println("Peer connected.");
			mPeers.push(c);
			var thread = Thread.create(handler);
			thread.sendMessage(c);
		}
	}
	
	function handler() {
		var client : Socket = Thread.readMessage(true);
		client.write("You are connected.");
	}
	
}