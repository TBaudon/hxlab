<?php

class Test {
	public function __construct($a) {
		if(!php_Boot::$skip_constructor) {
		haxe_Log::trace(" a : " . _hx_string_rec($a, ""), _hx_anonymous(array("fileName" => "Test.hx", "lineNumber" => 14, "className" => "Test", "methodName" => "new")));
		$this->mRand = $a;
		$p = 5;
		haxe_Log::trace("module working " . _hx_string_rec($this->mRand, "") . " " . _hx_string_rec($p, ""), _hx_anonymous(array("fileName" => "Test.hx", "lineNumber" => 17, "className" => "Test", "methodName" => "new")));
	}}
	public $mRand;
	public function run() {
		haxe_Log::trace("YEAH " . _hx_string_rec($this->mRand, ""), _hx_anonymous(array("fileName" => "Test.hx", "lineNumber" => 21, "className" => "Test", "methodName" => "run")));
	}
	public function __call($m, $a) {
		if(isset($this->$m) && is_callable($this->$m))
			return call_user_func_array($this->$m, $a);
		else if(isset($this->__dynamics[$m]) && is_callable($this->__dynamics[$m]))
			return call_user_func_array($this->__dynamics[$m], $a);
		else if('toString' == $m)
			return $this->__toString();
		else
			throw new HException('Unable to call <'.$m.'>');
	}
	function __toString() { return 'Test'; }
}
