package;

import lime.app.Application;
import lime.graphics.Renderer;
import lime.math.Matrix3;
import lime.ui.Window;

import lime.graphics.opengl.GL;
import lime.math.Matrix4;
import lime.system.System;

class Main extends Application {
	

	var mInited : Bool = false;

	var mLastTime : UInt;
	
	var mProjectionMatrix : Matrix3;
	var mCameraMatrix : Matrix3;
	
	var mGiraffes : Array<Giraffe>;
	
	var mMoy : Float = 0;
	var mCount : UInt = 0;
	
	public function new () {
		super ();
		
		mLastTime = 0;
	}
	
	override public function onWindowCreate(window:Window):Void {
		super.onWindowCreate(window);
		
		mProjectionMatrix = new Matrix3();
		mProjectionMatrix.scale(1 / (window.width*0.5), -1 /( window.height*0.5));
		mProjectionMatrix.translate(-1, 1);
		
		mCameraMatrix = new Matrix3();
		//mCameraMatrix.rotate(100);
	}
	
	override public function onPreloadComplete():Void {
		super.onPreloadComplete();
		init();
	}
	
	function init() {
		mGiraffes = new Array<Giraffe>();
		for (i in 0 ... 1000)
			mGiraffes.push(new Giraffe(window.width, window.height));
			
		GL.enable(GL.BLEND);
		GL.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);
		
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
			
			for (giraffe in mGiraffes)
				giraffe.draw(mProjectionMatrix, mCameraMatrix);
			
		}
		
		var time = System.getTimer();
		Time.deltaTime = (time - mLastTime) / 1000;
		Time.globalTime += Time.deltaTime;
		Time.framerate = 1 / Time.deltaTime;
		
		mMoy += Time.framerate;
		mCount++;
		
		if (mCount == 60) {
			mMoy = Time.framerate;
			mCount = 1;
			trace(mMoy);
		}
		
		mLastTime = time;
	}
}