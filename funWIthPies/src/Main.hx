package;

import cpp.Lib;

/**
 * ...
 * @author TBaudon
 */
class Main {
	
	// Pi = SUMk=0 to infinity 16-k [ 4/(8k+1) - 2/(8k+4) - 1/(8k+5) - 1/(8k+6) ].
	
	static function main() {
		
		var pi : Float = 0;
		
		var start = 0;
		
		for (k in start ... 3) {
			pi += Math.pow(16, -k) * (4 / (8 * k + 1) - 2 / (8 * k + 4) - 1 / (8 * k + 5) - 1 / (8 * k + 6) );
		}
		
		
		
		trace(pi);
		
	}
	
}


