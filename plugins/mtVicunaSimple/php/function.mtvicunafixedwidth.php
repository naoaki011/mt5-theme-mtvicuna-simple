<?php
	function smarty_function_mtvicunafixedwidth($args, &$ctx) {
		$blog_id = $ctx->stash('blog_id');
		if (empty($blog_id)) return $string;
		$pluginConfig = $ctx->mt->db()->fetch_plugin_config('mtVicunaSimple', "blog:$blog_id");
		$width = $pluginConfig['fixed_width'] ? $pluginConfig['fixed_width'] : 'none';
		return ($width === 'none') ? '' : $width;
	}
?>
