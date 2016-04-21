package;
import lime.math.Matrix3;
import lime.math.Matrix4;

/**
 * ...
 * @author TBaudon
 */
class Giraffe extends Drawable {

	var mRotatinSpeed : Float;
	
	public function new(w : Int, h : Int) {
		super(Material.get("assets/materials/giraffe.json"));
		
		var size = Std.random(256 - 32) + 32;
		
		x = Std.random(w);
		y = Std.random(h);
		
		mRotatinSpeed = Math.random() * 30 - 15;
		
		mesh = Mesh.Plane2D(250, 250);
	}
	
	override public function draw(projection:Matrix3, camera:Matrix3) {
		
		rotation += mRotatinSpeed;
		
		super.draw(projection, camera);
	}
	
}