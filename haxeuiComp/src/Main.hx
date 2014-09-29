package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.ui.toolkit.containers.Absolute;
import haxe.ui.toolkit.containers.ScrollView;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.themes.GradientTheme;

/**
 * ...
 * @author Thomas BAUDON
 */

class Main extends Sprite 
{
	
	var mRoot : Root;
	
	public function new() {
		super();
		
		Toolkit.theme = new GradientTheme();
		Toolkit.openFullscreen(initToolkit);
		Toolkit.init();
		
		
		
		var explorer = new FileExplorer();
		explorer.percentWidth = 100;
		explorer.percentHeight = 100;
		mRoot.addChild(explorer);
		
		explorer.explore(".");
	}
	
	function initToolkit(root : Root) 
	{
		mRoot = root;
	}
}
