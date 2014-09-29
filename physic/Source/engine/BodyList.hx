package engine;

/**
 * ...
 * @author Thomas BAUDON
 */
class BodyList
{
	
	public var first : Body;
	public var last : Body;

	public function new() 
	{
		
	}
	
	public function add(body : Body) {
		if (first == null){
			first = body;
			last = body;
		}else {
			last.next = body;
			body.prev = last;
			last = body;
		}
		
	}
	
	public function remove(body : Body) {
		if(body != first)
			body.prev.next = body.next;
		
		if(body != last)
			body.next.prev = body.prev;
	}
	
}