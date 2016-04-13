package;
import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLBuffer;
import lime.math.Matrix4;
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
	
	var mMesh : Mesh;
	
	var mVertexBuffer : GLBuffer;
	var mIndexBuffer : GLBuffer;
	
	var mBufferUsage : Int = GL.STATIC_DRAW;
	
	var mTransform : Matrix4;
	
	var mNeedMatrixCompute : Bool = true;
	
	public function new(_material : Material) {
		
		mVertexBuffer = GL.createBuffer();
		mIndexBuffer = GL.createBuffer();
		
		mTransform = new Matrix4();
		
		material = _material;
	}
	
	public function draw(projection : Matrix4, camera : Matrix4) {
		GL.bindBuffer(GL.ARRAY_BUFFER, mVertexBuffer);
		GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, mIndexBuffer);
		
		if(mNeedMatrixCompute){
			mTransform.identity();
			
			mTransform.appendRotation(rotation, Vector4.Z_AXIS);
			
			mNeedMatrixCompute = false;
		}
		
		material.update();
		
		material.shader.setUniform("projection", projection);
		material.shader.setUniform("camera", camera);
		material.shader.setUniform("transform", mTransform);
		
		#if desktop
		GL.enable(GL.TEXTURE_2D);
		#end
			
		GL.drawElements(GL.TRIANGLES, 6, GL.UNSIGNED_SHORT, 0);
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
	
}