package;

import haxe.Json;
import js.html.Text;
import lime.Assets;
import lime.graphics.Image;
import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLTexture;
import lime.system.System;

/**
 * ...
 * @author TBaudon
 */
class Material {
	
	static var mMaterialMap : Map<String, Material>;
	
	public static function get(path : String) : Material {
		if (mMaterialMap == null) 
			mMaterialMap = new Map<String, Material>();
			
		if (mMaterialMap[path] == null)
			mMaterialMap[path] = loadMaterial(path);
			
		return mMaterialMap[path];
	}
	
	static function loadMaterial(path : String) : Material {
		var material = new Material(path);
		return material;
	}
	
	public var shader(get, null) : Shader;
	
	var mShader : Shader;
	var mTextures : Map<String, {texture : Texture, unit : Int}>;
	var mParams : Array<{type : String, name : String, value : Dynamic}>;
	var mNbTextures : UInt = 0;

	function new(path : String) {
		
		var data = Json.parse(Assets.getText(path));
		
		mShader = Shader.get(data.shader);
		mParams = data.params;
		
		mTextures = new Map<String, {texture : Texture, unit : Int}>();
		
		for (param in mParams) {
			if (param.type == "texture") {
				var texture : Texture;
				
				if(param.value != null && param.value != "")
					texture = Texture.get(param.value);
				else
					texture = new Texture();
				
				mTextures[param.name] = { texture : texture, unit : mNbTextures };
				mNbTextures++;
			}
		}
	}
	
	public function setTexture(name : String, value : Texture) {
		var texture = mTextures[name];
		texture.texture = value;
	}
	
	public function update() {
		mShader.use();
		for (param in mParams) {
			if (param.type != "texture")
				mShader.setUniform(param.name, param.value);
			else {
				var tex = mTextures[param.name];
				tex.texture.use();
				mShader.setUniform(param.name, tex.unit);
				GL.activeTexture(GL.TEXTURE0 + tex.unit);
			}
		}
		
		mShader.setUniform("uTime", Time.globalTime);
		
		mShader.setPointers();
	}
	
	public function get_shader() : Shader {
		return mShader;
	}
	
	
}