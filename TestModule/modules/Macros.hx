package;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

/**
 * ...
 * @author Thomas B
 */
class Macros{

	macro public static function setNameToTrue() : Expr {
		return Context.makeExpr("$hx_exports." + Context.getLocalClass() + ".__name__ = true", Context.currentPos());
	}
	
}