package ;

import cpp.Lib;
import hscript.Interp;
import hscript.Parser;
import sys.io.File;

/**
 * ...
 * @author Thomas B
 */

class Main 
{
	
	static function main() 
	{
		new Main();
	}
	
	dynamic public function test() {
		trace("test");
	}
	
	public function testO() {
		trace("test O");
	}
	
	public function new() {
		test();
		this.test = this.testO;
		test();
		
		var script = File.getContent('scripts/test.hx');
		
		var inter = new Interp();
		inter.variables.set("this", this);
		var parser = new Parser();
		var ast = parser.parseString(script);
		inter.execute(ast);
		
		this.test = inter.variables.get('testScript');
		this.test();
		
	}
	
}