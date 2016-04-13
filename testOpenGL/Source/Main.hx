package;

import lime.app.Application;
import lime.graphics.Renderer;
import lime.ui.Window;

import lime.graphics.opengl.GL;
import lime.math.Matrix4;
import lime.system.System;

class Main extends Application {
	

	var mInited : Bool = false;
	
	var mGiraffe : Drawable;
	var mHippo : Drawable;

	var mLastTime : UInt;
	
	var mProjectionMatrix : Matrix4;
	var mCameraMatrix : Matrix4;
	
	public function new () {
		super ();
		
		mLastTime = 0;
	}
	
	override public function onWindowCreate(window:Window):Void {
		super.onWindowCreate(window);
		mProjectionMatrix = Matrix4.createOrtho(0, window.width, window.height, 0, -1000, 1000);
		mCameraMatrix = new Matrix4();
		mCameraMatrix.appendTranslation( 100, 100, 0);
	}
	
	override public function onPreloadComplete():Void {
		super.onPreloadComplete();
		init();
	}
	
	function init() {
		
		mGiraffe = new Drawable(Material.get("assets/materials/wavyGiraffe.json"));
		mGiraffe.mesh = Mesh.Plane(128, 128);
		
		mHippo = new Drawable(Material.get("assets/materials/hippo.json"));
		mHippo.mesh = Mesh.Plane(64, 64);
		
		GL.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);
		GL.enable(GL.BLEND);
		
		mInited = true;
		
		mLastTime = System.getTimer();
	}
	
	public override function render( renderer:Renderer ) : Void {
		
		if (mInited) {
			GL.viewport(0, 0, window.width, window.height);
			
			var r = ((config.windows[0].background >> 16) & 0xFF) / 0xFF;
			var g = ((config.windows[0].background >> 8) & 0xFF) / 0xFF;
			var b = (config.windows[0].background & 0xFF) / 0xFF;
			var a = ((config.windows[0].background >> 24) & 0xFF) / 0xFF;
			
			GL.clearColor(r, g, b, a);
			GL.clear(GL.COLOR_BUFFER_BIT);
			
			mHippo.rotation += 1;
			
			mGiraffe.draw(mProjectionMatrix, mCameraMatrix);
			mHippo.draw(mProjectionMatrix, mCameraMatrix);
			
		}
		
		var time = System.getTimer();
		Time.deltaTime = (time - mLastTime) / 1000;
		Time.globalTime += Time.deltaTime;
		
		mLastTime = time;
	}
}