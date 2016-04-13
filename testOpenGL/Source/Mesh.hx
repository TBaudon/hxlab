package;
import haxe.crypto.Hmac.HashMethod;

/**
 * ...
 * @author TBaudon
 */
class Mesh {
	
	public var vertices(default, set) : Array<Float>;
	public var textureCoords(default, set) : Array<Float>;
	public var verticesData(get, null) : Array<Float>;
	public var indexes : Array<UInt>;
	public var nbVertices(default, null) : UInt;
	
	var mVertices : Array<Float>;
	var mTextureCoords : Array<Float>;
	
	var mVertexData : Array<Float>;
	
	var mNbVertices : UInt;
	
	public static function Plane(width : Float, height : Float) : Mesh {
		
		var vertices = [
		
			0.0, 0.0, 0.0,
			width, 0.0, 0.0,
			width, height, 0.0,
			0.0, height, 0.0
			
		];
		
		var textureCoords = [
		
			0.0, 0.0,
			1.0, 0.0,
			1.0, 1.0,
			0.0, 1.0
			
		];
		
		var indexes = [
		
			0, 1, 2,
			2, 3, 0
			
		];
		
		return new Mesh(vertices, textureCoords, indexes);
	}
	

	public function new(_vertices : Array<Float> = null, 
						_textureCoords : Array<Float> = null,
						_indexes : Array<UInt> = null) {
		
		mVertices = new Array<Float>();
		mTextureCoords = new Array<Float>();
		mVertexData = new Array<Float>();
							
		if (_vertices == null)
			_vertices = new Array<Float>();
		vertices = _vertices;
		
		if (_textureCoords == null)
			_textureCoords = new Array<Float>();
		textureCoords = _textureCoords;
		
		if (_indexes == null)
			_indexes = new Array<UInt>();
		indexes = _indexes;
		
	}
	
	function makeVertexData() {
		mNbVertices = 0;
		
		var dataPerVertices = 0;
		
		if (mVertices.length > 0) {
			dataPerVertices += 3;
			mNbVertices = cast mVertices.length / 3;
		}
		
		if (mTextureCoords.length > 0)
			dataPerVertices += 2;
			
		var vertexDataLength = dataPerVertices * mNbVertices;
		
		for (i in 0 ... vertexDataLength) {
		
			var j : UInt = Std.int(i / dataPerVertices);
			var index = i % dataPerVertices;
			var data : Float = 0;
			
			if (index >= 0 && index <= 2)
				data = mVertices[j * 3 + index];
			else if (index >= 3 && index <= 4)
				data = mTextureCoords[j * 2 + index - 3]; 
				
			if (i < mVertexData.length)
				mVertexData[i] = data;
			else
				mVertexData.push(data);
		}
	}
	
	public function set_vertices(vertices : Array<Float>) : Array<Float> {
		mVertices = vertices;
		makeVertexData();
		return vertices;
	}
	
	public function set_textureCoords(coords : Array<Float>) : Array<Float> {
		mTextureCoords = coords;
		makeVertexData();
		return coords;
	}
	
	public function get_verticesData() : Array<Float> {
		return mVertexData;
	}
	
	
}