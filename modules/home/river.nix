{ pkgs, ... }:

let
  terminal = "${pkgs.ghostty}/bin/ghostty";
in
{
  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = false;
    };
  };

  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      #!/bin/sh
      riverctl map normal Super Return spawn '${terminal}'
      riverctl map normal Super Q close
      riverctl map normal Super+Shift E exit

      riverctl border-width 2
      riverctl background-color 0x002b36

      riverctl keyboard-layout us
    '';
  };
}
