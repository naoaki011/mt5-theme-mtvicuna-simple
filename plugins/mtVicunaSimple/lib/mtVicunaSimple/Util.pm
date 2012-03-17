package mtVicunaSimple::Util;

use strict;
use MT 5;

sub _if_vicuna {
    my $app = MT->instance;
    my $blog = $app->blog or return 0;
    return 1 if ($blog->theme_id eq 'mtVicunaSimple');
    return 0;
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
    my $vicuna_skin_layout  = _blog_skin_layout();
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
        left_align        => $left_align
    } );
}

sub _blog_skin_layout {
    my $app = MT->instance;
    my $blog = $app->blog;
    return $blog->page_layout;
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