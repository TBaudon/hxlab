package engine;
import engine.geom.Vector2;

/**
 * ...
 * @author Thomas BAUDON
 */
class Body
{
	
	public var mass : Float;
	
	public var next : Body;
	public var prev : Body;
	
	public var pos : Vector2;
	
	public var velocity : Vector2;
	public var angularVelocity : Vector2;
	
	public var shapes : Array<Shape>;
	
	var mApplyingForces : Array<Vector2>;

	public function new() 
	{
		mApplyingForces = new Array<Vector2>;
		
		velocity = new Vector2();
		pos = new Vector2();
		angularVelocity = 0;
		
		
		shapes = new Array<Shape>();
	}
	
}