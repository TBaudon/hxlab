package engine.geom;

/**
 * ...
 * @author Thomas B
 */
class Vector2
{
	
	public var x : Float;
	public var y : Float;
	
	public var angle(get_angle, set_angle):Float;
	public var length(get_length, never) : Float;

	public function new(x : Float = 0, y : Float = 0) 
	{
		this.x = x;
		this.y = y;
	}
	
	public function toString() {
		return '$x;$y';
	}
	
	public function add(vec : Vector2) : Vector2 {
		return new Vector2(vec.x + x, vec.y + y);
	}
	
	public function addEq(vec : Vector2) : Vector2 {
		x = x + vec.x;
		y = y + vec.y;
		return this;
	}
	
	public function sub(vec : Vector2) : Vector2 {
		return new Vector2(x - vec.x, y - vec.y);
	}
	
	public function subEq(vec : Vector2) : Vector2 {
		x = x - vec.x;
		y = y - vec.y;
		return this;
	}
	
	public function mul(float : Float) : Vector2 {
		return new Vector2(x * float, y * float);
	}
	
	public function muleq(float : Float) : Vector2 {
		x = x * float;
		y = y * float;
		return this;
	}
	
	public function get_angle() : Float {
		return Math.atan2(y, x)*180/Math.PI;
	}
	
	public function set_angle(angle : Float) : Float {
		var l = length;
		x = Math.cos(angle / 180 * Math.PI) * l;
		y = Math.sin(angle / 180 * Math.PI) * l;
		return angle;
	}
	
	public function get_length() : Float {
		return Math.sqrt(x * x + y * y);
	}
	
	public function normalize() : Vector2 {
		var l = length;
		x = x / l;
		y = y / l;
		return this;
	}
}