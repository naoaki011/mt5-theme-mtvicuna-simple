package mtVicunaSimple::Plugin;

use strict;
use MT 5;
use MT::Util qw( encode_html );

sub _asset_options_image {
    my ( $cb, $app, $param, $tmpl ) = @_;
    my $blog = $app->blog
      or return;
    my $blog_id = $app->param('blog_id')
      or return;
    return unless ($blog_id == $blog->id);
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$blog_id;
    my $slimbox = $plugin->get_config_value('use_slimbox',$scope);
    if ($slimbox ne '') {
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
    my $blog = $app->blog
      or return;
    my $blog_id = $app->param('blog_id')
      or return;
    return unless ($blog_id == $blog->id);
    my $plugin = MT->component("mtVicunaSimple");
    my $scope = "blog:".$blog_id;
    return unless ($blog->theme_id eq 'mtVicunaSimple');

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

sub _blog_template_set_change {
    my ($cb, $param) = @_;
#    my $blog = $param->{blog}
#      or return;
}

sub _post_apply_theme {
    my ($cb, $theme, $blog) = @_;
    my $app = MT->instance();
    return if $app->mode eq 'refresh_all_templates';
    return if $app->mode eq 'apply_theme';
    return if ($theme->id ne 'mtVicunaSimple');
    $blog->page_layout('vega');
    $blog->save;
}

sub _post_save_blog {
    my ($cb, $app, $obj, $original) = @_;
#    my $blog = $app->blog;
#    if ($blog->id ne $obj->id) { # is new
#        $blog = $obj;
#    }
#    return 1;
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