package;
import haxe.Timer;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.Lib;
import wx.BoxSizer;
import wx.Button;
import wx.Frame;
import wx.OpenFLStage;
import wx.Panel;
import wx.Sizer;


/**
 * Thanks to
 * http://blog.nturn.net/?p=329
 */


class Main {
	
	var mFrame : Frame;
	var mOpenfl : OpenFLStage;
	var stage:openfl.display.ManagedStage;
	
	public function new () {
		
		mFrame = ApplicationMain.frame;
		
		var panel : Panel = Panel.create(mFrame);
		var button = Button.create(panel, 0, "Button");
		
		var mOpenfl = OpenFLStage.create(panel);
		
		var sizer : Sizer = BoxSizer.create(true);
		panel.set_sizer(sizer);
		sizer.add(button, 1, Sizer.EXPAND | Sizer.BORDER_ALL, 5);
		sizer.add(mOpenfl, 3, Sizer.EXPAND | Sizer.BORDER_ALL, 5);
		
		stage = mOpenfl.stage;
		
		
		
		Timer.delay(aa, 1000);
		
		
		
	}
	
	function aa() {
		
		var a = new Shape();
		a.graphics.beginFill(0xFF0000);
		a.graphics.drawCircle(0, 0, 20);
		
		stage.addChild(a);
		
		trace(stage.numChildren);
	}
}