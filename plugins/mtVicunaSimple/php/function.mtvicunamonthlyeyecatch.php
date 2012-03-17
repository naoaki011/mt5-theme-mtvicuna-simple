<?php
	function smarty_function_mtvicunamonthlyeyecatch($args, &$ctx) {
		$blog_id = $ctx->stash('blog_id');
		if (empty($blog_id)) return $string;
		$pluginConfig = $ctx->mt->db()->fetch_plugin_config('mtVicunaSimple', "blog:$blog_id");
		$eyecatch = $pluginConfig['monthly_eyecatch'] ? $pluginConfig['monthly_eyecatch']: 'eye-h';
		return ($eyecatch === 'none') ? '' : $eyecatch;
	}
?>
