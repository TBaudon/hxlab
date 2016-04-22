package;
import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLBuffer;
import lime.math.Matrix3;
import lime.math.Matrix4;
import lime.math.Vector2;
import lime.math.Vector4;
import lime.utils.Float32Array;
import lime.utils.UInt16Array;

/**
 * ...
 * @author TBaudon
 */
class Drawable {
	
	public var mesh(default, set) : Mesh;
	public var material : Material;
	
	@:isVar public var rotation(default, set) : Float = 0.0;
	
	@:isVar public var x(default, set) : Float = 0.0;
	@:isVar public var y(default, set) : Float = 0.0;
	@:isVar public var z(default, set) : Float = 0.0;
	
	@:isVar public var scaleX(default, set) : Float = 1.0;
	@:isVar public var scaleY(default, set) : Float = 1.0;
	
	var mMesh : Mesh;
	
	var mVertexBuffer : GLBuffer;
	var mIndexBuffer : GLBuffer;
	
	var mBufferUsage : Int = GL.STATIC_DRAW;
	
	var mTransform : Matrix3;
	var mMatrix3ConvertionArray : Float32Array;
	
	var mNeedMatrixCompute : Bool = true;
	
	public function new(_material : Material, _mesh : Mesh = null) {
		
		mVertexBuffer = GL.createBuffer();
		mIndexBuffer = GL.createBuffer();
		
		if (_mesh != null)
			mesh = _mesh;
		
		mTransform = new Matrix3();
		mMatrix3ConvertionArray = new Float32Array([
			1, 0, 0,
			0, 1, 0,
			0, 0, 1
		]);
		
		material = _material;
	}
	
	public function draw(projection : Matrix3, camera : Matrix3) {
		GL.bindBuffer(GL.ARRAY_BUFFER, mVertexBuffer);
		GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, mIndexBuffer);
		
		if(mNeedMatrixCompute){
			mTransform.identity();
			
			mTransform.scale(scaleX, scaleY);
			mTransform.rotate(rotation / 360 * Math.PI);
			mTransform.translate(x, y);
			
			mNeedMatrixCompute = false;
		}
		
		material.update();
		
		material.shader.setUniform("projection", convertMatrix3ToArray32(projection));
		material.shader.setUniform("camera", convertMatrix3ToArray32(camera));
		material.shader.setUniform("transform", convertMatrix3ToArray32(mTransform));
		
		#if desktop
		GL.enable(GL.TEXTURE_2D);
		#end
			
		GL.drawElements(GL.TRIANGLES, mMesh.indexes.length, GL.UNSIGNED_SHORT, 0);
	}
	
	public function set_mesh(mesh : Mesh) : Mesh {
		
		mMesh = mesh;
		
		GL.bindBuffer(GL.ARRAY_BUFFER, mVertexBuffer);
		GL.bufferData(GL.ARRAY_BUFFER, new Float32Array(mMesh.verticesData), mBufferUsage);
		GL.bindBuffer(GL.ARRAY_BUFFER, null);
		
		GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, mIndexBuffer);
		GL.bufferData(GL.ELEMENT_ARRAY_BUFFER, new UInt16Array(mMesh.indexes), mBufferUsage);
		GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, null);		
		
		return mMesh;
	}
	
	public function set_rotation(value : Float) : Float {
		rotation = value;
		mNeedMatrixCompute = true;
		return rotation;
	}
	
	public function set_x(value : Float) : Float {
		x = value;
		mNeedMatrixCompute = true;
		return x;
	}
	
	public function set_y(value : Float) : Float {
		y = value;
		mNeedMatrixCompute = true;
		return y;
	}
	
	public function set_z(value : Float) : Float {
		z = value;
		mNeedMatrixCompute = true;
		return z;
	}
	
	public function set_scaleX(value : Float) : Float {
		scaleX = value;
		mNeedMatrixCompute = true;
		return scaleX;
	}
	
	public function set_scaleY(value : Float) : Float {
		scaleX = value;
		mNeedMatrixCompute = true;
		return scaleY;
	}
	
	function convertMatrix3ToArray32(matrix : Matrix3) : Float32Array {
		mMatrix3ConvertionArray[0] = matrix.a;
		mMatrix3ConvertionArray[1] = matrix.b;
		mMatrix3ConvertionArray[2] = 0;
		
		mMatrix3ConvertionArray[3] = matrix.c;
		mMatrix3ConvertionArray[4] = matrix.d;
		mMatrix3ConvertionArray[5] = 0;
		
		mMatrix3ConvertionArray[6] = matrix.tx;
		mMatrix3ConvertionArray[7] = matrix.ty;
		mMatrix3ConvertionArray[8] = 1;
		
		return mMatrix3ConvertionArray;
	}
	
}