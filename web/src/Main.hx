package ;

import haxe.io.Path;
import haxe.web.Dispatch;
import neko.Lib;
import neko.Random;
import neko.Web;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileSeek;
import sys.io.Process;

/**
 * ...
 * @author TBaudon
 */

class Main 
{
	
	public static var WEB_DIR : String;
	public static var ROOT : String;
	
	function new() {
		trace("It works.");
		return;
		WEB_DIR = Web.getCwd();
		trace(Path.withoutDirectory(WEB_DIR));
		
		if (checkIfConfigured()) 
			trace("salut");
		else
			new Installer();
	}
	
	function checkIfConfigured () : Bool 
	{
		var fName = ".conf/config.json";
		return FileSystem.exists(fName);
	}
	
	static function main() 
	{
		new Main();
	}
	
}