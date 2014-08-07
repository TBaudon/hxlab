package ;

import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import openfl.display.Sprite;
import openfl.events.Event;
import sys.io.File;

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
	var mInterp : Interp;
	var mAst : Expr;
	
	public function new() {
		super();
		
		initServer();
		initBaseScript();
		
		mEntity = new Sprite();
		mEntity.graphics.beginFill(0xff0000);
		mEntity.graphics.drawCircle(0, 0, 25);
		addChild(mEntity);
		
		mParser = new Parser();
		mParser.allowJSON = true;
		mParser.allowTypes = true;
		
		var data = { };
		
		mInterp = new Interp();
		mInterp.variables.set("this", mEntity);
		mInterp.variables.set("Math", Math);
		mInterp.variables.set("data", data);
		
		interpScript();
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	function onEnterFrame(e:Event):Void 
	{
		if(mAst != null)
			mInterp.variables.get('onUpdate')();
	}
	
	function interpScript() 
	{
		try {
			mAst = mParser.parseString(mScript);
			mInterp.execute(mAst);
		}catch ( e : Error) {
			trace(e.getName());
		}
		
		if(mAst != null)
			mInterp.variables.get('onInit')();
	}
	
	function initBaseScript() 
	{
		mScript = File.getContent("../../../scripts/baseScript.hx");
	}
	
	function onMessage(e:ServerEvent):Void 
	{
		var message = e.data;
		trace(message);
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
