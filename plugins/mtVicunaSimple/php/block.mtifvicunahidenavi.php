<?php
	function smarty_block_mtifvicunahidenavi ( $args, $content, &$ctx, &$repeat ) {
		$blog_id = $ctx->stash('blog_id');
		if ( $blog_id ) {
			$pluginConfig = $ctx->mt->db()->fetch_plugin_config('mtVicunaSimple', "blog:$blog_id");
			$hide_navi = $pluginConfig['hide_navi'];
			if ( $hide_navi ) {
				return $ctx->_hdlr_if( $args, $content, $ctx, $repeat, 1 );
			}
		}
		return $ctx->_hdlr_if( $args, $content, $ctx, $repeat, 0 );
	}
?>
