package ;
import haxe.Json;
import haxe.web.Dispatch;
import neko.Lib;
import neko.Web;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;

/**
 * ...
 * @author TBaudon
 */
class Installer
{

	public function new() 
	{
		try {
			Dispatch.run(Web.getURI(), Web.getParams(), this);
		}catch (e : DispatchError) {
			switch (e) {
				case DispatchError.DEInvalidValue :
					Lib.println("You didn't fill the fields correctly.");
					doDefault();
				default :
					doDefault();
			}
		}
	}
	
	function doDefault() {
		Lib.print(Macros.getContent("src/tpl/install/install.html"));
	}
	
	function doInstall(args : { username:String, password:String, email:String, sitename:String } ) {
		if (args.username.length < 4 ||
			args.password.length < 6 ||
			args.email.length < 8 ||
			args.sitename.length < 6)
			throw DispatchError.DEInvalidValue;
		
		var config = Json.stringify(args);
		var fname = ".conf/config.json";
		try {
			FileSystem.createDirectory(".conf/");
		}catch (e : Dynamic)
		{
			trace(e);
		}
		try {
		var out = File.write(fname, false);
		out.writeString(config);
		out.close();
		}catch (e : Dynamic)
		{
			trace(e);
		}
	}
	
}