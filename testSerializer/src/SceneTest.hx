package src;

import openfl.display.DisplayObjectContainer;

/**
 * ...
 * @author Thomas B
 */
class SceneTest {
	
	var comps : Array<CompTest>;

	public function new() {
		var sprites = ["img/icoa.png", "img/icob.png"];
		
		comps = new Array<CompTest>();
		
		for (i in 0 ... 10) {
			var comp = new CompTest();
			comp.x = Std.random(400);
			comp.y = Std.random(400);
			comp.sprite = sprites[Std.random(sprites.length)];
			comps.push(comp);
		}
	}
	
	public function draw(container : DisplayObjectContainer) {
		for (comp in comps) {
			container.addChild(comp.getBmp());
		}
	}
	
}