package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.display.Shape;

/**
 * ...
 * @author TBaudon
 */
class Main extends Sprite {
	
	var square : Sprite;

	public function new() {
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		
		square = new Sprite();
		square.graphics.beginFill(0xff0000);
		square.graphics.drawRect(-10, -10, 20, 20);
		
		addChild(square);
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		square.addEventListener(MouseEvent.CLICK, toggle);
	}
	
	function toggle(e : MouseEvent) {
		square.graphics.beginFill(0xff0FF0);
		square.graphics.drawRect(-10, -10, 20, 20);
	}
	
	function onEnterFrame(e : Event) {
		square.rotation++;
		square.x = Lib.current.stage.stageWidth / 2;
		square.y = Lib.current.stage.stageHeight / 2;
	}

}
