<?php
	function smarty_function_mtvicunacategoryeyecatch($args, &$ctx) {
		$blog_id = $ctx->stash('blog_id');
		if (empty($blog_id)) return $string;
		$pluginConfig = $ctx->mt->db()->fetch_plugin_config('mtVicunaSimple', "blog:$blog_id");
		$eyecatch = $pluginConfig['category_eyecatch'];
		return $eyecatch;
	}
?>
