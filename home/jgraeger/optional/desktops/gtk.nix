{pkgs, ...}: let

  css = ''
        @define-color accent_color #abc7ff;
    @define-color accent_fg_color #001b3f;
    @define-color accent_bg_color #abc7ff;
    @define-color window_bg_color #111318;
    @define-color window_fg_color #e2e2e9;
    @define-color headerbar_bg_color #111318;
    @define-color headerbar_fg_color #e2e2e9;
    @define-color popover_bg_color #111318;
    @define-color popover_fg_color #e2e2e9;
    @define-color view_bg_color #111318;
    @define-color view_fg_color #e2e2e9;
    @define-color card_bg_color #111318;
    @define-color card_fg_color #e2e2e9;
    @define-color sidebar_bg_color @window_bg_color;
    @define-color sidebar_fg_color @window_fg_color;
    @define-color sidebar_border_color @window_bg_color;
    @define-color sidebar_backdrop_color @window_bg_color;
  '';
  
in {
  gtk = {
    enable = true;

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = "1";

        gtk-toolbar-style = "GTK_TOOLBAR_ICONS";
        gtk-toolbar-icon-size="GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = "0";
        gtk-menu-images = "0";
        gtk-enable-event-sounds = "1";
        gtk-enable-input-feedback-sounds = "0";

        gtk-xft-antialias = "1";
        gtk-xft-hinting = "1";
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgba";  
      };
      extraCss = css;
    };

    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = "1";
      };
      extraCss = css;
    };

    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };

    font = {
      name = "Cantarell 11";
      package = pkgs.cantarell-fonts;
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

  };

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
