package;

/**
 * ...
 * @author TBaudon
 */

import haxe.Json;

@:build(Macros.addSerialize())
class RandomClass {

	public var test : String;
	public var a : Int;

	var mPrivate : String;	
	
		
	public function new(test : String, a : Int) {
		
		this.test = test;
		this.a = a;
		
		mPrivate = "this should not be serialized";
		
	}
	
	public function doSomething() {
		trace("Hello i'm doing something.");
	}
	
}