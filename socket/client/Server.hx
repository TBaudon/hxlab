package ;
import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import openfl.events.EventDispatcher;
import openfl.net.Socket;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.ProgressEvent;
import openfl.utils.ByteArray;
import openfl.utils.Endian;

/**
 * ...
 * @author Thomas B
 */
class Server extends EventDispatcher
{
	
	var mSocket : Socket;
	
	var mCurrentMessageLength : UInt;
	var mWaitingMoreData : Bool;

	public function new(ip : String, port : Int) 
	{
		super();
		mSocket = new Socket(ip, port);
		mSocket.connect(ip, port);
		
		mSocket.addEventListener(Event.CONNECT, onConnect);
		mSocket.addEventListener(IOErrorEvent.IO_ERROR, onError);
		mSocket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
	}
	
	private function onData(e:Event):Void 
	{
		mSocket.endian = Endian.LITTLE_ENDIAN;
		while (mSocket.bytesAvailable > 0) {
			
			if (!mWaitingMoreData && mSocket.bytesAvailable >= 4) {
				
				mCurrentMessageLength = mSocket.readInt();
				
				if (mCurrentMessageLength <= mSocket.bytesAvailable)
					onMessageReceived();
				else
					mWaitingMoreData = true;
			}else {
				if (mCurrentMessageLength <= mSocket.bytesAvailable) {
					mWaitingMoreData = false;
					onMessageReceived();
				}
				break;
			}
		}
	}
	
	function onMessageReceived() {
		var bytes : ByteArray = new ByteArray();
		mSocket.readBytes(bytes, 0, mCurrentMessageLength);
		var data = Message.read(byteArrayToByte(bytes));
		dispatchEvent(new ServerEvent(ServerEvent.MESSAGE, data));
	}
	
	// REALLLYYYY, no simpler way to pass from bytearray to bytes on non native target ?
	function byteArrayToByte(byteArray : ByteArray) : Bytes {
		#if native
		return byteArray;
		#end
		var rep = new BytesBuffer();
		
		while (byteArray.position < byteArray.length) 
			rep.addByte(byteArray.readByte());
		
		return rep.getBytes();
	}
	
	private function onError(e:Event):Void 
	{
		dispatchEvent(new ServerEvent(ServerEvent.ERROR));
	}
	
	private function onConnect(e:Event):Void 
	{
		dispatchEvent(new ServerEvent(ServerEvent.CONNECTED));
	}
	
}