package;

import haxe.Serializer;
import haxe.Unserializer;
import src.SceneTest;

import openfl.display.Sprite;
import openfl.Lib;
import src.CompTest;
import sys.io.File;

/**
 * ...
 * @author Thomas B
 */

class Main extends Sprite {

	public function new() {
		super();
		
		var scene = new SceneTest();
		
		var serializer : Serializer = new Serializer();
		serializer.useCache = true;
		serializer.serialize(scene);
		
		File.saveContent("test", serializer.toString());
		
		/*var unserializer : Unserializer = new Unserializer(File.getContent("test"));
		var scene : SceneTest = unserializer.unserialize();*/
		
		scene.draw(this);
	}
}
