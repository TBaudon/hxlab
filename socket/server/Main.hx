package ;

import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import haxe.io.BytesOutput;
import haxe.Timer;
import neko.Lib;
import neko.vm.Thread;
import sys.io.File;
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
	
		while(true){
			var message = new Message();
			message.addString("code", "scriptUpdate");
		
			var script = File.getContent("../scripts/baseScript.hx");
		
			message.addString("script", script);
		
		
			sendMessage(client, message);
			
			Sys.sleep(3);
		}
	}
	
	function sendMessage(client : Socket, message : Message) {
		var content = message.output.getBytes();
		
		var messageBuffer = new BytesOutput();
		messageBuffer.writeInt32(content.length);
		messageBuffer.write(content);
		
		var message = messageBuffer.getBytes();
		
		client.output.writeBytes(message, 0, message.length);
		client.output.flush();
	}
	
}