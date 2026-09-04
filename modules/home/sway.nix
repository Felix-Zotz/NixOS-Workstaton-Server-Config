{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = false;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      terminal = "${pkgs.ghostty}/bin/ghostty";
    };
  };
}
