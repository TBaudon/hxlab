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
	public var output : BytesOutput;
	
	public inline static var INT = 0;
	public inline static var BOOL = 1;
	public inline static var STRING = 2;
	
	public function new() {
		output = new BytesOutput();
	}
	
	public function writeInt(x : Int) {
		output.writeByte(INT);
		output.writeInt32(x);
	}
	
	public function writeBool(b : Bool) {
		output.writeByte(BOOL);
		if (b) output.writeByte(1);
		else output.writeByte(0); 
	}
	
	public function writeString(s : String) {
		output.writeByte(STRING);
		output.writeInt32(s.length);
		output.writeString(s);
	}
	
	public static function read(bytes : Bytes) : Dynamic {
		var input = new BytesInput(bytes);
		var byteToRead = bytes.length;
		while (input.position < byteToRead) {
			var type = input.readByte();
			switch(type) {
				case INT :
					trace("int : " + input.readInt32());
				case STRING :
					var len = input.readInt32();
					trace("string : " + input.readString(len));
				case BOOL : 
					trace("bool : " + input.readByte());
			}
		}
		
		return null;
	}
	
}