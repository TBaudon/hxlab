package;


import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;


class Main extends Sprite {
	
	var t : Float;
	var r : Float;
	
	var originX : Float;
	var originY : Float;
	
	var started : Bool = false;
	
	public function new () {
		
		super ();
		
		addEventListener(Event.ENTER_FRAME, update);
		
		t = 0;
		r = 0;
		
		originX = Lib.current.stage.stageWidth / 2;
		originY = Lib.current.stage.stageHeight / 2;
		
		
		graphics.lineStyle(2);
	}
	
	private function update(e:Event):Void 
	{
		draw();
	}
	
	function draw() {
		graphics.clear();
		graphics.lineStyle(2);
		graphics.beginFill(0xcc6666);
		
		var nbStep = 50;
		var step = (Math.PI * 2) / nbStep;
		var nbLoop = 10;
		
		for (i in 0 ... (nbStep * nbLoop) + 1) {
			t = i * step;
			
			var a = Lib.getTimer() / 150 ;
			
			r = Math.abs(Math.sin((t+Math.PI/2+a/10)*Math.sin(a/500)*3) * 200) + Math.abs(Math.cos(a/2) * 60 )+ 40;
			
			var pos = toCartesian(t, r);
			
			if (i == 0) {
				started = true;	
				graphics.moveTo(pos.x, pos.y);
			}
			else 	
				graphics.lineTo(pos.x, pos.y);
		}
	}
	
	function toCartesian(t : Float, r : Float) : { x : Float, y : Float} {
		
		var cx = Math.cos(t) * r + originX;
		var cy = Math.sin(t) * r + originY;
		
		return  { x : cx, y : cy };
		
	}
	
	
}