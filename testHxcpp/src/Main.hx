package ;

import cpp.Lib;

/**
 * ...
 * @author Thomas BAUDON
 */

class Main 
{
	static var sum : Int->Int->Int = Lib.load("test", "sum", 2);
	static function main() 
	{
		trace(sum(1,2));
	}
	
}