package;

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
	
}