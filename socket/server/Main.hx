package ;

import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import haxe.Timer;
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
		
		var message = new Message();
		message.writeString("a");
		message.writeInt(52);
		message.writeBool(false);
		message.writeInt(213);
		message.writeInt(21);
		
		sendMessage(client, message);
	
		var message2 = new Message();
		message2.writeString("A");
		message2.writeInt(21);
		message2.writeBool(true);
		message2.writeInt(1);
		message2.writeInt(5);
		
		sendMessage(client, message2);
	}
	
	function sendMessage(client : Socket, message : Message) {
		var header = message.header.getBytes();
		var content = message.content.getBytes();
		
		var messageBuffer = new BytesBuffer();
		messageBuffer.addByte(header.length + content.length + 2);
		messageBuffer.addByte(header.length);
		messageBuffer.add(header);
		messageBuffer.addByte(content.length);
		messageBuffer.add(content);
		
		var message = messageBuffer.getBytes();
		
		client.output.writeBytes(message, 0, message.length);
		client.output.flush();
	}
	
}