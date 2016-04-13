package;

import neko.Lib;
import sys.io.File;

/**
 * ...
 * @author TBaudon
 */
class Main {
	
	static function main() {
		var content : String = File.getContent("Test.txt");
		
		var reg : EReg = new EReg("//#beginGroup(.*)//#endGroup", "s");
		
		var lastMatchPos : Int = 0;
		
		var currentLength : Int = 1;
		
		var groups = new Array<String>();
		
		while (lastMatchPos + currentLength < content.length){
			var matched = reg.matchSub(content, lastMatchPos, currentLength);
			if (matched) {
				groups.push(reg.matched(1));
				lastMatchPos = lastMatchPos + currentLength;
				currentLength = 1;
			}else 
				currentLength++;
		}
			
		for (group in groups) {
			trace(group);
		}
		
	}
	
}