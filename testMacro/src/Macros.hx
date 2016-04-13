package;

import haxe.Json;
import haxe.macro.Compiler;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.FieldType;



/**
 * ...
 * @author TBaudon
 */
class Macros{

	public static function addSerialize() {
		
		var fields : Array<Field> = Context.getBuildFields();
		var fieldsToSerialize : Array<String> = new Array<String>();
		
		for (field in fields) {
			if (field.access.indexOf(APublic) != -1 && field.kind.getName() != "FFun") 
				fieldsToSerialize.push(field.name);
		}
		
		var repDec : Expr = macro var rep : Dynamic = { };
		var returnExp : Expr = macro return Json.stringify(rep);
		
		var exprArr = new Array<Expr>();
		exprArr.push(repDec);
		
		for (f in fieldsToSerialize) 
			exprArr.push(macro rep.$f = this.$f);
		
		exprArr.push(returnExp);
		
		var expr : Expr = macro $b{exprArr};
		
		var func : Function = { 
			args : [],
			expr : expr,
			ret : macro : Dynamic
		};
		
		var serializeFunction : Field = {
			name : "serialize",
			access : [APublic],
			pos : Context.currentPos(),
			kind : FieldType.FFun(func)
		};
		
		fields.push(serializeFunction);
		
		return fields;
	}
	
}