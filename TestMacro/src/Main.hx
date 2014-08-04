package ;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.Template;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;

/**
 * ...
 * @author TBaudon
 */

class Main 
{	
	
	static function generateNode(_inputs : Array<Dynamic>, _outputs:Array<Dynamic>, _nodeName : String, dir : String) {
		
		dir = dir.toLowerCase();
		_nodeName = "Node_" + _nodeName;
		_nodeName = StringTools.replace(_nodeName, ' ', '');
		
		var file = File.getContent("res/NodeTemplate.hx");
		var t = new Template(file);
		var node = { inputs:_inputs, outputs:_outputs, nodeName: _nodeName, npackage: 'nodes.'+dir};
		var out = t.execute(node);
		
		var dirPath = 'nodes/' + dir;
		FileSystem.createDirectory(dirPath);
		
		var fname = "nodes/"+dir+"/"+_nodeName + ".hx";
		var fout = File.write(fname, false);
		fout.writeString(out);
		fout.close();
	}
	
	static function parseCode(file : FileInput, className : String) {
		var line : String;
			while (!file.eof()) {
				line = file.readLine();
				if (line.indexOf('function') != -1) {
					var inputs = new Array<Dynamic>();
					for (input in getFunctionParameters(line))
						inputs.push( '{ name: "' + input.name+'", type:"' + input.type+'" } ');
					var outputs = new Array<Dynamic>(); 
					for (output in getFunctionReturnType(line))
						outputs.push( '{ name: "' + output.name+'", type:"' + output.type+'" } ');
					var nodeName = getFunctionName(line);
					generateNode(inputs, outputs, nodeName, className);
				}
			}
		Compiler.include('nodes.' + className.toLowerCase());
	}
	
	static function getFunctionName(line:String) : String {
		var lastPos = line.indexOf('(');
		var firstPos = line.indexOf('function') + 'function'.length;
		var name = line.substr(firstPos, lastPos - firstPos);
		return name;
	}
	
	static function getFunctionParameters(line:String) : Array<{name:String, type:String}>{
		var startIndex = line.indexOf('(') + 1;
		var endIndex = line.indexOf(')');
		var parameters : String = line.substr(startIndex, endIndex - startIndex);
		
		var params = new Array<{name:String, type:String}>();
		
		if(parameters.length>3){
			var paramsStr = parameters.split(',');
			for (param in paramsStr) {
				var pname = param.split(':')[0];
				var ptype = param.split(':')[1];
				params.push( { name:pname, type:ptype } );
			}
		}
		
		return params;
	}
	
	static function getFunctionReturnType(line:String) : Array<{name:String, type:String}> {
		var startIndex = line.indexOf(')') + 1;
		var returnPart = line.substr(startIndex);
		returnPart = StringTools.replace(returnPart, ' ', '');
		returnPart = StringTools.replace(returnPart, '{', '');
		returnPart = StringTools.replace(returnPart, '}', '');
		
		var returns = new Array<{name:String, type:String}>();
		
		if (returnPart.indexOf(':') != -1) {
			returnPart = returnPart.substr(1);
			
			var types = returnPart.split(',');
			if (types.length == 1) returns.push( { type:returnPart, name:returnPart } );
			else {
				for (type in types) {
					var returnName = type.split(':')[0];
					var returnType = type.split(':')[1];
					returns.push( { type:returnType, name:returnName } );
				}
			}
		}
		return returns;
	}
	
	macro static function getNodes() {
		
		var classToParse : Array<Class<Dynamic>> = new Array<Class<Dynamic>>();
		
		classToParse.push(BasicMath);
		
		trace("Parsing...");
		
		for (currentClass in classToParse) {
			
			var classPaths = Context.getClassPath();
			var className = Type.getClassName(currentClass);
			trace(className);
			
			// look for class file
			var file : FileInput;
			for (path in classPaths) {
				try {
					var p = Context.resolvePath(path + className+".hx");
					file = File.read(p, false);
					break;
				}catch (e : Dynamic) {
					
				}
			}
			
			parseCode(file, className);
			
		}
		trace('Nodes generated.');
		return Context.makeExpr('Nodes generated.', Context.currentPos());
	}
	
	function new() {
	}
	
	static function main() 
	{		
		getNodes();
		new Main();
	}
	
}