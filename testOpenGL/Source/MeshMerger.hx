package;

/**
 * ...
 * @author TBaudon
 */
class MeshMerger extends Mesh {
	
	var mMeshPos : Map<Mesh, UInt>;
	var mMesh : Array<Mesh>;

	public function new(_is2d : Bool = false) {
		super(null, null, null, _is2d);
		
		vertices = new Array<Float>();
		textureCoords = new Array<Float>();
		indexes = new Array<UInt>();
		
		mMesh = new Array<Mesh>();
		mMeshPos = new Map<Mesh, UInt>();
		
		
	}
	
	public function addMesh(mesh : Mesh) {
		mMesh.push(mesh);
	}
	
}