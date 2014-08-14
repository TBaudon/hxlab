package ;

import haxe.io.Path;
import sys.FileSystem;

#if neko
import neko.vm.Loader;
import neko.Web;
#elseif php
import php.Web;
import php.Lib;
#end

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
	
	public function new() {
		trace("Test module : ");
		
		var moduleC = getModule('test');
		var obj = createInstance(moduleC);
		obj.run();
	}
	
	#if neko
	static function loadPrimitive(name:String, nargs:Int):Dynamic {
		return Loader.local().loadPrimitive(name, nargs);
	}
	
	public static function getModule(name : String) : Class<Dynamic> {
		var binPath = Web.getCwd();
		binPath = StringTools.replace(binPath, "\\", "/");		
		binPath = Path.removeTrailingSlashes(binPath);
		var modulePath = binPath.substr(0, binPath.lastIndexOf("/")) + '/module/$name.n';
		if(FileSystem.exists(modulePath)){
			var loader = Loader.make(loadPrimitive, Loader.local().loadModule);
			
			var module = loader.loadModule(modulePath);
			var classes : Dynamic = module.exportsTable().__classes;
			
			var className = name.substr(0, 1).toUpperCase() + name.substr(1, name.length).toLowerCase();
			var bundleClass = Reflect.field(classes, className);
			return bundleClass;
		}
		
		return null;
	}
	
	public static function createInstance(module : Class<Dynamic>) : Dynamic{
		return Type.createInstance(module, []);
	}
	#elseif php
	public static function getModule(name : String) : Class<Dynamic> {
		var binPath = Web.getCwd();
		binPath = StringTools.replace(binPath, "\\", "/");
		binPath = Path.removeTrailingSlashes(binPath);
		var modulePath = binPath.substr(0, binPath.lastIndexOf("/")) + '/module/$name.php';
		if (FileSystem.exists(modulePath)) {
			var className = name.substr(0, 1).toUpperCase() + name.substr(1, name.length).toLowerCase();
			Lib.loadLib(modulePath);
			return Type.resolveClass('lib.$className');
		}
		
		return null;
	}
	
	public static function createInstance(module : Class<Dynamic>) : Dynamic {
		trace(module);
		return untyped __call__('new Test', "");
	}
	#end
	
}