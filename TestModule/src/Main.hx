package;

import js.Boot;
import js.Browser;
import js.Lib;

/**
 * ...
 * @author Thomas B
 */

class Main {
	
	static function main() {
		trace("flop");
		var a = new Main();
	}
	
	public function new() {
		trace("Main instance");
		loadModule("mod.Module");
		loadModule("mod.SuperModule");
		
		var superModule = Type.createInstance(Type.resolveClass("mod.SuperModule"), []);
	}
	
	public function loadModule(path : String) {
		var pathElem = path.split('.');
		var currentElem = Browser.window;
		for (elem in pathElem) 
			currentElem = Reflect.getProperty(currentElem, elem);
		var cl : Class<Dynamic> = cast currentElem;
		var hxclasses = untyped __js__("$hxClasses");
		Reflect.setProperty(hxclasses, path, cl);
	}
	
}