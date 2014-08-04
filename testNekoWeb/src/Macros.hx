package ;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.io.File;

/**
 * ...
 * @author TBaudon
 */
class Macros
{

	macro public static function getContent(path : String) : ExprOf<String> {
		return Context.makeExpr(File.getContent(path), Context.currentPos());
	}
	
}