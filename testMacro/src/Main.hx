package;

import neko.Lib;

/**
 * ...
 * @author TBaudon
 */
class Main {
	
	static function main() {
		
		var a = new RandomClass("oui oui", 12);
		var b = new RandomClass("non non", 25);
		
		trace(a.serialize());
		
	}
	
}