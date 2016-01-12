package mod;

/**
 * ...
 * @author Thomas B
 */
@:expose
class Module{

	static function __init__() {
		untyped __js__(Macros.setNameToTrue());
	}
	
	public function new() {
		trace("module instance");
	}
	
	public function update() {
		trace("mange du boudin");
	}
	
}