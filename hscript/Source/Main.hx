package;


import openfl.Assets;
import openfl.display.Sprite;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		addChild(new Entity("scripts/test.hx"));
		
	}
	
	
}