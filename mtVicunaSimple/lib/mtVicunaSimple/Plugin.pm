package mtVicunaSimple::Plugin;

use strict;
use MT 4;

sub tag_version {
#    my ( $ctx, $args ) = @_;
#    my $plugin = MT->component("mtVicunaSimple");
#    my $scope = "blog:".$ctx->stash('blog_id');
#    use Data::Dumper;
#    doLog ($plugin);
    return '2.4.1';
}

sub tag_index_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('index_style',$scope) || 'default';
    return $style;
}

sub tag_entry_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('entry_style',$scope) || 'default';
    return $style;
}

sub tag_monthly_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('monthly_style',$scope) || 'default';
    return $style;
}

sub tag_category_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('category_style',$scope) || 'default';
    return $style;
}

sub tag_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('eyecatch_style',$scope) || 'eye-h';
    return $style;
}

sub tag_fixed_width {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $width = $plugin->get_config_value('fixed_width',$scope) || 'none';
    if ($width == 'none') {
        return '';
    } else {
        return $width;
    }
}

sub tag_cloud_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('cloud_style',$scope) || 'none';
    if ($style == 'none') {
        return '';
    } else {
        return 'tagCloud'.$style.'.css';
    }
}

sub if_nav_on_top {
    my ( $ctx, $args, $cond ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $ontop = $plugin->get_config_value('navi_on_top',$scope) || 0;
    return $ontop;
}

sub if_hide_nav {
    my ( $ctx, $args, $cond ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $ontop = $plugin->get_config_value('hide_navi',$scope) || 0;
    return $ontop;
}

sub if_left_align {
    my ( $ctx, $args, $cond ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $leftalign = $plugin->get_config_value('left_align',$scope) || 0;
    return $leftalign;
}

sub if_use_slimbox {
    my ( $ctx, $args, $cond ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $slimbox = $plugin->get_config_value('use_slimbox',$scope) || 1;
    return $slimbox;
}

sub _asset_options_image {
    my ( $cb, $app, $param, $tmpl ) = @_;
    my $blog_id = $app->param('blog_id');
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$blog_id;
    my $slimbox = $plugin->get_config_value('use_slimbox',$scope);
    if ($slimbox != '') {
        use MT::Blog;
        my $blog = MT::Blog->load($blog_id) or die;
        my $themeid = $blog->theme_id;
        if ($themeid eq 'mtVicunaSimple') {
           my $asset_id = $param->{asset_id} or return;
            my $asset = MT::Asset->load( $asset_id ) or return;
            my $el = $tmpl->getElementById('image_alignment')
                or return;
            my $opt = $tmpl->createElement('app:setting', {
                id => 'insert_lightbox',
                label => MT->translate('Lightbox'),
                label_class => 'no-header',
                hint => '',
                show_hint => 0,
            });
            $opt->innerHTML(<<HTML);
            <input type="checkbox" id="insert_lightbox" name="insert_lightbox"
                value="1"<mt:if name="make_thumb"> checked="checked" </mt:if> />
            <label for="insert_lightbox"><__trans phrase='Use Slimbox'></label>
HTML
            $tmpl->insertBefore($opt, $el);
            $tmpl->rescan();
        }
    }
}

sub _asset_insert_param {
    my ( $cb, $app, $param, $tmpl ) = @_;
    my $upload_html = $param->{ upload_html };
    if ( $app->param('insert_lightbox') ) {
        $upload_html =~ s/<a/<a rel="lightbox"/i;
    }
    $upload_html =~ s/ class=\"mt-image-(none|right|left|center)\"//i;
    $upload_html =~ s/ style=\"\"//i;
    $upload_html =~ s/ style=\"float\: (right|left)\; margin\: 0 (0|20px) 20px (0|20px)\;\"//i;
    $upload_html =~ s/ style=\"text-align\: center\; display\: block\; margin\: 0 auto 20px\;\"//i;
    $param->{ upload_html } = $upload_html;
}

sub _edit_themeparams {
    my $app = shift;
    my $blog_id = $app->param('blog_id');
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$blog_id;
    my $index_style = $plugin->get_config_value('index_style',$scope);
    my $eyecatch_style = $plugin->get_config_value('eyecatch_style',$scope);
    my $fixed_width = $plugin->get_config_value('fixed_width',$scope);
    my $cloud_style = $plugin->get_config_value('cloud_style',$scope);
    my $navi_on_top = $plugin->get_config_value('navi_on_top',$scope);
    my $left_align = $plugin->get_config_value('left_align',$scope);
    $app->load_tmpl( 'dialog/edit_layout.tmpl', {
        index_style    => $index_style,
        eyecatch_style => $eyecatch_style,
        fixed_width    => $fixed_width,
        cloud_style    => $cloud_style,
        navi_on_top    => $navi_on_top,
        left_align     => $left_align } );
}
sub _if_vicuna {
    my $app = MT->instance;
    my $blog = $app->blog;
    my $themeid = $blog->theme_id;
    if ($themeid eq 'mtVicunaSimple') {
        return 1;
    } else {
        return 0;
    }
}

sub doLog {
    my ($msg) = @_; 
    return unless defined($msg);
    require MT::Log;
    my $log = MT::Log->new;
    $log->message($msg) ;
    $log->save or die $log->errstr;
}

1;