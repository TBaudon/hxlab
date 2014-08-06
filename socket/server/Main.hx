package ;

import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import haxe.io.BytesOutput;
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
		message.writeString("I'm trying to code a haxe client/server application.");
		message.writeInt(52);
		message.writeBool(false);
		message.writeInt(213);
		message.writeString("Is it working?");
		message.writeInt(21);
		
		sendMessage(client, message);
	
		/*var message2 = new Message();
		message2.writeString("this message should come later");
		message2.writeInt(21);
		message2.writeBool(true);
		message2.writeInt(1);
		message2.writeInt(5);
		
		sendMessage2(client, message2);*/
	}
	
	function sendMessage(client : Socket, message : Message) {
		var content = message.output.getBytes();
		
		var messageBuffer = new BytesOutput();
		messageBuffer.writeInt32(content.length);
		messageBuffer.write(content);
		
		var message = messageBuffer.getBytes();
		
		for(i in 0 ... 10){
			client.output.writeBytes(message, 0, message.length);
			client.output.flush();
			Sys.sleep(1);
		}
	}
	
	function sendMessage2(client : Socket, message : Message) {
		var content = message.output.getBytes();
		
		var messageBuffer = new BytesOutput();
		messageBuffer.writeInt32(content.length);
		messageBuffer.write(content);
		
		var message = messageBuffer.getBytes();
		
		var lastPos = 0;
		var byteToWrite = 8;
		var loop = true;
		while (loop) {
			
			if (message.length < (lastPos + byteToWrite)-1){
				byteToWrite = message.length + lastPos;
				loop = false;
			}
			
			client.output.writeBytes(message, lastPos, byteToWrite);
			client.output.flush();
			
			lastPos += byteToWrite;
			
			
			Sys.sleep(1);
		}
	}
	
}