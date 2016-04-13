package;

import electron.main.App;
import electron.main.BrowserWindow;
import js.Browser;
import js.Lib;
import js.Node.console;

/**
 * ...
 * @author TBaudon
 */
class Launch {
	
	static var mainWindow : BrowserWindow;
	
	static function main() {
			
		App.on(AppEventType.ready, createWindow);
		App.on(AppEventType.window_all_closed, function() {
			App.quit();
		});
		App.on(AppEventType.activate, function() {
			if (mainWindow == null)
				createWindow();
		});
		
	}
	
	static private function createWindow() {
		mainWindow = new BrowserWindow( { width : 800, height : 600 } );
		
		var path = "file://" + Sys.getCwd() + "/index.html";
		console.log(path);
		
		mainWindow.loadURL(path);
		
		mainWindow.openDevTools();
		
		mainWindow.on('closed', function() {
			mainWindow = null;
		});
		
	}
	
}