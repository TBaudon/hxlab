package;


import edge.Entity;
import edge.World;
import openfl.display.Sprite;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		var world = new World();
		
		world.render.add(new RenderSystem());
		
		var s : Sprite = new Sprite();
		s.graphics.beginFill(0xff5500);
		s.graphics.drawCircle(100, 100, 100);
		
		var comps : Array<{}> = [
			new Transform(),
			s
		];
		
		world.engine.create(comps);
		
		world.start();
	}
	
	
}