package ;
import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;

/**
 * ...
 * @author Thomas B
 */
class Message
{
	
	/*
	 * int = 0
	 * bool = 1
	 * string = 2 + size
	 */

	public var header : BytesBuffer;
	public var content : BytesBuffer;
	
	public function new() {
		header = new BytesBuffer();
		content = new BytesBuffer();
	}
	
	public function writeInt(x : Int) {
		header.addByte(0);
		content.addByte(x);
	}
	
	public function writeBool(b : Bool) {
		header.addByte(1);
		if(b)
			content.addByte(1);
		else
			content.addByte(0);
	}
	
	public function writeString(s : String) {
		header.addByte(2);
		header.addByte(s.length);
		content.addString(s);
	}
	// why bother with a header ? just altern type declaration and value
	public static function read(bytes : Bytes) : Dynamic {
		var input = new BytesInput(bytes);
		var headerSize = input.readByte();
		var headerByteRead : Int = 0;
		while (headerByteRead < headerSize) {
			var type = input.readByte();
			switch (type) {
				case 0 :
					trace("int");
				case 1 :
					trace("bool");
				case 2 :
					var len = input.readByte();
					trace("String : " + len);
			}
			headerByteRead++;
		}
		var contentSize = input.readByte();
		
		return null;
	}
	
}