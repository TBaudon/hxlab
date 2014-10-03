import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.Lib;
import wx.App;
import wx.BoxSizer;
import wx.Button;
import wx.Frame;
import wx.NMEStage;
import wx.Panel;
import wx.Sizer;

class Simple 
{
	var mFrame : wx.Frame;

	public function new()
	{
		mFrame = wx.Frame.create(null, null, "Simple01", null, { width: 800, height: 600 });
		
		var panel:Panel = Panel.create(mFrame);
		var button : Button = Button.create(panel, 0, "A button");
		
		var openflStage : NMEStage = NMEStage.create(panel);
		openflStage.stage.align = StageAlign.TOP_LEFT;
		openflStage.stage.scaleMode = StageScaleMode.NO_SCALE;
		
		var a = new Sprite();
		a.graphics.beginFill( 0x000000 );
        a.graphics.drawCircle( 50 , 50 , 50 );
        a.graphics.endFill();
		
		//trace(openflStage.stage.stageWidth);
		//Lib.current.stage.addChild(a);
		
		// Auto position the panel and NMEStage with a sizer
        var sizer:Sizer = BoxSizer.create(true);
        panel.set_sizer(sizer);
        sizer.add( button , 1 , Sizer.EXPAND | Sizer.BORDER_ALL , 5 );
        sizer.add( openflStage , 3 , Sizer.EXPAND | Sizer.BORDER_ALL , 5);
		
		App.setTopWindow(mFrame);
		mFrame.shown = true;
	}
	
	
}
