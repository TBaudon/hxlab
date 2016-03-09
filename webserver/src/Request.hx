package;
import haxe.Http;
import sys.net.Socket;

/**
 * ...
 * @author TBaudon
 */
class Request {

	var mSocket : Socket;
	
	public var method : String;
	public var url : String;
	public var version : String;
	
	public var headers : Map<String, String>;

	var mAnswer : HttpAnswer;
	
	public function new(socket : Socket) {
		mSocket = socket;		
		headers = new Map<String, String>();
		
		readHeader();
	}
	
	public function readHeader() {
		var header = mSocket.input.readLine().split(" ");
		method = header[0];
		url = header[1];
		version = header[2];
		
		var line = "";
		
		do {
			line = mSocket.input.readLine();
			var keyVal = line.split(":");
			headers[keyVal[0]] = keyVal[1];
		}while (line != "");
		
		trace(headers);
	}
	
	public function end(data : String, status : Int, raison : String) {
		
		mAnswer = new HttpAnswer(status, raison);
		mAnswer.add("Date: Fri, 31 Dec 1999 23:59:59 GMT");
		mAnswer.add("Content-Type: text/html");
		mAnswer.add("Content-Length: " + data.length);
		mAnswer.add("");
		mAnswer.add(data);
		
		mSocket.output.writeString(mAnswer.end());
		mSocket.output.flush();
		mSocket.close();
	}
	
}