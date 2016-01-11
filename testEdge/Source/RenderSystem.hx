package;

import edge.Entity;
import edge.ISystem;
import openfl.display.Sprite;
import openfl.Lib;

/**
 * ...
 * @author Thomas B
 */
class RenderSystem implements ISystem{

	public function updateAdded(entity : Entity, data : { t : Transform, d : Sprite } ) {
		Lib.current.stage.addChild(data.d);
	}
	
	public function update(t : Transform, d : Sprite) {
		d.x = t.x;
		d.y = t.y;
	}
	
}