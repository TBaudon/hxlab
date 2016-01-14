package;

import edge.Entity;
import edge.ISystem;
import edge.View;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author Thomas B
 */
class RenderSystem implements ISystem {
	
	var target : View<{t : Transform}>;

	public function updateAdded(entity : Entity, data : { t : Transform, d : Sprite } ) {
		Lib.current.stage.addChild(data.d);
	}
	
	public function update(t : Transform, d : Sprite) {
		d.x = t.x;
		d.y = t.y;
		
		for (a in target) {
			trace(a);
		}
	}
	
}