<?php

class Type {
	public function __construct(){}
	static function resolveClass($name) {
		$c = _hx_qtype($name);
		if($c instanceof _hx_class || $c instanceof _hx_interface) {
			return $c;
		} else {
			return null;
		}
	}
	static function createInstance($cl, $args) {
		if($cl->__qname__ === "Array") {
			return (new _hx_array(array()));
		}
		if($cl->__qname__ === "String") {
			return $args[0];
		}
		$c = $cl->__rfl__();
		if($c === null) {
			return null;
		}
		return $inst = $c->getConstructor() ? $c->newInstanceArgs($args->a) : $c->newInstanceArgs();
	}
	function __toString() { return 'Type'; }
}
