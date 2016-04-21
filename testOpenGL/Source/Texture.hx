package;

import lime.Assets;
import lime.graphics.Image;
import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLTexture;

/**
 * ...
 * @author TBaudon
 */
class Texture {
	
	static var mTextureMap : Map<String, Texture>;
	static var mLoadedTexture : Array<Texture> = new Array<Texture>();

	public static function get(path : String) : Texture {
		if (mTextureMap == null)
			mTextureMap = new Map<String, Texture>();
			
		var texture = mTextureMap[path];
		if (texture == null){
			texture = new Texture();
			texture.loadImage(path);
			mTextureMap[path] = texture;
		}
		
		return texture;
	}
	
	static var mNbTexture : UInt = 0;
	
	var mImage : Image;
	var mGlTexture : GLTexture;
	var mId : UInt;
	
	public function new(width : UInt = 0, height : UInt = 0) {
		mId = mNbTexture;
		mNbTexture++;
		
		mGlTexture = GL.createTexture();
		
		GL.bindTexture(GL.TEXTURE_2D, mGlTexture);
		
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
		
		if (width != 0 && height != 0)
			GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA, width,height, 0, GL.RGBA, GL.UNSIGNED_BYTE, null);
		
		GL.bindTexture(GL.TEXTURE_2D, null);
	}
	
	public function getId() : UInt {
		return mId;
	}
	
	public function use() {
		GL.bindTexture(GL.TEXTURE_2D, mGlTexture);
	}
	
	public function loadImage(path : String) {
		if (mLoadedTexture.indexOf(this) == -1 ) {
			
			mImage = Assets.getImage(path);
			
			GL.bindTexture(GL.TEXTURE_2D, mGlTexture);
			GL.texImage2D(GL.TEXTURE_2D, 0, GL.RGBA, mImage.buffer.width, mImage.buffer.height, 0, GL.RGBA, GL.UNSIGNED_BYTE, mImage.data);
			GL.bindTexture(GL.TEXTURE_2D, null);
		}
	}
	
	public function unload() {
		if(mLoadedTexture.indexOf(this) != -1 ) {
			GL.deleteTexture(mGlTexture);
		}
	}
	
	public function getGlTexture() : GLTexture {
		return mGlTexture;
	}
	
}