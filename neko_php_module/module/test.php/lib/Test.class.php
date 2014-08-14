<?php

class Test {
	public function __construct() { if(!php_Boot::$skip_constructor) {
		haxe_Log::trace("module working", _hx_anonymous(array("fileName" => "Test.hx", "lineNumber" => 12, "className" => "Test", "methodName" => "new")));
	}}
	public function run() {
		haxe_Log::trace("YEAH", _hx_anonymous(array("fileName" => "Test.hx", "lineNumber" => 16, "className" => "Test", "methodName" => "run")));
	}
	function __toString() { return 'Test'; }
}
