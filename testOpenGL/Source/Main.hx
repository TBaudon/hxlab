package;

import lime.app.Application;
import lime.graphics.opengl.GLFramebuffer;
import lime.graphics.opengl.GLRenderbuffer;
import lime.graphics.Renderer;
import lime.math.Matrix3;
import lime.math.Vector2;
import lime.ui.Window;

import lime.graphics.opengl.GL;
import lime.math.Matrix4;
import lime.system.System;

class Main extends Application {
	

	var mInited : Bool = false;

	var mLastTime : UInt;
	
	var mProjectionMatrix : Matrix3;
	var mCameraMatrix : Matrix3;
	var mIdentity : Matrix3;
	
	var mGiraffes : Array<Giraffe>;
	
	var mMoy : Float = 0;
	var mCount : UInt = 0;
	var mFrameBuffer : GLFramebuffer;
	var mRenderTexture : Texture;
	var mRenderbuffer : GLRenderbuffer;
	
	var mRenderPlane : Drawable;
	var mNbObj : UInt = 100;
	
	var mResolution : Float = 0.25;
	
	var mBottom : UInt;
	
	var mFboWidth : Int;
	var mFboHeight : Int;
	
	var mRenderSpaceX : Float;
	var mRenderSpaceY : Float;
	
	public function new () {
		super ();
		
		mLastTime = 0;
	}
	
	override public function onWindowCreate(window:Window):Void {
		super.onWindowCreate(window);
		
		mProjectionMatrix = new Matrix3();
		
		mBottom = window.height;
		
		mFboWidth = Std.int(window.width * mResolution);
		mFboHeight = Std.int(window.height * mResolution);
		
		mRenderSpaceX = window.width;
		mRenderSpaceY = window.height;
		
		var scaleX = 1 / (mRenderSpaceX / 2) * mResolution;
		var scaleY = -1 / (mRenderSpaceY / 2) * mResolution;
		
		mProjectionMatrix.scale(scaleX, scaleY);
		mProjectionMatrix.translate(-(1 - mResolution) -1 * mResolution, -(1 -mResolution) + 1 * mResolution);
		
		mCameraMatrix = new Matrix3();
		
		mIdentity = new Matrix3();
	}
	
	override public function onPreloadComplete():Void {
		super.onPreloadComplete();
		init();
	}
	
	function init() {
		mGiraffes = new Array<Giraffe>();
		for (i in 0 ... mNbObj)
			mGiraffes.push(new Giraffe(window.width, window.height));
			
		GL.enable(GL.BLEND);
		GL.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);
		
		mFrameBuffer = GL.createFramebuffer();
		GL.bindFramebuffer(GL.FRAMEBUFFER, mFrameBuffer);
		
		var bufferHeight = Std.int(mFboHeight);
		mRenderTexture = new Texture(mFboWidth, mFboHeight, GL.NEAREST);
		mRenderTexture.use();
		
		mRenderbuffer = GL.createRenderbuffer();
		GL.bindRenderbuffer(GL.RENDERBUFFER, mRenderbuffer);
		GL.renderbufferStorage(GL.RENDERBUFFER, GL.DEPTH_COMPONENT16, mFboWidth, mFboHeight);
		
		GL.framebufferTexture2D(GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, GL.TEXTURE_2D, mRenderTexture.getGlTexture(), 0);
		GL.framebufferRenderbuffer(GL.FRAMEBUFFER, GL.DEPTH_ATTACHMENT, GL.RENDERBUFFER, mRenderbuffer);
		
		GL.bindTexture(GL.TEXTURE_2D, null);
		GL.bindRenderbuffer(GL.RENDERBUFFER, null);
		GL.bindFramebuffer(GL.FRAMEBUFFER, null);
		
		var toTextureMat = Material.get("assets/materials/fbo.json");
		toTextureMat.setTexture("uImage0", mRenderTexture);
		
		mRenderPlane = new Drawable(toTextureMat, Mesh.Plane2D(2, 2));
		
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
			
			GL.clearColor(0.3, 0.3, 0.3, a);
			GL.clear(GL.COLOR_BUFFER_BIT);
			
			GL.bindFramebuffer(GL.FRAMEBUFFER, mFrameBuffer);
			
			GL.clearColor(0,0,0,0.5);
			GL.clear(GL.COLOR_BUFFER_BIT);
			
			for (giraffe in mGiraffes)
				giraffe.draw(mProjectionMatrix, mCameraMatrix);
			
			GL.bindFramebuffer(GL.FRAMEBUFFER, null);
			
			mRenderPlane.draw(mIdentity, mIdentity);
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