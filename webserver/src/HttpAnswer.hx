package;

/**
 * ...
 * @author TBaudon
 */
class HttpAnswer{

	var mStatus : Int;
	var mRaison : String;
	
	var mAnswer : String;
	
	public function new(status : Int, raison : String) {
		mAnswer = "HTTP/1.1 " + status + " " + raison;
		mStatus = status;
		mRaison = raison;
	}
	
	public function add(content : String) {
		mAnswer += content + "\r\n";
	}
	
	public function end() : String {
		return mAnswer + "\r\n";
	}
	
}

