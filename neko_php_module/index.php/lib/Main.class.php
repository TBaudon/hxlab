<?php

class Main {
	public function __construct() { if(!php_Boot::$skip_constructor) {
		haxe_Log::trace("Test module : ", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 28, "className" => "Main", "methodName" => "new")));
		$moduleC = Main::getModule("test");
		$obj = Main::createInstance($moduleC);
		$obj->run();
	}}
	static function main() {
		new Main();
	}
	static function getModule($name) {
		$binPath = _hx_string_or_null(dirname($_SERVER["SCRIPT_FILENAME"])) . "/";
		$binPath = str_replace("\\", "/", $binPath);
		$binPath = haxe_io_Path::removeTrailingSlashes($binPath);
		$modulePath = _hx_string_or_null(_hx_substr($binPath, 0, _hx_last_index_of($binPath, "/", null))) . _hx_string_or_null(("/module/" . _hx_string_or_null($name) . ".php"));
		if(file_exists($modulePath)) {
			$className = _hx_string_or_null(strtoupper(_hx_substr($name, 0, 1))) . _hx_string_or_null(strtolower(_hx_substr($name, 1, strlen($name))));
			php_Lib::loadLib($modulePath);
			return Type::resolveClass("lib." . _hx_string_or_null($className));
		}
		return null;
	}
	static function createInstance($module) {
		haxe_Log::trace($module, _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 78, "className" => "Main", "methodName" => "createInstance")));
		return new Test("");
	}
	function __toString() { return 'Main'; }
}
