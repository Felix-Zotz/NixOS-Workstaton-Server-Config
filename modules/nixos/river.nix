{ pkgs, ... }:

{
  programs.river-classic.enable = true;
  services.seatd.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };

  security.polkit.enable = true;
}
