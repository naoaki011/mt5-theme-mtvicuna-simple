<?php
	function smarty_function_mtvicunaarchiveeyecatch($args, &$ctx) {
		$blog_id = $ctx->stash('blog_id');
		if (empty($blog_id)) return $string;
		$pluginConfig = $ctx->mt->db()->fetch_plugin_config('mtVicunaSimple', "blog:$blog_id");
		$style = $pluginConfig['archive_eyecatch'] ? $pluginConfig['archive_eyecatch'] : 'eye-h';
		return ($style === 'none') ? '' : $style;
	}
?>
