<?php
	function smarty_modifier_adjust_hn($str, $args) {
		if ($args) {
			 $pattern = '/(<\/?[hH])([2-5])([ >])/';
			 function plus_hl($matches) {
				 return $matches[1].($matches[2]+1).$matches[3];
			 }
			 $str = preg_replace_callback($pattern, 'plus_hl', $str);
		}
		return $str;
	}
?>