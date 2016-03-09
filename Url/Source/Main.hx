package;


import haxe.Json;
import openfl.display.Sprite;

import openfl.net.URLRequest;
import openfl.net.URLRequestHeader;
import openfl.net.URLRequestMethod;
import openfl.net.URLLoader;

import openfl.events.Event;
import openfl.events.ErrorEvent;
import openfl.events.IOErrorEvent;

class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		var url = "https://api.parse.com/1/classes/bidule";
		var request = new URLRequest(url);
		request.requestHeaders = [
			new URLRequestHeader("X-Parse-Application-Id", "VyEoJNNO0Su76VRpUXo7X05zvqTaCjcoj0ACNNi3"),
			new URLRequestHeader("X-Parse-REST-API-Key", "LmoE1LUnrtGA5LOZhQQf50x69nnzXcaL4OBCYKnO"),
		];
		request.contentType = "application/json";
		
		var data = {
			prout : "oui"
		}
		
		request.data = Json.stringify(data);
		request.method = "POST";
		
		var requestor = new URLLoader();
		
		requestor.addEventListener(Event.COMPLETE, onComplete);
		requestor.addEventListener(IOErrorEvent.IO_ERROR, onError);
		
		requestor.load(request);
	}
	
	private function onError(e:ErrorEvent):Void 
	{
		 trace( "An error occured: " + e.text ); 
	}
	
	private function onComplete(e:Event):Void 
	{
		trace(e.target.data);
	}
	
	
}