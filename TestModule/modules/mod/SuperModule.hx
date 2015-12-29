package mod;

import mod.Module;

/**
 * ...
 * @author Thomas B
 */
class SuperModule extends Module{

	public function new() {
		super();
		trace("le super module est là!");
	}
	
	override public function update() {
		trace("update du super module!");
	}
	
}