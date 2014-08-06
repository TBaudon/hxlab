package ;

import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.ProgressEvent;
import openfl.net.Socket;
import openfl.utils.ByteArray;
import sys.net.Host;

/**
 * ...
 * @author TBaudon
 */

class Main extends Sprite 
{
	var mSocket:Socket;
	
	var mCurrentMessageLength : Int;
	var mInputBuffer : BytesBuffer;
	
	public function new() {
		super();
		
		mSocket = new Socket();
		mSocket.connect(Macros.getBuilderIp(), 5000);
		mSocket.addEventListener(Event.CONNECT, onConnect);
		mSocket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		mSocket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
				
		mInputBuffer = new BytesBuffer();
	}
	
	private function onData(e:Event):Void 
	{
		var byteReceived = mSocket.bytesAvailable;
		// while there are data on the socketInput
		while (mSocket.bytesAvailable > 0) {
			// if we treated all messages, read a new message
			if (mInputBuffer.length == 0) {
				mCurrentMessageLength = mSocket.readByte();
				// if all the message's data are not available, bufferise the current message
				if (mCurrentMessageLength > mSocket.bytesAvailable) {
					var bytes : ByteArray = new ByteArray();
					mSocket.readBytes(bytes, 0, mSocket.bytesAvailable);
					mInputBuffer.add(bytes);
				// else if all the data are available, read the message
				}else {
					var bytes : ByteArray = new ByteArray();
					mSocket.readBytes(bytes, 0, mCurrentMessageLength);
					Message.read(bytes);
					trace("Message received");
				}
			// we are currently buffering a message
			}else {
				var byteToRead = mCurrentMessageLength - mInputBuffer.length;
				if (byteToRead > mSocket.bytesAvailable) {
					var bytes : ByteArray = new ByteArray();
					mSocket.readBytes(bytes, 0, mSocket.bytesAvailable);
					mInputBuffer.add(bytes);
				}else {
					var bytes : ByteArray = new ByteArray();
					mSocket.readBytes(bytes, 0, byteToRead);
					mInputBuffer.add(bytes);
					Message.read(mInputBuffer.getBytes());
					mInputBuffer = new BytesBuffer();
					trace("Message received");
				}
			}
		}
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
