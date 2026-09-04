{ pkgs, ... }:

{
  # Minimal starting point - fill in what you actually run.
  home.packages = with pkgs; [
    # steam
    # gamemode
  ];

  # NOTE: this host currently has services.xserver.enable = false and
  # no Wayland compositor installed (see modules/nixos/core.nix and
  # your original config). A "gaming" user needs *some* way to get
  # pixels on a screen - local GPU passthrough to a monitor, or
  # something like Sunshine/Moonlight for remote play into this
  # headless box. Neither is set up yet; this file only prepares the
  # user-level package set, not the display path. Decide that
  # separately before this user is actually usable for gaming.
}
