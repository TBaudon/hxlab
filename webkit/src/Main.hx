package ;

import js.Browser;
import js.Node;

import nodejs.webkit.Window;


/**
 * ...
 * @author Thomas B
 */
class Main
{
	
	var _win : Window;
	
	var _maximized : Bool;
	
	static function main() {
		new Main();
	}
	
	public function new() {
		_win = Window.get();
		
		Browser.document.getElementById('windowControlMinimize').onclick = minimize;
		Browser.document.getElementById('windowControlMaximize').onclick = maximize;
		Browser.document.getElementById('windowControlClose').onclick = close;
		Browser.document.getElementById('windowControlDebug').onclick = debug;
		
		_win.on('maximize', function() {
			_maximized = true;
		});
		
		_win.on('unmaximize', function() {
			_maximized = false;
		});
		
		var fs = Node.fs;
		var a = new NodeBuffer(10);
		a.write("bonjour hihihi");
		fs.writeFile("Salut", a, null);
	}
	
	function minimize(Dynamic) {
		_win.minimize();
	}
	
	function maximize(target : Dynamic) {
		if (_maximized)
			_win.unmaximize();
		else 
			_win.maximize();
	}
	
	function close(Dynamic) {
		_win.close();
	}
	
	function debug(Dynamic) {
		_win.showDevTools();
	}
}