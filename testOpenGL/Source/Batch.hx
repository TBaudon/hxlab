package;
import lime.math.Matrix4;

/**
 * ...
 * @author TBaudon
 */
class Batch extends Drawable {

	var mChildren : Array<Drawable>;

	public function new(mat : Material) {
		super(mat);
		
		mChildren = new Array<Drawable>();	
	}
	
	public function add(d : Drawable) {
		if (mChildren.indexOf(d) == -1){
			mChildren.push(d);
		}
	}
	
	public function remove(d : Drawable) {
		mChildren.remove(d);
	}
	
	override public function draw(projection:Matrix4, camera:Matrix4) {
		prepare();
		super.draw(projection, camera);
	}
	
	function prepare() {
		
	}
	
}