<?php

class haxe_io_Path {
	public function __construct(){}
	static function removeTrailingSlashes($path) {
		while(true) {
			$_g = _hx_char_code_at($path, strlen($path) - 1);
			switch($_g) {
			case 47:case 92:{
				$path = _hx_substr($path, 0, -1);
			}break;
			default:{
				break 2;
			}break;
			}
			unset($_g);
		}
		return $path;
	}
	function __toString() { return 'haxe.io.Path'; }
}
