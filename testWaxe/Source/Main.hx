package;
import fr.radstar.radengine.RadGame;
import haxe.Timer;
import openfl.display.ManagedStage;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.Lib;
import wx.App;
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

    var frame:Frame;
	var mStage:ManagedStage;
     
    public function new()
    {
        // Make an app window
        frame = Frame.create(null, "WaxeApp" , null , { width:400 , height:400 } );
         
        // Make a panel
        var waxePanel:Panel = Panel.create( frame );
        var button:Button = Button.create( waxePanel, null, 'A Button');
         
        // Make an NME stage
        var openflStage:OpenFLStage = OpenFLStage.create( waxePanel );
        openflStage.stage.align = StageAlign.TOP_LEFT;
        openflStage.stage.scaleMode = StageScaleMode.NO_SCALE;
        
		mStage = openflStage.stage;
		
        // Auto position the panel and NMEStage with a sizer
        var sizer:Sizer = BoxSizer.create(true);
        waxePanel.set_sizer(sizer);
        sizer.add( button , 1 , Sizer.EXPAND | Sizer.BORDER_ALL , 5 );
        sizer.add( openflStage , 3 , Sizer.EXPAND | Sizer.BORDER_ALL , 5);
         
        // Show your window
        App.setTopWindow( frame );
        frame.shown = true;
		
		var engine = new RadGame();
		mStage.addChild(engine);
    }
 
     
    // Entry
    public static function main()
    {
        App.boot( function(){ new Main(); } );
    }
}
