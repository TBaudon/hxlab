package ;

/**
 * ...
 * @author Thomas B
 */
class BasicMath
{

	static public function add(a : Float,b : Float) : Float {
		return a + b;
	}
	
	static public function sub(a : Float,b : Float) : Float {
		return a - b;
	}
	
	static public function mult(a : Float,b : Float) : Float {
		return a * b;
	}
	
	static public function div(a : Float,b : Float) : Float {
		return a / b;
	}
	
	static public function modulo(a : Int, b : Int) : { result:Int, rest:Int } {
		return { result:Std.int(a / b), rest:a % b };
	}
	
}