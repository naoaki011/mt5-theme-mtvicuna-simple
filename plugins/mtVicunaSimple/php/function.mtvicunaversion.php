<?php
	function smarty_function_mtvicunaversion($args, &$ctx) {
		$blog_id = $ctx->stash('blog_id');
		# TODO FIX THIS HARDCODE
		return '2.41';
	}
?>
