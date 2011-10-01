<?php
	function smarty_block_mtifvicunaleftalign ( $args, $content, &$ctx, &$repeat ) {
		$blog_id = $ctx->stash('blog_id');
		if ( $blog_id ) {
			$pluginConfig = $ctx->mt->db()->fetch_plugin_config('mtVicunaSimple', "blog:$blog_id");
			$left_align = $pluginConfig['left_align'];
			if ( $left_align ) {
				return $ctx->_hdlr_if( $args, $content, $ctx, $repeat, 1 );
			}
		}
		return $ctx->_hdlr_if( $args, $content, $ctx, $repeat, 0 );
	}
?>
