package;

import haxe.Template;


/**
 * ...
 * @author TBaudon
 */
class Main {
	
	static function main() {
		var data  = {
			array : ["ca", "marche", "pas", "en", "js"]
		};
		
		var tpl = new Template("::foreach array:: ::__current__:: ::end::");
		trace(tpl.execute(data));
	}
	
}