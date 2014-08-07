package ;
import openfl.events.Event;

/**
 * ...
 * @author Thomas B
 */
class ServerEvent extends Event
{

	public static inline var CONNECTED = "connected";
	public static inline var ERROR = "error";
	public static inline var MESSAGE = "message";
	
	public var data : Dynamic;
	
	public function new(type:String, data:Dynamic = null) {
		super(type, false, false);
		this.data = data;
	}
	
}