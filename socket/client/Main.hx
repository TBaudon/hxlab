package ;

import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import openfl.Lib;

import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author TBaudon
 */

class Main extends Sprite 
{
	
	var mServer : Server;
	var mScript : String;
	var mEntity : Sprite;
	
	var mParser : Parser;
	var mInterp : TestInterp;
	var mAst : Expr;
	
	public var data : Dynamic;
	var test : Sprite;
	
	public function new() {
		super();
		
		initServer();
		
		mEntity = new Sprite();
		mEntity.graphics.beginFill(0xff0000);
		mEntity.graphics.drawCircle(0, 0, 25);
		//addChild(mEntity);
		
		mParser = new Parser();
		mParser.allowJSON = true;
		mParser.allowTypes = true;
		
		test = new Sprite();
		
		data = { };
		
		mInterp = new TestInterp();
		mInterp.variables["this"] = this;
		mInterp.variables.set("Math", Math);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	function onEnterFrame(e:Event):Void 
	{
		if (mAst != null) {
			try {
				mInterp.variables.get('update')(Lib.getTimer());
			}catch (e : Dynamic) {
				trace(e);
			}
		}
	}
	
	function interpScript() 
	{
		try {
			mAst = mParser.parseString(mScript);
			mInterp.execute(mAst);
		}catch ( e : Error) {
			trace(e.getName());
		}
		
		if (mAst != null) {
			try {
				mInterp.variables.get('init')();
			}catch (e : Dynamic) {
				trace(e);
			}
		}
	}
	
	function onMessage(e:ServerEvent):Void 
	{
		var message = e.data;
		var messageCode : String = message.code;
		switch(messageCode) {
			case "scriptUpdate" : 
				mScript = message.script;
				interpScript();
				trace("script updated");
		}
	}
	
	function onError(e:ServerEvent):Void 
	{
		trace("error");
	}
	
	function onConnected(e:ServerEvent):Void 
	{
		trace("connected");
	}
	
	function initServer():Void 
	{
		mServer = new Server(Macros.getBuilderIp(), 5000);
		mServer.addEventListener(ServerEvent.CONNECTED, onConnected);
		mServer.addEventListener(ServerEvent.ERROR, onError);
		mServer.addEventListener(ServerEvent.MESSAGE, onMessage);
	}
}
