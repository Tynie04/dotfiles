{ ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
      };

      background = [
        {
          monitor     = "";
          path        = "~/dotfiles/wallpapers/Sollee.png";
          blur_passes = 3;
          blur_size   = 5;
          brightness  = 0.6;
        }
      ];

      input-field = [
        {
          monitor           = "";
          size              = "300, 50";
          outline_thickness = 2;
          dots_size         = 0.25;
          dots_spacing      = 0.2;
          outer_color       = "rgb(8caaee)";
          inner_color       = "rgb(101010)";
          font_color        = "rgb(c6d0f5)";
          fade_on_empty     = true;
          placeholder_text  = ''<span foreground="##737994">password...</span>'';
          fail_color        = "rgb(e78284)";
          fail_text         = ''<span foreground="##e78284">$FAIL ($ATTEMPTS)</span>'';
          check_color       = "rgb(e5c890)";
          capslock_color    = "rgb(e78284)";
          position          = "0, -80";
          halign            = "center";
          valign            = "center";
          rounding          = 10;
        }
      ];

      label = [
        {
          monitor     = "";
          text        = "$TIME";
          color       = "rgba(c6d0f5ee)";
          font_size   = 72;
          font_family = "JetBrainsMono Nerd Font";
          position    = "0, 120";
          halign      = "center";
          valign      = "center";
        }
        {
          monitor     = "";
          text        = ''cmd[update:60000] date +"%A, %d %B %Y"'';
          color       = "rgba(babbf1aa)";
          font_size   = 18;
          font_family = "JetBrainsMono Nerd Font";
          position    = "0, 60";
          halign      = "center";
          valign      = "center";
        }
        {
          monitor     = "";
          text        = "$USER";
          color       = "rgba(8caaeecc)";
          font_size   = 16;
          font_family = "JetBrainsMono Nerd Font";
          position    = "0, 20";
          halign      = "center";
          valign      = "center";
        }
      ];
    };
  };
}
