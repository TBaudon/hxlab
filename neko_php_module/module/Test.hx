package ;

/**
 * ...
 * @author Thomas B
 */
class Test
{
	
	var mRand : Int;

	public function new(a : Int) 
	{
		trace(" a : " + a);
		mRand = a;
		var p = 5;
		trace("module working " + mRand + " " + p);
	}
	
	public function run() {
		trace("YEAH " + mRand);
	}
	
}