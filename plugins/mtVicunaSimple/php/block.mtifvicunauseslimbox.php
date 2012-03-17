<?php
	function smarty_block_mtifvicunauseslimbox ( $args, $content, &$ctx, &$repeat ) {
		$blog_id = $ctx->stash('blog_id');
		if ( $blog_id ) {
			$pluginConfig = $ctx->mt->db()->fetch_plugin_config('mtVicunaSimple', "blog:$blog_id");
			$use_slimbox = $pluginConfig['use_slimbox'];
			if ( $use_slimbox === '1') {
				return $ctx->_hdlr_if( $args, $content, $ctx, $repeat, 1 );
			} else {
				if ( $use_slimbox !== '0') {
					return $ctx->_hdlr_if( $args, $content, $ctx, $repeat, 1 );
				}
			}
		}
		return $ctx->_hdlr_if( $args, $content, $ctx, $repeat, 0 );
	}
?>
