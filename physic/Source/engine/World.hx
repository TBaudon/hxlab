package engine;

/**
 * ...
 * @author Thomas BAUDON
 */
class World
{
	
	public var bodies : BodyList;

	public function new() 
	{
		bodies = new BodyList();
	}
	
	public function step(delta : Float) {
		
	}
	
	public function add(body : Body) {
		bodies.add(body);
	}
	
	public function remove(body : Body) {
		bodies.remove(body);
	}
	
}