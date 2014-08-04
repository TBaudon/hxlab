package ;
import flash.net.URLRequest;
import haxe.Timer;
import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.net.URLLoader;

/**
 * ...
 * @author TBaudon
 */
class Entity extends Sprite
{
	var mAst : Expr ;
	var mInterp : Interp;
	var mParser : Parser;
	var mBehaviourPath : String;
	public var data : Dynamic;

	public function new(behaviourPath : String) 
	{
		super();
		graphics.beginFill(0xff0000);
		graphics.drawCircle(0, 0, 20);
		
		mParser = new Parser();
		mParser.allowJSON = true;
		mParser.allowTypes = true;
		
		data = {};
		
		mBehaviourPath = behaviourPath;
		mInterp = new Interp();
		mInterp.variables["this"] = this;
		mInterp.variables.set("Math", Math);
		
		updateBehaviour();
		
		var updateTime = new Timer(1000);
		updateTime.run = updateBehaviour;
		
		this.addEventListener(Event.ENTER_FRAME, update);
		Lib.current.stage.addEventListener(MouseEvent.CLICK, onMouse);
	}
	
	public function updateBehaviour() {
		var loader : URLLoader = new URLLoader();
		loader.load(new URLRequest(mBehaviourPath));
		loader.addEventListener(Event.COMPLETE, onLoaded);
	}
	
	function onLoaded(e : Event) : Void
	{
		try {
			mAst = mParser.parseString(e.target.data);
			mInterp.execute(mAst);
		}catch ( e : Error) {
			trace(e.getName());
		}
	}
	
	public function update(e : Event) {
		if(mAst != null){
			mInterp.variables.get('update')(Lib.getTimer());
		}
	}
	
	public function onMouse(e : MouseEvent) {
		mInterp.variables.get('onMouseClick')(e);
	}
	
}