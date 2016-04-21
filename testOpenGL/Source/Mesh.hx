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
	var mCoordPerVert : UInt;
	
	public static function Plane(width : Float, height : Float) : Mesh {
		
		var vertices = [
		
			-width/2, -height/2, 0.0,
			width/2, -height/2, 0.0,
			width/2, height/2, 0.0,
			-width/2, height/2, 0.0
			
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
	
	public static function Cube(size : Float) : Mesh {
		
		var vertices = [
		
			-size/2, -size/2, -size/2,
			size/2, -size/2, -size/2,
			size/2, size/2, -size/2,
			-size/2, size/2, -size/2,
			
			-size/2, -size/2, size/2,
			size/2, -size/2, size/2,
			size/2, size/2, size/2,
			-size/2, size/2, size/2
		];
		
		var textureCoords = [
		
			0.0, 0.0,
			1.0, 0.0,
			1.0, 1.0,
			0.0, 1.0,
			
			0.0, 0.0,
			1.0, 0.0,
			1.0, 1.0,
			0.0, 1.0
		];
		
		var indexes = [
		
			0, 1, 2,
			2, 3, 0,
			
			4, 5, 6,
			6, 7, 4
			
		];
		
		return new Mesh(vertices, textureCoords, indexes);
	}
	
	public static function Plane2D(width : Float, height : Float) : Mesh {
		var vertices = [
		
			-width / 2, -height / 2,
			width / 2, -height / 2,
			width / 2, height / 2, 
			-width / 2, height / 2
			
		];
		
		var textureCoords = [
		
			0.0, 0.0,
			1.0, 0.0,
			1.0, 1.0,
			0.0, 1.0,

		];
		
		var indexes = [
		
			0, 1, 2,
			2, 3, 0,

		];
		
		return new Mesh(vertices, textureCoords, indexes, true);
	}
	

	public function new(_vertices : Array<Float> = null, 
						_textureCoords : Array<Float> = null,
						_indexes : Array<UInt> = null,
						_is2d : Bool = false) {
		
		mVertices = new Array<Float>();
		mTextureCoords = new Array<Float>();
		mVertexData = new Array<Float>();
		mCoordPerVert = _is2d ? 2 : 3;
							
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
			dataPerVertices += mCoordPerVert;
			mNbVertices = cast mVertices.length / mCoordPerVert;
		}
		
		if (mTextureCoords.length > 0)
			dataPerVertices += 2;
			
		var vertexDataLength = dataPerVertices * mNbVertices;
		
		for (i in 0 ... vertexDataLength) {
		
			var j : UInt = Std.int(i / dataPerVertices);
			var index = i % dataPerVertices;
			var data : Float = 0;
			
			if (index >= 0 && index <= mCoordPerVert - 1)
				data = mVertices[j * mCoordPerVert + index];
			else if (index >= mCoordPerVert && index <= mCoordPerVert + 1)
				data = mTextureCoords[j * 2 + index - mCoordPerVert]; 
				
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