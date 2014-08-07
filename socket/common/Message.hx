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
	public inline static var OBJECT = 3;
	
	public function new() {
		output = new BytesOutput();
	}
	
	public function addInt(name : String, x : Int) {
		writeField(name);
		writeInt(x);
	}
	
	public function addBool(name : String, b : Bool) {
		writeField(name);
		writeBool(b);
	}
	
	public function addString(name : String, s : String) {
		writeField(name);
		writeString(s);
	}
	
	function writeField(s : String) {
		output.writeByte(s.length);
		output.writeString(s);
	}
	
	function writeString(s : String) {
		output.writeByte(STRING);
		output.writeInt32(s.length);
		output.writeString(s);
	}
	
	function writeInt(x : Int) {
		output.writeByte(INT);
		output.writeInt32(x);
	}
	
	function writeBool(b : Bool) {
		output.writeByte(BOOL);
		if (b) output.writeByte(1);
		else output.writeByte(0); 
	}
	
	public static function read(bytes : Bytes) : Dynamic {
		
		var rep = { };
		
		var input = new BytesInput(bytes);
		var byteToRead = bytes.length;
		while (input.position < byteToRead) {
			var fieldLen = input.readByte();
			var field = input.readString(fieldLen);
			var type = input.readByte();
			switch(type) {
				case INT :
					Reflect.setProperty(rep, field, input.readInt32());
				case STRING :
					var len = input.readInt32();
					Reflect.setProperty(rep, field, input.readString(len));
				case BOOL : 
					Reflect.setProperty(rep, field, input.readByte());
			}
		}
		
		return rep;
	}
	
}