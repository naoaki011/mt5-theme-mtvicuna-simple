package mtVicunaSimple::Plugin;

use strict;
use MT 5;
use MT::Util qw( encode_html );

sub tag_version {
    require MT::Theme;
    my $theme = MT::Theme->load('mtVicunaSimple');
    my $theme_version = $theme->version;
    return $theme_version;
}

sub tag_blog_skin_layout {
    my $app = MT->instance;
    my $blog = $app->blog;
    my $page_layout = $blog->page_layout;
    return $page_layout;
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

sub tag_index_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('index_style',$scope) || 'double';
    return $style;
}

sub tag_entry_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('entry_style',$scope) || 'single';
    return $style;
}

sub tag_monthly_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('monthly_style',$scope) || 'double';
    return $style;
}

sub tag_category_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('category_style',$scope) || 'double';
    return $style;
}

sub tag_archive_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('archive_style',$scope) || 'single';
    return $style;
}

sub tag_index_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('index_eyecatch',$scope) || 'eye-h';
    return $style;
}

sub tag_entry_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('entry_eyecatch',$scope) || 'eye-h';
    return $style;
}

sub tag_category_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('category_eyecatch',$scope) || 'eye-h';
    return $style;
}

sub tag_monthly_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('monthly_eyecatch',$scope) || 'eye-h';
    return $style;
}

sub tag_archive_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('archive_eyecatch',$scope) || 'eye-h';
    return $style;
}

sub tag_fixed_width {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $width = $plugin->get_config_value('fixed_width',$scope) || 'none';
    if ($width eq 'none') {
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
    if ($style eq 'none') {
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

sub tag_lightbox_script {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $script = $plugin->get_config_value('lightbox_script',$scope) || 'slimbox';
    return $script;
}

sub tag_lightbox_selector {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $selector = $plugin->get_config_value('lightbox_selector',$scope) || 'rel="lightbox"';
    return $selector;
}

sub modifier_adjust_hn {
    my ($text, $val) = @_;
    if ( $val ) {
        $text =~ s/(<\/?[hH])([2-5])([ >])/&_increment($1,$2,$3);/eg;
    }
    return $text;
}

sub _increment {
    my ($htag,$leveln,$tail) = @_;
    $leveln += 1;
    return $htag.$leveln.$tail;
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

            my $insert_options = '';
            my $lb_select1 = $plugin->get_config_value('lb_select1',$scope);
            my $lightbox_selector1 = MT::Util::encode_html($plugin->get_config_value('lightbox_selector1',$scope),1);
            if (($lb_select1) && ($lightbox_selector1)) {
                $insert_options .= '<option value="' . $lightbox_selector1 . '">' . $lightbox_selector1 . '</option>' . "\n";
            }
            my $lb_select2 = $plugin->get_config_value('lb_select2',$scope);
            my $lightbox_selector2 = MT::Util::encode_html($plugin->get_config_value('lightbox_selector2',$scope),1);
            if (($lb_select2) && ($lightbox_selector2)) {
                $insert_options .= '<option value="' . $lightbox_selector2 . '">' . $lightbox_selector2 . '</option>' . "\n";
            }
            my $lb_select3 = $plugin->get_config_value('lb_select3',$scope);
            my $lightbox_selector3 = MT::Util::encode_html($plugin->get_config_value('lightbox_selector3',$scope),1);
            if (($lb_select3) && ($lightbox_selector3)) {
                $insert_options .= '<option value="' . $lightbox_selector3 . '">' . $lightbox_selector3 . '</option>' . "\n";
            }
            my $lb_select4 = $plugin->get_config_value('lb_select4',$scope);
            my $lightbox_selector4 = MT::Util::encode_html($plugin->get_config_value('lightbox_selector4',$scope),1);
            if (($lb_select4) && ($lightbox_selector4)) {
                $insert_options .= '<option value="' . $lightbox_selector4 . '">' . $lightbox_selector4 . '</option>' . "\n";
            }
            if ($insert_options eq '') {
                $insert_options .= '<option value="rel=&quot;lightbox&quot;">rel=&quot;lightbox&quot;</option>' . "\n";
            }

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
                onclick="if(this.checked){document.getElementById('create_thumbnail').checked=true;
                document.getElementById('thumb_width').focus();
                }else{
                document.getElementById('create_thumbnail').checked=false;}"
                value="1"<mt:if name="make_thumb"> checked="checked" </mt:if> />
            <label for="insert_lightbox"><__trans_section component="mtVicunaSimple"><__trans phrase='Use Lightbox Effect'></__trans_section></label>
            <br />
            <select id="insert_class" name="insert_class">
                $insert_options
            </select>
HTML
            $tmpl->insertBefore($opt, $el);
            $tmpl->rescan();
        }
    }
}

