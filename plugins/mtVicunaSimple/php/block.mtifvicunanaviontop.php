<?php
	function smarty_block_mtifvicunanaviontop ( $args, $content, &$ctx, &$repeat ) {
		$blog_id = $ctx->stash('blog_id');
		if ( $blog_id ) {
			$pluginConfig = $ctx->mt->db()->fetch_plugin_config('mtVicunaSimple', "blog:$blog_id");
			$nav_on_top = $pluginConfig['nav_on_top'];
			if ( $nav_on_top ) {
				return $ctx->_hdlr_if( $args, $content, $ctx, $repeat, 1 );
			}
		}
		return $ctx->_hdlr_if( $args, $content, $ctx, $repeat, 0 );
	}
?>
