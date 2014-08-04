package ;

/**
 * ...
 * @author Thomas B
 */
class Node
{
	
	public var outputs : Array<Dynamic>;
	public var inputs : Array<Dynamic>;

	public function new() 
	{
		
		outputs = new Array<Dynamic>();
		inputs = new Array<Dynamic>();
		
	}
	
	function addInput(input : Dynamic) {
		inputs.push(input);
	}
	
	function addOutput(output : Dynamic) {
		outputs.push(output);
	}
}