sub _asset_insert_param {
    my ( $cb, $app, $param, $tmpl ) = @_;
    my $blog_id = $app->param('blog_id');
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$blog_id;
    my $cleanup_insert = $plugin->get_config_value('cleanup_insert',$scope);
    if ($cleanup_insert) {
        my $rightalign_class = $plugin->get_config_value('rightalign_class',$scope);
        my $centeralign_class = $plugin->get_config_value('centeralign_class',$scope);
        my $leftalign_class = $plugin->get_config_value('leftalign_class',$scope);
        my $upload_html = $param->{ upload_html };
        my $wrap;
            if ($cleanup_insert == '1' || $cleanup_insert == '') {
            if ($upload_html =~ / class=\"mt-image-left\"/) {
                $wrap = '<p class="'.$leftalign_class.'">';
                if ($cleanup_insert == '') {
                    $wrap = '<p class="img_L">';
                }
            }
            if ($upload_html =~ / class=\"mt-image-right\"/) {
                $wrap = '<p class="'.$rightalign_class.'">';
                if ($cleanup_insert == '') {
                    $wrap = '<p class="img_R">';
                }
            }
            if ($upload_html =~ / class=\"mt-image-center\"/) {
                if ($centeralign_class) {
                    $wrap = '<p class="'.$centeralign_class.'">';
                } else {
                    $wrap = '<p>';
                }
                if ($cleanup_insert == '') {
                    $wrap = '<p>';
                }
            }
        }
        my $insert_class = $app->param('insert_class');
        if ( $app->param('insert_lightbox') ) {
            $insert_class = '<a '.$insert_class;
            $upload_html =~ s/<a/$insert_class/g;
        }
        if ($cleanup_insert == '2') {
            $upload_html =~ s/ class=\"mt-image-none\"//i;
            $rightalign_class = ' class="'.$rightalign_class.'"';
            $upload_html =~ s/ class=\"mt-image-right\"/$rightalign_class/g;
            $leftalign_class = ' class="'.$leftalign_class.'"';
            $upload_html =~ s/ class=\"mt-image-left\"/$leftalign_class/g;
            if ($centeralign_class) {
                $centeralign_class = ' class="'.$centeralign_class.'"';
            }
            $upload_html =~ s/ class=\"mt-image-center\"/$centeralign_class/g;
        } else {
            $upload_html =~ s/ class=\"mt-image-(none|right|left|center)\"//i;
        }
        $upload_html =~ s/ style=\"\"//i;
        $upload_html =~ s/ style=\"float\: (right|left)\; margin\: 0 (0|20px) 20px (0|20px)\;\"//i;
        $upload_html =~ s/ style=\"text-align\: center\; display\: block\; margin\: 0 auto 20px\;\"//i;
        if ($wrap) {
            $upload_html = $wrap.$upload_html.'</p>';
        }
        $param->{ upload_html } = $upload_html;
    }
}

sub _edit_themeparams {
    my $app = shift;
    my $blog_id = $app->param('blog_id');
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$blog_id;
    my $index_style       = $plugin->get_config_value('index_style',$scope);
    my $entry_style       = $plugin->get_config_value('entry_style',$scope);
    my $monthly_style     = $plugin->get_config_value('monthly_style',$scope);
    my $category_style    = $plugin->get_config_value('category_style',$scope);
    my $archive_style     = $plugin->get_config_value('archive_style',$scope);
    my $index_eyecatch    = $plugin->get_config_value('index_eyecatch',$scope);
    my $entry_eyecatch    = $plugin->get_config_value('entry_eyecatch',$scope);
    my $category_eyecatch = $plugin->get_config_value('category_eyecatch',$scope);
    my $monthly_eyecatch  = $plugin->get_config_value('monthly_eyecatch',$scope);
    my $archive_eyecatch  = $plugin->get_config_value('archive_eyecatch',$scope);
    my $vicuna_skin_layout  = tag_blog_skin_layout();
    my $fixed_width       = $plugin->get_config_value('fixed_width',$scope);
    my $cloud_style       = $plugin->get_config_value('cloud_style',$scope);
    my $navi_on_top       = $plugin->get_config_value('navi_on_top',$scope);
    my $hide_navi         = $plugin->get_config_value('hide_navi',$scope);
    my $left_align        = $plugin->get_config_value('left_align',$scope);
    $app->load_tmpl( 'dialog/edit_layout.tmpl', {
        index_style       => $index_style,
        entry_style       => $entry_style,
        monthly_style     => $monthly_style,
        category_style    => $category_style,
        archive_style     => $archive_style,
        index_eyecatch    => $index_eyecatch,
        entry_eyecatch    => $entry_eyecatch,
        category_eyecatch => $category_eyecatch,
        monthly_eyecatch  => $monthly_eyecatch,
        archive_eyecatch  => $archive_eyecatch,
        vicuna_skin_layout  => $vicuna_skin_layout,
        fixed_width       => $fixed_width,
        cloud_style       => $cloud_style,
        navi_on_top       => $navi_on_top,
        hide_navi         => $hide_navi,
        left_align        => $left_align } );
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