<?php
	function smarty_function_mtvicunaentryeyecatch($args, &$ctx) {
		$blog_id = $ctx->stash('blog_id');
		if (empty($blog_id)) return $string;
		$pluginConfig = $ctx->mt->db()->fetch_plugin_config('mtVicunaSimple', "blog:$blog_id");
		$eyecatch = $pluginConfig['entry_eyecatch'] ? $pluginConfig['entry_eyecatch'] : 'eye-h';
		return ($eyecatch === 'none') ? '' : $eyecatch;
	}
?>
