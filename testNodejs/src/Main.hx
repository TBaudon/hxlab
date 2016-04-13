package;

import haxe.web.Dispatch;
import js.node.Http;
import js.Node.console;
import js.node.http.IncomingMessage;
import js.node.http.ServerResponse;
import js.node.nodeStatic.Server as StaticServer;
import sys.FileSystem;


/**
 * ...
 * @author TBaudon
 */
class Main {
	
	static function main() {
		
		var params = Sys.args();
		var staticRoot : String = "";
		if (params.length < 1)
			throw "no path passed";
		else staticRoot = params[0];
		
		var file = new StaticServer(staticRoot, { gzip : true } );
		
		Http.createServer(function (req, res) {
			res.setHeader('Access-Control-Allow-Origin', '*');
			try {
				Dispatch.run(req.url, null, new Main(req, res));
			}catch (e : Dynamic) {
				req.addListener('end', function() {
					file.serve(req, res, function(err, result) {
						if (err != null)
							console.log("error : " + err.message + " " + req.url);
						else {
							console.log(result);
						}
					});
				}).resume();	
			}
			
        }).listen(1337, '127.0.0.1');
		
        console.log('Server running at http://127.0.0.1:1337/');
		console.log(FileSystem.readDirectory("."));
		
	}
	
	var req : IncomingMessage;
	var res : ServerResponse;
	
	function new(req : IncomingMessage, res : ServerResponse) {
		this.req = req;
		this.res = res;
	}
	
	function doDefault() {
		console.log("default!");
		res.end("index");
	}
	
	function doTest() {
		console.log("test");
		res.end("test");
	}
	
}