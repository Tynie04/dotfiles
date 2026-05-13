{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    configType = "hyprlang";

    settings = {
      monitor = ",preferred,auto,1";

      "$terminal"    = "kitty";
      "$fileManager" = "dolphin";
      "$menu"        = "rofi -show drun";
      "$mainMod"     = "SUPER";

      exec-once = [
        "hyprpaper"
        "waybar"
        "hyprctl setcursor Bibata-Modern-Ice 24"
        "copyq"
        "dunst"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Ice"
      ];

      general = {
        gaps_in                = 5;
        gaps_out               = 20;
        border_size            = 2;
        "col.active_border"    = "rgba(8caaeeee) rgba(99d1dbee) 45deg";
        "col.inactive_border"  = "rgba(51576daa)";
        resize_on_border       = false;
        allow_tearing          = false;
        layout                 = "dwindle";
      };

      decoration = {
        rounding       = 10;
        rounding_power = 2;
        active_opacity   = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled      = true;
          range        = 4;
          render_power = 3;
          color        = "rgba(1a1a1aee)";
        };

        blur = {
          enabled   = true;
          size      = 3;
          passes    = 1;
          vibrancy  = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global,1,10,default"
          "border,1,5.39,easeOutQuint"
          "windows,1,4.79,easeOutQuint"
          "windowsIn,1,4.1,easeOutQuint,popin 87%"
          "windowsOut,1,1.49,linear,popin 87%"
          "fadeIn,1,1.73,almostLinear"
          "fadeOut,1,1.46,almostLinear"
          "fade,1,3.03,quick"
          "layers,1,3.81,easeOutQuint"
          "layersIn,1,4,easeOutQuint,fade"
          "layersOut,1,1.5,linear,fade"
          "fadeLayersIn,1,1.79,almostLinear"
          "fadeLayersOut,1,1.39,almostLinear"
          "workspaces,1,1.94,almostLinear,fade"
          "workspacesIn,1,1.21,almostLinear,fade"
          "workspacesOut,1,1.94,almostLinear,fade"
          "zoomFactor,1,7,quick"
        ];
      };

      dwindle = {
        pseudotile    = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo   = false;
      };

      input = {
        numlock_by_default = true;
        kb_layout          = "be";
        follow_mouse       = 1;
        sensitivity        = 0;

        touchpad = {
          natural_scroll = true;
        };
      };

      device = {
        name        = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, exec, copyq toggle"
        "$mainMod SHIFT, F, togglefloating,"
        "$mainMod, space, exec, $menu"
        "$mainMod, D, workspace, previous"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, F, fullscreen, 0"
        ", Print, exec, bash -c \"grim -g \\\"$(slurp)\\\" - | tee ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy\""
        "$mainMod SHIFT, S, exec, bash -c \"grim -g \\\"$(slurp)\\\" - | tee ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy\""
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"
        "$mainMod, ampersand,  workspace, 1"
        "$mainMod, eacute,     workspace, 2"
        "$mainMod, quotedbl,   workspace, 3"
        "$mainMod, apostrophe, workspace, 4"
        "$mainMod, parenleft,  workspace, 5"
        "$mainMod, section,    workspace, 6"
        "$mainMod, egrave,     workspace, 7"
        "$mainMod, exclam,     workspace, 8"
        "$mainMod, ccedilla,   workspace, 9"
        "$mainMod, agrave,     workspace, 10"
        "$mainMod SHIFT, ampersand,  movetoworkspace, 1"
        "$mainMod SHIFT, eacute,     movetoworkspace, 2"
        "$mainMod SHIFT, quotedbl,   movetoworkspace, 3"
        "$mainMod SHIFT, apostrophe, movetoworkspace, 4"
        "$mainMod SHIFT, parenleft,  movetoworkspace, 5"
        "$mainMod SHIFT, section,    movetoworkspace, 6"
        "$mainMod SHIFT, egrave,     movetoworkspace, 7"
        "$mainMod SHIFT, exclam,     movetoworkspace, 8"
        "$mainMod SHIFT, ccedilla,   movetoworkspace, 9"
        "$mainMod SHIFT, agrave,     movetoworkspace, 10"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up,   workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp,   exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext,  exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay,  exec, playerctl play-pause"
        ", XF86AudioPrev,  exec, playerctl previous"
      ];

    };

    extraConfig = ''
      windowrule {
        name = suppress-maximize
        match:class = .*
        suppress_event = maximize
      }

      windowrule {
        name = copyq
        match:class = ^(com.github.hluk.copyq)$
        float = yes
        size = 600 500
        center = yes
      }

      windowrule {
        name = fix-xwayland-drags
        match:class = ^$
        match:title = ^$
        match:xwayland = true
        match:float = true
        match:fullscreen = false
        match:pin = false
        no_focus = true
      }
    '';
  };
}
