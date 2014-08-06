package ;
import haxe.macro.Context;
import sys.net.Host;
/**
 * ...
 * @author Thomas B
 */
class Macros
{
	macro public static function getBuilderIp() {
		//mSocket.connect("localhost", 5000);
		var host = new Host(Host.localhost());
		return Context.makeExpr(host.toString(), Context.currentPos());
	}
}
