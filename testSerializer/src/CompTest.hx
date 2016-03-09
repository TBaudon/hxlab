package src;

import haxe.Serializer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.Assets;

/**
 * ...
 * @author Thomas B
 */
class CompTest {
	
	@:isVar
	public var sprite(default, set) : String;
	
	public var x : Float;
	public var y : Float;
	
	public var scene : SceneTest;

	var bitmapInstance : Bitmap;
	
	public function new() {
		x = 0;
		y = 0;
	}
	
	public function set_sprite(path : String) : String {
		sprite = path;
		bitmapInstance = new Bitmap(Assets.getBitmapData(sprite));
		bitmapInstance.x = x;
		bitmapInstance.y = y;
		return path;
	}
	
	public function getBmp() : Bitmap {
		return bitmapInstance;
	}
	
	@:keep
	function hxSerialize(s:Serializer) {
		s.serialize(x);
		s.serialize(y);
		s.serialize(scene);
		s.serialize(sprite);
	}
	
	@keep
	function hxUnserialize(u:Unserializer) {
		x = u.unserialize();
		y = u.unserialize();
		scene = u.unserialize();
		sprite = u.unserialize();
	}
	
}