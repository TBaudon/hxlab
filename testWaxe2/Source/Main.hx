package;


import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.Lib;
import wx.App;
import wx.Button;
import wx.clay.Toolbox;
import wx.Frame;
import wx.Menu;
import wx.MenuBar;
import wx.Notebook;
import wx.OpenFLStage;
import wx.Panel;
import wx.Scintilla;
import wx.Window;


class Main extends Sprite {
	
	
	var mFrame  : Frame;
	
	inline static var NEW : Int = 0;
	inline static var OPEN : Int = 1;
	inline static var CLOSE : Int = 2;
	
	public function new () {
		
		super ();
		
		mFrame = ApplicationMain.frame;
		
		var menu : MenuBar = new MenuBar();
		var fileMenu : Menu = new Menu();
		fileMenu.append(NEW, "New", "Create a new fucking file.");
		fileMenu.append(OPEN, "Open", "Open a file.");
		fileMenu.appendSeparator();
		fileMenu.append(CLOSE, "&Quit", "Close the app.", Menu.CHECK);
		menu.append(fileMenu, "File");
		
		mFrame.handle(NEW, onMenuClicked);	
		mFrame.handle(OPEN, onMenuClicked);	
		mFrame.handle(CLOSE, onMenuClicked);
		
		//var panel = Panel.create(mFrame);
		
		var b : Notebook = Notebook.create(mFrame);
		
		var editorPage = Window.create(b);
		var scintilla = Scintilla.create(editorPage);
		
		b.addPage(editorPage, "haha");
		
		var openflPage = Window.create(b);
		var littleRenderZone = OpenFLStage.create(openflPage, 0, null, {width:300, height:300});
		littleRenderZone.stage.align = StageAlign.TOP_LEFT;
        littleRenderZone.stage.scaleMode = StageScaleMode.NO_SCALE;
		
		littleRenderZone.stage.graphics.beginFill(0xff0000);
		littleRenderZone.stage.graphics.drawCircle(0, 0, 20);
		
		b.addPage(openflPage, "openfl");
		
		mFrame.wxSetMenuBar(menu);
	}
	
	function onMenuClicked(obj : Dynamic) 
	{
		var id : Int = obj.id;
		switch(id) {
			case OPEN :
				trace("open");
			case CLOSE :
				App.quit();
			default :
				trace("nope");
		}
	}
	
}