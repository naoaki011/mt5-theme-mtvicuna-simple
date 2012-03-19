package mtVicunaSimple::Tags;

use strict;
use MT 5;

sub theme_version {
    require MT::Theme;
    my $theme = MT::Theme->load('mtVicunaSimple');
    my $theme_version = $theme->version;
    return $theme_version;
}

sub index_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('index_style',$scope) || 'double';
    return $style;
}

sub entry_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('entry_style',$scope) || 'single';
    return $style;
}

sub monthly_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('monthly_style',$scope) || 'double';
    return $style;
}

sub category_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('category_style',$scope) || 'double';
    return $style;
}

sub archive_style {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $style = $plugin->get_config_value('archive_style',$scope) || 'single';
    return $style;
}

sub index_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $eyecatch = $plugin->get_config_value('index_eyecatch',$scope) || 'eye-h';
    return ($eyecatch eq 'none') ? '' : $eyecatch;
}

sub entry_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $eyecatch = $plugin->get_config_value('entry_eyecatch',$scope) || 'eye-h';
    return ($eyecatch eq 'none') ? '' : $eyecatch;
}

sub category_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $eyecatch = $plugin->get_config_value('category_eyecatch',$scope) || 'eye-h';
    return ($eyecatch eq 'none') ? '' : $eyecatch;
}

sub monthly_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $eyecatch = $plugin->get_config_value('monthly_eyecatch',$scope) || 'eye-h';
    return ($eyecatch eq 'none') ? '' : $eyecatch;
}

sub archive_eyecatch {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $eyecatch = $plugin->get_config_value('archive_eyecatch',$scope) || 'eye-h';
    return ($eyecatch eq 'none') ? '' : $eyecatch;
}

sub fixed_width {
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

sub cloud_style {
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
    my $slimbox = $plugin->get_config_value('use_slimbox',$scope);
    if ($slimbox) {
        return 1;
    }
    else {
        if ($slimbox == '0') {
            return 0;
        }
    }
    return 1;
}

sub lightbox_script {
    my ( $ctx, $args ) = @_;
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$ctx->stash('blog_id');
    my $script = $plugin->get_config_value('lightbox_script',$scope) || 'slimbox';
    return $script;
}

sub lightbox_selector {
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

sub convert_breaks {
    my ( $ctx, $args ) = @_;
    my $entry = $ctx->stash('entry')
        or return $ctx->_no_entry_error();
    my $convert_breaks = $entry->convert_breaks ? $entry->convert_breaks : 0;
    return $convert_breaks;
}

1;