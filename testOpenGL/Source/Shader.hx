package;
import haxe.Json;
import lime.Assets;
import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLProgram;
import lime.graphics.opengl.GLUniformLocation;
import lime.utils.Float32Array;
import lime.utils.GLUtils;

/**
 * ...
 * @author TBaudon
 */
class Shader {
	
	static var mShaderMap : Map<String, Shader>;
	static var mCurrentUsedShader : Shader;
	
	public static function get(path : String) {
		if (mShaderMap == null)
			mShaderMap = new Map<String, Shader>();
			
		var shader : Shader = mShaderMap[path];
		if (shader == null) {
			shader = new Shader(path);
			mShaderMap[path] = shader;
		}
		
		return shader;
	}
	
	var mGlProgram : GLProgram;
	
	var mTotatlAttributesSize : Int = 0;
	var mAttributes : Map<String, {location : Int, size : Int}>;
	var mUniforms : Map<String, {location : GLUniformLocation, type : String}>;

	function new(path) {
		var src = Assets.getText(path);
		var lines = src.split("\r\n");
		
		var attributes : Array<String> = new Array<String>();
		var uniforms : Array<String> =  new Array<String>();
		var varyings : Array<String> = new Array<String>();
		
		var variablesBloc : Map<String, Array<String>> = new Map<String, Array<String>>();
		variablesBloc["attributes"] = attributes;
		variablesBloc["uniforms"] = uniforms;
		variablesBloc["varyings"] = varyings;
		
		var shaders : Map<String, Map<String, Array<String>>> = new Map<String, Map<String, Array<String>>>();
		shaders["vertex"] = new Map<String, Array<String>>();
		shaders["fragment"] = new Map<String, Array<String>>();
		
		var currentBloc : String = null;
		var currentFunction : String = null;
		
		for (line in lines){
			
			var l : String = StringTools.replace(line, " ", String.fromCharCode(0));
			l = StringTools.replace(l, "\t", String.fromCharCode(0));
			if (l.length <= 1)
				continue;
				
			var depth = 0;
			while (line.charAt(depth) == "\t")
				depth++;
				
			if (depth == 0)
				currentBloc = line;
				
			if (depth > 0 && 
				currentBloc != "vertex" && 
				currentBloc != "fragment") {
					
				line = line.substr(1);
				var variableArray = variablesBloc[currentBloc];
				variableArray.push(line);
			} 
			
			if (currentBloc == "vertex" || currentBloc == "fragment") {
				
				if (depth == 1) {
					currentFunction = line.substr(1);
					shaders[currentBloc][currentFunction] = new Array<String>();
				}else if (depth > 1){
					var l = line.substr(2);
					shaders[currentBloc][currentFunction].push(l);
				}
			}
			
			
		}
		
		var vertexSrc = "";
		var fragmentSrc = "";
		
		for (func in shaders["vertex"].keys()) {
			vertexSrc += func + "{\n";
			for (line in shaders["vertex"][func])
				vertexSrc += "\t" + line + ";\n";
			vertexSrc += "}";
		}
		
		for (func in shaders["fragment"].keys()) {
			fragmentSrc += func + "{\n";
			for (line in shaders["fragment"][func])
				fragmentSrc += "\t" + line + ";\n";
			fragmentSrc += "}";
		}
		
		for (varying in varyings) {
			vertexSrc = "varying " + varying + ";\n" + vertexSrc;
			fragmentSrc = "varying " + varying + ";\n" + fragmentSrc;
		}
		
		for (uniform in uniforms) {
			var parts = uniform.split(" ");
			var shaderType : String = parts.shift();
			
			if (shaderType == "vertex")
				vertexSrc = "uniform " + parts.join(" ") + ";\n" + vertexSrc;
			else
				fragmentSrc = "uniform " + parts.join(" ") + ";\n" + fragmentSrc;
		}
		
		#if !desktop
		fragmentSrc = "precision highp float;\n" + fragmentSrc; 
		#end

		for (attribute in attributes)
			vertexSrc = "attribute " + attribute + ";\n" + vertexSrc;
		
		mGlProgram = GLUtils.createProgram(vertexSrc, fragmentSrc);
		GL.useProgram(mGlProgram);
		
		mAttributes = new Map<String, {location : Int, size : Int}>();
		mUniforms = new Map<String, {location : GLUniformLocation, type : String}>();
		
		for (attribute in attributes) {
			var parts = attribute.split(" ");
			var type : String = parts[0];
			var name : String = parts[1];
			var pos : Int = GL.getAttribLocation(mGlProgram, name);
			
			var size = 0;
			
			switch(type) {
				case "vec4" :
					size = 3;
				case "vec2" :
					size = 2;
			}
			
			mAttributes[name] = { location : pos, size : size };
			mTotatlAttributesSize += size;
		}
		
		for (uniform in uniforms) {
			var parts = uniform.split(" ");
			var type = parts[1];
			var name = parts[2];
			var location : GLUniformLocation = GL.getUniformLocation(mGlProgram, name);
			mUniforms[name] = {location : location, type : type};
		}
	}
	
	public function use() {
		if (mCurrentUsedShader != null && mCurrentUsedShader != this)
			mCurrentUsedShader.unUse();
			
		mCurrentUsedShader = this;
		GL.useProgram(mGlProgram);
		
		for (key in mAttributes.keys())
			GL.enableVertexAttribArray(mAttributes[key].location);
	}
	
	public function unUse() {
		for (key in mAttributes.keys())
			GL.disableVertexAttribArray(mAttributes[key].location);
	}
	
	public function setUniform(name : String, value : Dynamic) {
		if (mCurrentUsedShader != this)
			throw "can't set data because another shader is currentyl used";
			
		var uniform : { location : GLUniformLocation, type : String } = mUniforms[name];
		if (uniform != null) {
			switch (uniform.type) {
				case "sampler2D" :
					GL.uniform1i(uniform.location, value);
				case "mat4" :
					GL.uniformMatrix4fv(uniform.location, false, value);
				case "float" :
					GL.uniform1f(uniform.location, value);
			}
		}
	}
	
	public function setPointers() {
		
		var currentOffset = 0;
		
		for (attribute in mAttributes.keys()) {
			
			var attr = mAttributes[attribute];
			var location = attr.location;
			GL.vertexAttribPointer(location, attr.size, GL.FLOAT, false, mTotatlAttributesSize * Float32Array.BYTES_PER_ELEMENT, currentOffset * Float32Array.BYTES_PER_ELEMENT);
			currentOffset += attr.size;
		}
	}
}