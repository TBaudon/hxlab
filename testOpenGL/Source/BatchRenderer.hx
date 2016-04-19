package;

/**
 * ...
 * @author TBaudon
 */
class BatchRenderer {
	
	var mBatches : Map<Material, Batch>;

	public function new() {
		mBatches = new Map<Material, Batch>();
	}
	
	public function add(d : Drawable) {
		var batch = mBatches[d.material];
		
		if (batch == null) {
			batch = new Batch(null);
			batch.material = d.material;
		}
		
		batch.add(d);
	}
	
	public function remove(d : Drawable) {
		var batch = mBatches[d.material];
		if (batch != null)
			batch.remove(d);
	}
	
	public function render() {
		
	}
	
}