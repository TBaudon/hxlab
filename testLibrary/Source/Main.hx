package;


import openfl.Assets;
import openfl.display.Sprite;


class Main extends Sprite {
	
	var mAssetLib : AssetLibrary;
	
	public function new () {
		
		super ();
		
		trace(Assets.getText("lib/test.txt"));
		
		
	}
	
	
}