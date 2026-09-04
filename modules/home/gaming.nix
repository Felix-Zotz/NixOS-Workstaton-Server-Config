{ pkgs, ... }:

{
  # Minimal starting point - fill in what you actually run.
  home.packages = with pkgs; [
    # steam
    # gamemode
  ];

  # Display path is now river (modules/home/river.nix), started
  # manually from the TTY. That gets you a screen locally at the
  # server, not remote play.
}
