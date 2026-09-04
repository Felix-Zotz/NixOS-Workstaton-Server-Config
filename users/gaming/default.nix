{ ... }:

{
  users.users.gaming = {
    isNormalUser = true;
    description = "Gaming";
    extraGroups = [ "video" "render" "input" ];
  };

  home-manager.users.gaming = {
    imports = [
      ../../modules/home/shell.nix
      ../../modules/home/gaming.nix
    ];
    home.stateVersion = "26.05";
  };
}
